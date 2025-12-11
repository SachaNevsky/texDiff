// node_modules/wasm-latex-tools/dist/index.js
var Logger = class {
  constructor(verbose = false) {
    this.verbose = verbose;
  }
  debug(message, ...args) {
    if (this.verbose) {
      console.debug(`[WebPerl Debug] ${message}`, ...args);
    }
  }
  info(message, ...args) {
    console.info(`[WebPerl] ${message}`, ...args);
  }
  warn(message, ...args) {
    console.warn(`[WebPerl Warning] ${message}`, ...args);
  }
  error(message, ...args) {
    console.error(`[WebPerl Error] ${message}`, ...args);
  }
};
var ErrorHandler = class {
  static handle(error, context) {
    const message = this.getMessage(error);
    const fullMessage = context ? `${context}: ${message}` : message;
    return new Error(fullMessage);
  }
  static getMessage(error) {
    if (error instanceof Error) {
      return error.message;
    }
    return String(error);
  }
};
var WebPerlRunner = class {
  constructor(config = {}) {
    this.initialized = false;
    this.initializing = false;
    this.perlRunnerIframe = null;
    this.perlRunner = null;
    this.config = {
      webperlBasePath: config.webperlBasePath || "/core/webperl",
      perlScriptsPath: config.perlScriptsPath || "/core/perl",
      verbose: config.verbose ?? false
    };
    this.logger = new Logger(this.config.verbose);
  }
  async initialize() {
    if (this.initialized)
      return;
    if (this.initializing) {
      await this.waitForInitialization();
      return;
    }
    this.initializing = true;
    this.logger.info("Initializing WebPerl...");
    try {
      await this.loadPerlRunner();
      this.initialized = true;
      this.logger.info("WebPerl initialized successfully");
    } catch (error) {
      this.initializing = false;
      throw ErrorHandler.handle(error, "Failed to initialize WebPerl");
    } finally {
      this.initializing = false;
    }
  }
  async loadPerlRunner() {
    return new Promise((resolve, reject) => {
      const timeout = setTimeout(() => {
        reject(new Error("Timeout waiting for Perl runner to initialize"));
      }, 3e4);
      const messageHandler = (event) => {
        const data = event.data;
        if (data.perlRunnerState === "Ready") {
          clearTimeout(timeout);
          window.removeEventListener("message", messageHandler);
          this.perlRunner = event.source;
          this.logger.debug("Perl runner is ready");
          resolve();
        }
      };
      window.addEventListener("message", messageHandler);
      this.perlRunnerIframe = document.createElement("iframe");
      this.perlRunnerIframe.name = "perlrunner";
      this.perlRunnerIframe.src = `${this.config.webperlBasePath}/perlrunner.html`;
      this.perlRunnerIframe.style.display = "none";
      this.perlRunnerIframe.onerror = () => {
        clearTimeout(timeout);
        window.removeEventListener("message", messageHandler);
        reject(new Error(`Failed to load ${this.config.webperlBasePath}/perlrunner.html`));
      };
      document.body.appendChild(this.perlRunnerIframe);
      const pollForRunner = setInterval(() => {
        const runnerFrame = this.perlRunnerIframe?.contentWindow;
        if (runnerFrame) {
          runnerFrame.postMessage({ perlRunnerDiscovery: 1 }, "*");
        }
      }, 100);
      setTimeout(() => clearInterval(pollForRunner), 3e4);
    });
  }
  async waitForInitialization() {
    while (this.initializing) {
      await new Promise((resolve) => setTimeout(resolve, 100));
    }
    if (!this.initialized) {
      throw new Error("WebPerl initialization failed");
    }
  }
  async runScript(argv, inputs, outputs, workingDir) {
    if (!this.initialized || !this.perlRunner) {
      throw new Error("WebPerl not initialized. Call initialize() first.");
    }
    const sortedInputs = this.sortInputsByDepth(inputs || []);
    return new Promise((resolve, reject) => {
      let stdout = "";
      let stderr = "";
      let exitStatus = 0;
      const outputFiles = [];
      const messageHandler = (event) => {
        const data = event.data;
        if (data.perlOutput) {
          if (data.perlOutput.chan === 1) {
            stdout += data.perlOutput.data;
          } else if (data.perlOutput.chan === 2) {
            stderr += data.perlOutput.data;
          }
        } else if (data.perlOutputFiles) {
          outputFiles.push(...data.perlOutputFiles);
        } else if (data.perlRunnerState === "Ended") {
          window.removeEventListener("message", messageHandler);
          if ("exitStatus" in data) {
            exitStatus = data.exitStatus;
          }
          if (outputFiles.length > 0) {
            stdout = outputFiles[0].text;
          }
          resolve({
            success: exitStatus === 0,
            output: stdout,
            error: stderr || void 0,
            exitCode: exitStatus
          });
        } else if (data.perlRunnerError) {
          window.removeEventListener("message", messageHandler);
          reject(new Error(data.perlRunnerError));
        }
      };
      window.addEventListener("message", messageHandler);
      const runData = { argv };
      if (sortedInputs.length > 0)
        runData.inputs = sortedInputs;
      if (outputs)
        runData.outputs = outputs;
      if (workingDir)
        runData.cwd = workingDir;
      if (!this.perlRunner) {
        window.removeEventListener("message", messageHandler);
        reject(new Error("Perl runner not available"));
        return;
      }
      this.perlRunner.postMessage({ runPerl: runData }, "*");
      setTimeout(() => {
        window.removeEventListener("message", messageHandler);
        reject(new Error("Timeout waiting for script execution"));
      }, 6e4);
    });
  }
  sortInputsByDepth(inputs) {
    return inputs.slice().sort((a, b) => {
      const depthA = a.fn.split("/").length;
      const depthB = b.fn.split("/").length;
      return depthA - depthB;
    });
  }
  isInitialized() {
    return this.initialized;
  }
  getConfig() {
    return { ...this.config };
  }
};
var BaseTool = class {
  constructor(runner2, verbose = false) {
    this.filesLoaded = false;
    this.preloadedFiles = [];
    this.runner = runner2;
    this.logger = new Logger(verbose);
  }
  async ensureLoaded() {
    if (!this.runner.isInitialized()) {
      await this.runner.initialize();
    }
    if (!this.filesLoaded) {
      await this.fetchAllFiles();
      this.filesLoaded = true;
    }
  }
  async fetchAllFiles() {
    const config = this.runner.getConfig();
    const filesToLoad = [
      { path: this.getScriptPath(), virtual: this.getScriptPath() },
      ...this.getDependencyPaths().map((path) => ({ path, virtual: path }))
    ];
    const inputs = [];
    for (const file of filesToLoad) {
      const url = `${config.perlScriptsPath}${file.path}`;
      this.logger.debug(`Fetching file from ${url}`);
      try {
        const resp = await fetch(url);
        if (!resp.ok)
          throw new Error(`HTTP ${resp.status}: ${resp.statusText}`);
        const content = await resp.text();
        inputs.push({ fn: file.virtual, text: content });
        this.logger.debug(`Fetched: ${file.path}`);
      } catch (err) {
        throw new Error(`Failed to load file ${file.path}: ${err}`);
      }
    }
    this.preloadedFiles = inputs;
  }
  async executeLatexDiff(options) {
    await this.ensureLoaded();
    const t = Date.now();
    const oldPath = `/tmp/old_${t}.tex`;
    const newPath = `/tmp/new_${t}.tex`;
    const outputPath = `/tmp/diff_${t}.tex`;
    const args = this.buildArguments(oldPath, newPath, outputPath, options);
    const inputs = [
      ...this.preloadedFiles,
      { fn: oldPath, text: options.oldContent },
      { fn: newPath, text: options.input }
    ];
    const outputs = [outputPath];
    return this.runner.runScript(args, inputs, outputs);
  }
  async executeScript(options) {
    await this.ensureLoaded();
    const t = Date.now();
    const inputPath = `/tmp/input_${t}.tex`;
    const outputPath = `/tmp/output_${t}.tex`;
    const args = this.buildArguments(inputPath, "", outputPath, options);
    const inputs = [
      ...this.preloadedFiles,
      { fn: inputPath, text: options.input }
    ];
    const outputs = [outputPath];
    return this.runner.runScript(args, inputs, outputs);
  }
};
var LatexDiff = class extends BaseTool {
  getScriptPath() {
    return "/latexdiff.pl";
  }
  getDependencyPaths() {
    return [];
  }
  async diff(oldContent, newContent, options) {
    const mergedOptions = {
      input: newContent,
      oldContent,
      ...options
    };
    return this.executeLatexDiff(mergedOptions);
  }
  async executeLatexDiff(options) {
    await this.ensureLoaded();
    const t = Date.now();
    const oldPath = `/tmp/old_${t}.tex`;
    const newPath = `/tmp/new_${t}.tex`;
    const outputPath = `/tmp/diff_${t}.tex`;
    const args = this.buildArguments(oldPath, newPath, outputPath, options);
    const inputs = [
      ...this.preloadedFiles,
      { fn: oldPath, text: options.oldContent },
      { fn: newPath, text: options.input }
    ];
    const outputs = [outputPath];
    return this.runner.runScript(args, inputs, outputs);
  }
  buildArguments(oldPath, newPath, outputPath, options) {
    const diffOptions = options;
    const scriptPath = this.getScriptPath();
    const args = [scriptPath];
    if (diffOptions.type)
      args.push(`--type=${diffOptions.type}`);
    if (diffOptions.subtype)
      args.push(`--subtype=${diffOptions.subtype}`);
    if (diffOptions.floattype)
      args.push(`--floattype=${diffOptions.floattype}`);
    if (diffOptions.encoding)
      args.push(`--encoding=${diffOptions.encoding}`);
    if (diffOptions.excludeSafecmd)
      args.push(`--exclude-safecmd=${diffOptions.excludeSafecmd}`);
    if (diffOptions.appendSafecmd)
      args.push(`--append-safecmd=${diffOptions.appendSafecmd}`);
    if (diffOptions.excludeTextcmd)
      args.push(`--exclude-textcmd=${diffOptions.excludeTextcmd}`);
    if (diffOptions.appendTextcmd)
      args.push(`--append-textcmd=${diffOptions.appendTextcmd}`);
    if (diffOptions.mathMarkup !== void 0)
      args.push(`--math-markup=${diffOptions.mathMarkup}`);
    if (diffOptions.allowSpaces)
      args.push("--allow-spaces");
    if (diffOptions.flatten)
      args.push("--flatten");
    args.push(oldPath, newPath);
    return args;
  }
};

