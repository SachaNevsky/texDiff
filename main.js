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
var TexCount = class extends BaseTool {
  getScriptPath() {
    return "/texcount.pl";
  }
  getDependencyPaths() {
    return [];
  }
  async count(options) {
    return this.executeScriptWithWorkDir(options);
  }
  async executeScriptWithWorkDir(options) {
    await this.ensureLoaded();
    const t = Date.now();
    const workDir = `/tmp/work_${t}`;
    const inputPath = `${workDir}/main.tex`;
    const outputPath = `/tmp/output_${t}.tex`;
    const args = this.buildArguments("main.tex", "", outputPath, options);
    const inputs = [
      ...this.preloadedFiles,
      { fn: inputPath, text: options.input }
    ];
    if (options.additionalFiles) {
      for (const file of options.additionalFiles) {
        const fullPath = `${workDir}/${file.path}`;
        inputs.push({ fn: fullPath, text: file.content });
      }
    }
    const outputs = [outputPath];
    return this.runner.runScript(args, inputs, outputs, workDir);
  }
  buildArguments(inputPath, newPath, outputPath, options) {
    const texOptions = options;
    const scriptPath = this.getScriptPath();
    const args = [scriptPath];
    if (texOptions.brief)
      args.push("-brief");
    if (texOptions.total)
      args.push("-total");
    if (texOptions.sum)
      args.push("-sum");
    if (texOptions.verbose !== void 0)
      args.push(`-v${texOptions.verbose}`);
    if (texOptions.includeFiles)
      args.push("-inc");
    if (texOptions.merge)
      args.push("-merge");
    if (texOptions.args)
      args.push(...texOptions.args);
    args.push(inputPath);
    return args;
  }
  parseOutput(output) {
    const lines = output.trim().split("\n");
    const result = {
      words: 0,
      headers: 0,
      captions: 0,
      raw: output
    };
    for (const line of lines) {
      if (line.includes("Words in text:")) {
        result.words = parseInt(line.split(":")[1].trim(), 10) || 0;
      } else if (line.includes("Words in headers:")) {
        result.headers = parseInt(line.split(":")[1].trim(), 10) || 0;
      } else if (line.includes("Words outside text")) {
        result.captions = parseInt(line.split(":")[1].trim(), 10) || 0;
      }
    }
    return result;
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
var oldWordCount = document.getElementById("oldWordCount");
var newWordCount = document.getElementById("newWordCount");
var runner = new WebPerlRunner({
  webperlBasePath: "./vendor/wasm-latex-tools/webperl",
  perlScriptsPath: "./vendor/wasm-latex-tools/perl"
});
var pdfEngine = null;
var texCount = null;
var latestDiffTex = "";
var currentPdfBlobUrl = null;
var oldCountTimer = null;
var newCountTimer = null;
window.addEventListener("error", (event) => {
  const message = event.message || "";
  const filename = event.filename || "";
  if (message.includes("Could not create /tmp") || message.includes("Could not create /home") || message.includes("mkdir failed") || filename.includes("perlrunner.html")) {
    event.preventDefault();
    event.stopPropagation();
    return false;
  }
}, true);
var originalConsoleLog = console.log;
console.log = function(...args) {
  const message = String(args[0] || "");
  if (message.includes("Could not create") || message.includes("mkdir failed")) {
    return;
  }
  originalConsoleLog.apply(console, args);
};
var originalConsoleWarn = console.warn;
console.warn = function(...args) {
  const message = String(args[0] || "");
  if (message.includes("Could not create /tmp") || message.includes("Could not create /home") || message.includes("Could not create /perl") || message.includes("mkdir failed")) {
    return;
  }
  originalConsoleWarn.apply(console, args);
};
function setStatus(msg) {
  if (statusEl) statusEl.textContent = msg;
}
function ensureWrapped(content) {
  const hasDocClass = /\\documentclass/.test(content);
  const hasBeginDoc = /\\begin\{document\}/.test(content);
  const hasEndDoc = /\\end\{document\}/.test(content);
  if (hasDocClass && hasBeginDoc && hasEndDoc) return content;
  const hasChapter = /\\chapter\{/.test(content);
  const docClass = hasChapter ? "report" : "article";
  return [
    `\\documentclass{${docClass}}`,
    "\\usepackage[utf8]{inputenc}",
    "\\begin{document}",
    content,
    "\\end{document}"
  ].join("\n");
}
async function runTexCount(content) {
  if (!content.trim()) {
    return 0;
  }
  if (!texCount) {
    return 0;
  }
  try {
    const wrappedContent = ensureWrapped(content);
    const result = await texCount.count({
      input: wrappedContent,
      brief: true
    });
    let wordCount = 0;
    const briefMatch = result.output.match(/^(\d+)\+(\d+)\+(\d+)/);
    if (briefMatch) {
      wordCount = parseInt(briefMatch[1], 10);
    } else {
      const parsed = texCount.parseOutput(result.output);
      wordCount = parsed.words || 0;
    }
    return wordCount;
  } catch (error) {
    console.error("Error running texcount:", error);
    return 0;
  }
}
function updateWordCount(element, count) {
  element.textContent = `Words: ${count}`;
}
function debouncedCountOld() {
  if (oldCountTimer) {
    clearTimeout(oldCountTimer);
  }
  oldCountTimer = setTimeout(async () => {
    const count = await runTexCount(oldInput.value);
    updateWordCount(oldWordCount, count);
  }, 500);
}
function debouncedCountNew() {
  if (newCountTimer) {
    clearTimeout(newCountTimer);
  }
  newCountTimer = setTimeout(async () => {
    const count = await runTexCount(newInput.value);
    updateWordCount(newWordCount, count);
  }, 500);
}
async function initTools() {
  try {
    setStatus("Loading diff tools...");
    await runner.initialize();
    texCount = new TexCount(runner);
    console.log("TexCount initialized:", texCount);
    setStatus("Initializing SwiftLaTeX...");
    await initSwiftLaTeX();
    setStatus("Ready.");
    if (oldInput.value.trim()) {
      const oldCount = await runTexCount(oldInput.value);
      updateWordCount(oldWordCount, oldCount);
    }
    if (newInput.value.trim()) {
      const newCount = await runTexCount(newInput.value);
      updateWordCount(newWordCount, newCount);
    }
  } catch (e) {
    console.error(e);
    setStatus("Failed to initialize tools.");
  }
}
async function initSwiftLaTeX() {
  try {
    await waitForSwiftLaTeX();
    pdfEngine = new window.PdfTeXEngine();
    await pdfEngine.loadEngine();
    console.log("SwiftLaTeX engine loaded successfully");
  } catch (error) {
    console.error("Failed to initialize SwiftLaTeX:", error);
    throw error;
  }
}
function waitForSwiftLaTeX() {
  return new Promise((resolve, reject) => {
    let attempts = 0;
    const maxAttempts = 100;
    const checkSwiftLaTeX = () => {
      if (window.PdfTeXEngine) {
        resolve();
      } else if (attempts >= maxAttempts) {
        reject(new Error("SwiftLaTeX failed to load. Make sure PdfTeXEngine.js is loaded."));
      } else {
        attempts++;
        setTimeout(checkSwiftLaTeX, 100);
      }
    };
    checkSwiftLaTeX();
  });
}
function cleanDiffTeX(diffTex) {
  let cleaned = diffTex;
  cleaned = cleaned.replace(/\\RequirePackage\{color\}/g, "\\usepackage{color}");
  cleaned = cleaned.replace(/\\usepackage\[T1\]\{fontenc\}/g, "");
  cleaned = cleaned.replace(/\\usepackage\{lmodern\}/g, "");
  cleaned = cleaned.replace(/\\usepackage\[.*?ps2pdf.*?\]\{hyperref\}/g, "\\usepackage[pdftex]{hyperref}");
  cleaned = cleaned.replace(/\\usepackage\{hyperref\}/g, "\\usepackage[pdftex]{hyperref}");
  const citationCommands = [
    "cite",
    "citet",
    "citep",
    "citealt",
    "citealp",
    "citeauthor",
    "citeyear",
    "citeyearpar",
    "Cite",
    "Citet",
    "Citep",
    "Citealt",
    "Citealp",
    "citenum",
    "citetext",
    "footcite",
    "footcitet",
    "footcitep",
    "parencite",
    "textcite",
    "autocite"
  ];
  const refCommands = [
    "ref",
    "autoref",
    "eqref",
    "figref",
    "tabref",
    "pageref",
    "nameref",
    "cref",
    "Cref",
    "vref",
    "Vref",
    "labelcref",
    "labelcpageref"
  ];
  const allCommands = [...citationCommands, ...refCommands];
  allCommands.forEach((cmd) => {
    cleaned = cleaned.replace(
      new RegExp(`\\\\DIFadd\\{\\\\${cmd}(?:\\[[^\\]]*\\])?\\{[^{}]*\\}\\}`, "g"),
      ""
    );
    cleaned = cleaned.replace(
      new RegExp(`\\\\DIFdel\\{\\\\${cmd}(?:\\[[^\\]]*\\])?\\{[^{}]*\\}\\}`, "g"),
      ""
    );
  });
  allCommands.forEach((cmd) => {
    cleaned = cleaned.replace(
      new RegExp(`\\\\${cmd}(?:\\[[^\\]]*\\])?\\{[^{}]*\\}`, "g"),
      ""
    );
  });
  for (let i = 0; i < 10; i++) {
    const before = cleaned;
    cleaned = cleaned.replace(/\\DIFaddbegin\s*/g, "");
    cleaned = cleaned.replace(/\\DIFaddend\s*/g, "");
    cleaned = cleaned.replace(/\\DIFdelbegin\s*/g, "");
    cleaned = cleaned.replace(/\\DIFdelend\s*/g, "");
    cleaned = cleaned.replace(/\\DIFadd\{([^{}]*)\}/g, "$1");
    cleaned = cleaned.replace(/\\DIFdel\{([^{}]*)\}/g, "");
    if (cleaned === before) break;
  }
  cleaned = cleaned.replace(/\\DIFadd\{\}/g, "");
  cleaned = cleaned.replace(/\\DIFdel\{\}/g, "");
  cleaned = cleaned.replace(/\s{2,}/g, " ");
  cleaned = cleaned.replace(/\{\s*\}/g, "");
  return cleaned;
}
async function compilePdf(diffTex) {
  if (!pdfEngine) {
    throw new Error("PDF engine not initialized");
  }
  try {
    const cleanedTex = cleanDiffTeX(diffTex);
    latestDiffTex = cleanedTex;
    downloadTexBtn.style.display = "inline-block";
    const engine = pdfEngine;
    engine.writeMemFSFile("main.tex", cleanedTex);
    const result = await engine.compileLaTeX();
    if (result.status !== 0) {
      console.error("Compilation failed with status:", result.status);
      if (result.log) {
        console.error("Compilation log:", result.log);
      }
      throw new Error(`LaTeX compilation failed with status ${result.status}`);
    }
    const pdfData = result.pdf;
    if (!pdfData || pdfData.length === 0) {
      throw new Error("No PDF was generated");
    }
    console.log("PDF generated successfully, size:", pdfData.length, "bytes");
    const pdfBytes = new Uint8Array(pdfData);
    const blob = new Blob([pdfBytes], { type: "application/pdf" });
    return blob;
  } catch (error) {
    console.error("PDF compilation error:", error);
    throw error;
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
    setStatus("PDF generated! Please allow pop-ups to view. Preview below.");
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
      type: "UNDERLINE",
      flatten: true,
      oldContent: oldWrapped,
      input: newWrapped,
      excludeTextcmd: "cite,citet,citep,citealt,citealp,citeauthor,citeyear,citeyearpar,Cite,Citet,Citep,Citealt,Citealp,ref,autoref,eqref,figref,tabref,pageref,nameref,hyperref,cref,Cref,vref,Vref,labelcref,labelcpageref",
      excludeSafecmd: "label,hypertarget,hyperlink",
      appendSafecmd: "includegraphics,caption",
      appendTextcmd: "caption"
    });
    setStatus("Compiling PDF with SwiftLaTeX...");
    const pdfBlob = await compilePdf(diff.output);
    if (currentPdfBlobUrl) {
      URL.revokeObjectURL(currentPdfBlobUrl);
    }
    const pdfBlobUrl = URL.createObjectURL(pdfBlob);
    currentPdfBlobUrl = pdfBlobUrl;
    openPdfInNewTab(pdfBlobUrl);
  } catch (e) {
    console.error("Error details:", e);
    const errorMsg = e instanceof Error ? e.message : String(e);
    setStatus(`Error: ${errorMsg}. Download diff.tex for details.`);
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
    setStatus("Initialization failed. Please refresh the page.");
  } finally {
    isInitializing = false;
  }
}
diffBtn.addEventListener("click", generateDiffPdf);
downloadTexBtn.addEventListener("click", () => {
  if (latestDiffTex) {
    downloadTextFile(latestDiffTex, "diff.tex");
    setStatus("diff.tex downloaded!");
  } else {
    setStatus("No diff available. Generate a diff first.");
  }
});
oldInput.addEventListener("input", debouncedCountOld);
newInput.addEventListener("input", debouncedCountNew);
safeInit();
