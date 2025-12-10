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
var pdfContainer = document.getElementById("pdfContainer");
var pdfViewer = document.getElementById("pdfViewer");
var runner = new WebPerlRunner({
  webperlBasePath: "./vendor/wasm-latex-tools/webperl",
  perlScriptsPath: "./vendor/wasm-latex-tools/perl"
});
var originalConsoleError = console.error;
console.error = function(...args) {
  const message = String(args[0] || "");
  if (message.includes("Could not create /tmp") || message.includes("Could not create /home") || message.includes("mkdir failed for /tmp") || message.includes("FS is not defined") || message.includes("JSON.parse: unexpected character")) {
    return;
  }
  originalConsoleError.apply(console, args);
};
var originalConsoleLog = console.log;
console.log = function(...args) {
  const message = String(args[0] || "");
  if (message.includes("Could not create") || message.includes("mkdir failed")) {
    return;
  }
  originalConsoleLog.apply(console, args);
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
        console.log("PDFTeX is ready!");
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
  const parts = dataURL.split(",");
  const contentType = parts[0].split(":")[1].split(";")[0];
  const raw = window.atob(parts[1]);
  const rawLength = raw.length;
  const uInt8Array = new Uint8Array(rawLength);
  for (let i = 0; i < rawLength; ++i) {
    uInt8Array[i] = raw.charCodeAt(i);
  }
  return new Blob([uInt8Array], { type: contentType });
}
async function compilePdf(diffTex) {
  const PDFTeX = window.PDFTeX;
  if (!PDFTeX) {
    throw new Error("PDFTeX not available.");
  }
  console.log("Creating PDFTeX engine...");
  try {
    const workerPath = window.TEXLIVE_CONFIG?.workerPath || "./vendor/texlive.js/pdftex-worker.js";
    const engine = new PDFTeX(workerPath);
    console.log("Compiling LaTeX...");
    console.log("LaTeX source length:", diffTex.length);
    const pdfDataUrl = await engine.compile(diffTex);
    if (!pdfDataUrl || pdfDataUrl === "false") {
      throw new Error("Compilation failed - no PDF produced. This may be due to missing LaTeX packages in the texlive distribution.");
    }
    console.log("PDF compiled successfully, converting to blob URL");
    const blob = dataURLtoBlob(pdfDataUrl);
    const blobUrl = URL.createObjectURL(blob);
    return blobUrl;
  } catch (error) {
    console.error("PDFTeX compilation error:", error);
    throw new Error(`PDF compilation failed: ${error instanceof Error ? error.message : String(error)}`);
  }
}
async function generateDiffPdf() {
  console.log("Clicked...");
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
    console.log("Running diff with options:", {
      type: "UNDERLINE",
      flatten: true
    });
    const diff = await diffTool.diff(oldWrapped, newWrapped, {
      type: "UNDERLINE",
      flatten: true
    });
    console.log("Diff completed, output length:", diff.output.length);
    let simplifiedDiff = diff.output.replace(/\\usepackage\[T1\]\{fontenc\}/g, "").replace(/\\usepackage\{lmodern\}/g, "");
    console.log("Simplified diff for compilation");
    setStatus("Compiling PDF...");
    const pdfBlobUrl = await compilePdf(simplifiedDiff);
    console.log("PDF compiled, displaying...");
    if (pdfViewer.src && pdfViewer.src.startsWith("blob:")) {
      URL.revokeObjectURL(pdfViewer.src);
    }
    pdfViewer.src = pdfBlobUrl;
    pdfContainer.style.display = "block";
    setStatus("PDF generated successfully!");
  } catch (e) {
    console.error("Error details:", e);
    const errorMsg = e instanceof Error ? e.message : String(e);
    setStatus(`Error: ${errorMsg}`);
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
safeInit();
