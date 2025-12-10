// main.ts
import { WebPerlRunner, LatexDiff } from "wasm-latex-tools";

const statusEl = document.getElementById("status") as HTMLSpanElement;
const oldInput = document.getElementById("oldInput") as HTMLTextAreaElement;
const newInput = document.getElementById("newInput") as HTMLTextAreaElement;
const diffBtn = document.getElementById("diffBtn") as HTMLButtonElement;
const pdfContainer = document.getElementById("pdfContainer") as HTMLDivElement;
const pdfViewer = document.getElementById("pdfViewer") as HTMLIFrameElement;

const runner = new WebPerlRunner({
    webperlBasePath: './vendor/wasm-latex-tools/webperl',
    perlScriptsPath: './vendor/wasm-latex-tools/perl'
});

// Suppress console errors from worker scripts
const originalConsoleError = console.error;
console.error = function (...args: unknown[]) {
    const message = String(args[0] || '');
    // Suppress known non-critical errors
    if (message.includes('Could not create /tmp') ||
        message.includes('Could not create /home') ||
        message.includes('mkdir failed for /tmp') ||
        message.includes('FS is not defined') ||
        message.includes('JSON.parse: unexpected character')) {
        return;
    }
    originalConsoleError.apply(console, args);
};

// Also suppress some console.log messages from texlive
const originalConsoleLog = console.log;
console.log = function (...args: unknown[]) {
    const message = String(args[0] || '');
    if (message.includes('Could not create') ||
        message.includes('mkdir failed') ||
        message.includes('asm.js is deprecated') ||
        message.includes('LazyFiles on gzip')) {
        return;
    }
    originalConsoleLog.apply(console, args);
};

// Suppress console.warn for specific warnings
const originalConsoleWarn = console.warn;
console.warn = function (...args: unknown[]) {
    const message = String(args[0] || '');
    if (message.includes('asm.js is deprecated')) {
        return;
    }
    originalConsoleWarn.apply(console, args);
};

function setStatus(msg: string) {
    console.log("> ", msg)
    if (statusEl) statusEl.textContent = msg;
}

function ensureWrapped(content: string): string {
    const hasDocClass = /\\documentclass/.test(content);
    const hasBeginDoc = /\\begin\{document\}/.test(content);
    const hasEndDoc = /\\end\{document\}/.test(content);
    if (hasDocClass && hasBeginDoc && hasEndDoc) return content;

    // Simplified preamble without lmodern and T1 encoding to avoid missing packages
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

        // Wait for PDFTeX to be available
        await waitForPDFTeX();

        setStatus("Ready.");
    } catch (e) {
        console.error(e);
        setStatus("Failed to initialize diff tools.");
    }
}

function waitForPDFTeX(): Promise<void> {
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

interface PDFTEXEngine {
    compile(tex: string): Promise<string>;
    compileRaw(tex: string): Promise<string>;
}

interface PDFTEXConstructor {
    new(workerPath?: string): PDFTEXEngine;
}

declare global {
    interface Window {
        PDFTeX?: PDFTEXConstructor;
        TEXLIVE_CONFIG?: {
            workerPath?: string;
        };
    }
}

function dataURLtoBlob(dataURL: string): Blob {
    // Convert base64 data URL to blob
    const parts = dataURL.split(',');
    const contentType = parts[0].split(':')[1].split(';')[0];
    const raw = window.atob(parts[1]);
    const rawLength = raw.length;
    const uInt8Array = new Uint8Array(rawLength);

    for (let i = 0; i < rawLength; ++i) {
        uInt8Array[i] = raw.charCodeAt(i);
    }

    return new Blob([uInt8Array], { type: contentType });
}

async function compilePdf(diffTex: string): Promise<string> {
    const PDFTeX = window.PDFTeX;
    if (!PDFTeX) {
        throw new Error("PDFTeX not available.");
    }

    console.log("Creating PDFTeX engine...");

    try {
        const workerPath = window.TEXLIVE_CONFIG?.workerPath || './vendor/texlive.js/pdftex-worker.js';
        const engine = new PDFTeX(workerPath);

        console.log("Compiling LaTeX...");
        console.log("LaTeX source length:", diffTex.length);

        // Use compile method which returns a data URL
        const pdfDataUrl = await engine.compile(diffTex);

        if (!pdfDataUrl || pdfDataUrl === 'false') {
            throw new Error("Compilation failed - no PDF produced. This may be due to missing LaTeX packages in the texlive distribution.");
        }

        console.log("PDF compiled successfully, converting to blob URL");

        // Convert data URL to blob URL (more efficient and CSP-friendly)
        const blob = dataURLtoBlob(pdfDataUrl);
        const blobUrl = URL.createObjectURL(blob);

        return blobUrl;
    } catch (error) {
        console.error("PDFTeX compilation error:", error);
        throw new Error(`PDF compilation failed: ${error instanceof Error ? error.message : String(error)}`);
    }
}

async function generateDiffPdf() {
    console.log("Clicked...")
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
            type: "CHANGEBAR",
            flatten: true
        });

        // Use CHANGEBAR type which doesn't require ulem.sty
        const diff = await diffTool.diff(oldWrapped, newWrapped, {
            type: "CHANGEBAR",
            flatten: true
        });

        console.log("Diff completed, output length:", diff.output.length);

        // Simplify the diff output to remove problematic packages
        let simplifiedDiff = diff.output
            .replace(/\\usepackage\[T1\]\{fontenc\}/g, '')
            .replace(/\\usepackage\{lmodern\}/g, '');

        console.log("Simplified diff for compilation");

        setStatus("Compiling PDF...");
        const pdfBlobUrl = await compilePdf(simplifiedDiff);
        console.log("PDF compiled, displaying...");

        // Clean up previous blob URL if exists
        if (pdfViewer.src && pdfViewer.src.startsWith('blob:')) {
            URL.revokeObjectURL(pdfViewer.src);
        }

        // Display PDF in iframe
        pdfViewer.src = pdfBlobUrl;
        pdfContainer.style.display = 'block';

        setStatus("PDF generated successfully!");
    } catch (e) {
        console.error("Error details:", e);
        const errorMsg = e instanceof Error ? e.message : String(e);
        setStatus(`Error: ${errorMsg}`);
    }
}

let isInitializing = false;
let isInitialized = false;

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