// main.ts
var statusEl = document.getElementById("status");
var oldInput = document.getElementById("oldInput");
var newInput = document.getElementById("newInput");
var diffBtn = document.getElementById("diffBtn");
var downloadTexBtn = document.getElementById("downloadTexBtn");
var pdfContainer = document.getElementById("pdfContainer");
var pdfViewer = document.getElementById("pdfViewer");
var runner = new WebPerlRunner({
  webperlBasePath: "./vendor/wasm-latex-tools/webperl",
  perlScriptsPath: "./vendor/wasm-latex-tools/perl"
});
var latestDiffTex = "";
var currentPdfBlobUrl = null;
window.addEventListener("error", (event) => {
  const message = event.message || "";
  const filename = event.filename || "";
  if (message.includes("JSON.parse: unexpected character") || message.includes("FS is not defined") || message.includes("Could not create /tmp") || message.includes("Could not create /home") || message.includes("mkdir failed") || filename.includes("pre.js") || filename.includes("post.js") || filename.includes("perlrunner.html")) {
    event.preventDefault();
    event.stopPropagation();
    return false;
  }
}, true);
window.addEventListener("unhandledrejection", (event) => {
  const reason = String(event.reason || "");
  if (reason.includes("Invalid PDF structure") || reason.includes("InvalidPDFException") || reason.includes("JSON.parse") || reason.includes("FS is not defined")) {
    event.preventDefault();
    return false;
  }
});
var originalConsoleError = console.error;
console.error = function(...args) {
  const message = String(args[0] || "");
  const stack = args[1] && typeof args[1] === "object" ? String(args[1].stack || "") : "";
  if (message.includes("Could not create /tmp") || message.includes("Could not create /home") || message.includes("mkdir failed") || message.includes("FS is not defined") || message.includes("JSON.parse: unexpected character") || message.includes("Invalid PDF structure") || message.includes("Invalid or corrupted PDF") || message.includes("InvalidPDFException") || stack.includes("pre.js") || stack.includes("post.js") || stack.includes("perlrunner.html")) {
    return;
  }
  originalConsoleError.apply(console, args);
};
var originalConsoleLog = console.log;
console.log = function(...args) {
  const message = String(args[0] || "");
  if (message.includes("Could not create") || message.includes("mkdir failed") || message.includes("asm.js is deprecated") || message.includes("LazyFiles on gzip") || message.includes("This is pdfTeX") || message.includes("restricted \\write18") || message.includes("entering extended mode") || message.includes("LaTeX2e") || message.includes("Document Class:") || message.includes("//texmf-dist/") || message.includes("./input.tex") || message.includes("Successfully compiled asm.js") || message.includes("No file input.aux") || message.includes("[Loading MPS to PDF converter") || message.includes("Output written on input.pdf") || message.includes("Transcript written on input.log") || message.match(/^\([\/\.]/) || // Lines starting with (/ or (.
  message.match(/^\)/) || // Lines starting with )
  message === "<empty string>") {
    return;
  }
  originalConsoleLog.apply(console, args);
};
var originalConsoleWarn = console.warn;
console.warn = function(...args) {
  const message = String(args[0] || "");
  if (message.includes("asm.js is deprecated") || message.includes("Invalid absolute docBaseUrl") || message.includes("Indexing all PDF objects") || message.includes("Warning:")) {
    return;
  }
  originalConsoleWarn.apply(console, args);
};
function setStatus(msg) {
  console.log("> ", msg);
  if (statusEl) statusEl.textContent = msg;
}
function ensureWrapped(content) {
  const hasDocClass = /\\documentclass/.test(content);
  const hasBeginDoc = /\\begin\{document\}/.test(content);
  const hasEndDoc = /\\end\{document\}/.test(content);
  if (hasDocClass && hasBeginDoc && hasEndDoc) return content;
  return [
    "\\documentclass{article}",
    "\\usepackage[utf8]{inputenc}",
    "\\begin{document}",
    content,
    "\\end{document}"
  ].join("\n");
}
async function initTools() {
  try {
    setStatus("Loading diff tools...");
    await runner.initialize();
    await waitForPDFTeX();
    setStatus("Ready.");
  } catch (e) {
    console.error(e);
    setStatus("Failed to initialize diff tools.");
  }
}
function waitForPDFTeX() {
  return new Promise((resolve, reject) => {
    let attempts = 0;
    const maxAttempts = 50;
    const checkPDFTeX = () => {
      if (window.PDFTeX) {
        resolve();
      } else if (attempts >= maxAttempts) {
        reject(new Error("PDFTeX failed to load"));
      } else {
        attempts++;
        setTimeout(checkPDFTeX, 100);
      }
    };
    checkPDFTeX();
  });
}
function dataURLtoBlob(dataURL) {
  try {
    const parts = dataURL.split(",");
    if (parts.length !== 2) {
      throw new Error("Invalid data URL format");
    }
    const mimeMatch = parts[0].match(/:(.*?);/);
    const contentType = mimeMatch ? mimeMatch[1] : "application/pdf";
    const base64Data = parts[1].trim().replace(/\s/g, "");
    const raw = window.atob(base64Data);
    const rawLength = raw.length;
    const uInt8Array = new Uint8Array(rawLength);
    for (let i = 0; i < rawLength; ++i) {
      uInt8Array[i] = raw.charCodeAt(i);
    }
    return new Blob([uInt8Array], { type: contentType });
  } catch (error) {
    console.error("Failed to convert data URL to blob:", error);
    throw new Error(`Data URL conversion failed: ${error}`);
  }
}
function cleanDiffTeX(diffTex) {
  let cleaned = diffTex;
  cleaned = cleaned.replace(/\\RequirePackage\{color\}/g, "\\usepackage{color}");
  cleaned = cleaned.replace(/\\usepackage\[T1\]\{fontenc\}/g, "").replace(/\\usepackage\{lmodern\}/g, "").replace(/\\usepackage\{textcomp\}/g, "").replace(/\\usepackage(\[.*?\])?\{ulem\}/g, "").replace(/\\usepackage(\[.*?\])?\{changebar\}/g, "");
  cleaned = cleaned.replace(
    /\\providecommand\{\\DIFdelFL\}\[1\]\{\{\\color\{red\}\{\\color\{red\}\[deleted: #1\]\}\}\}/g,
    "\\providecommand{\\DIFdelFL}[1]{{\\color{red}\\raisebox{1ex}{\\underline{\\smash{\\raisebox{-1ex}{#1}}}}}}"
  );
  cleaned = cleaned.replace(
    /\\providecommand\{\\DIFdel\}\[1\]\{\{\\protect\\color\{red\} \\scriptsize #1\}\}/g,
    "\\providecommand{\\DIFdel}[1]{{\\color{red}\\raisebox{1ex}{\\underline{\\smash{\\raisebox{-1ex}{#1}}}}}}"
  );
  return cleaned;
}
async function compilePdf(diffTex) {
  const PDFTeX = window.PDFTeX;
  if (!PDFTeX) {
    throw new Error("PDFTeX not available.");
  }
  try {
    const workerPath = window.TEXLIVE_CONFIG?.workerPath || "./vendor/texlive.js/pdftex-worker.js";
    const engine = new PDFTeX(workerPath);
    const cleanedTex = cleanDiffTeX(diffTex);
    latestDiffTex = cleanedTex;
    downloadTexBtn.style.display = "inline-block";
    console.log("Starting PDF compilation...");
    const pdfDataUrl = await engine.compile(cleanedTex);
    console.log("Compilation complete, data URL length:", pdfDataUrl?.length);
    if (!pdfDataUrl || pdfDataUrl === "false" || pdfDataUrl.length < 100) {
      throw new Error("Compilation failed - no valid PDF data produced");
    }
    if (!pdfDataUrl.startsWith("data:application/pdf") && !pdfDataUrl.startsWith("data:;base64,")) {
      console.error("Invalid data URL format:", pdfDataUrl.substring(0, 100));
      throw new Error("Invalid PDF data format returned");
    }
    const blob = dataURLtoBlob(pdfDataUrl);
    console.log("Created blob, size:", blob.size, "bytes");
    if (blob.size < 100) {
      throw new Error("Generated PDF is too small, likely corrupted");
    }
    if (currentPdfBlobUrl) {
      URL.revokeObjectURL(currentPdfBlobUrl);
    }
    const blobUrl = URL.createObjectURL(blob);
    currentPdfBlobUrl = blobUrl;
    return blobUrl;
  } catch (error) {
    console.error("PDFTeX compilation error:", error);
    throw new Error(`PDF compilation failed: ${error instanceof Error ? error.message : String(error)}`);
  }
}
function downloadTextFile(content, filename) {
  const blob = new Blob([content], { type: "text/plain;charset=utf-8" });
  const url = URL.createObjectURL(blob);
  const link = document.createElement("a");
  link.href = url;
  link.download = filename;
  document.body.appendChild(link);
  link.click();
  document.body.removeChild(link);
  URL.revokeObjectURL(url);
}
function openPdfInNewTab(blobUrl) {
  const newWindow = window.open(blobUrl, "_blank");
  if (!newWindow) {
    setStatus("PDF generated! Please allow pop-ups to view the PDF, or use the iframe below.");
    pdfViewer.src = blobUrl;
    pdfContainer.style.display = "block";
  } else {
    setStatus("PDF opened in new tab!");
    pdfViewer.src = blobUrl;
    pdfContainer.style.display = "block";
  }
}
async function generateDiffPdf() {
  const oldText = oldInput.value;
  const newText = newInput.value;
  if (!oldText.trim() || !newText.trim()) {
    setStatus("Both inputs are required.");
    return;
  }
  try {
    setStatus("Running latexdiff...");
    const diffTool = new LatexDiff(runner);
    const oldWrapped = ensureWrapped(oldText);
    const newWrapped = ensureWrapped(newText);
    const diff = await diffTool.diff(oldWrapped, newWrapped, {
      type: "CFONT",
      flatten: true
    });
    setStatus("Compiling PDF...");
    const pdfBlobUrl = await compilePdf(diff.output);
    openPdfInNewTab(pdfBlobUrl);
  } catch (e) {
    console.error("Error details:", e);
    const errorMsg = e instanceof Error ? e.message : String(e);
    setStatus(`Error: ${errorMsg}. Check diff.tex for details.`);
  }
}
var isInitializing = false;
var isInitialized = false;
async function safeInit() {
  if (isInitialized || isInitializing) return;
  isInitializing = true;
  try {
    await initTools();
    isInitialized = true;
  } catch (e) {
    console.error("Initialization failed:", e);
  } finally {
    isInitializing = false;
  }
}
diffBtn.addEventListener("click", generateDiffPdf);
downloadTexBtn.addEventListener("click", () => {
  if (latestDiffTex) {
    downloadTextFile(latestDiffTex, "diff.tex");
    setStatus("diff.tex downloaded! Compile this locally if PDF viewer issues persist.");
  } else {
    setStatus("No diff available to download. Generate a diff first.");
  }
});
safeInit();
