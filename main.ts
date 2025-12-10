// main.ts
import { WebPerlRunner, LatexDiff } from "wasm-latex-tools";

const statusEl = document.getElementById("status") as HTMLSpanElement;
const oldInput = document.getElementById("oldInput") as HTMLTextAreaElement;
const newInput = document.getElementById("newInput") as HTMLTextAreaElement;
const diffBtn = document.getElementById("diffBtn") as HTMLButtonElement;
const downloadTexBtn = document.getElementById("downloadTexBtn") as HTMLButtonElement;
const pdfContainer = document.getElementById("pdfContainer") as HTMLDivElement;
const pdfViewer = document.getElementById("pdfViewer") as HTMLIFrameElement;

const runner = new WebPerlRunner({
    webperlBasePath: './vendor/wasm-latex-tools/webperl',
    perlScriptsPath: './vendor/wasm-latex-tools/perl'
});

// Store the latest diff output
let latestDiffTex: string = '';

// ============================================================================
// AGGRESSIVE ERROR SUPPRESSION
// ============================================================================

// Intercept global error handler
window.addEventListener('error', (event) => {
    const message = event.message || '';
    const filename = event.filename || '';

    // Suppress known non-critical errors
    if (message.includes('JSON.parse: unexpected character') ||
        message.includes('FS is not defined') ||
        message.includes('Could not create /tmp') ||
        message.includes('Could not create /home') ||
        message.includes('mkdir failed') ||
        filename.includes('pre.js') ||
        filename.includes('post.js') ||
        filename.includes('perlrunner.html')) {
        event.preventDefault();
        event.stopPropagation();
        return false;
    }
}, true);

// Intercept unhandled promise rejections
window.addEventListener('unhandledrejection', (event) => {
    const reason = String(event.reason || '');

    if (reason.includes('Invalid PDF structure') ||
        reason.includes('InvalidPDFException') ||
        reason.includes('JSON.parse') ||
        reason.includes('FS is not defined')) {
        event.preventDefault();
        return false;
    }
});

// Override console methods
const originalConsoleError = console.error;
console.error = function (...args: unknown[]) {
    const message = String(args[0] || '');
    const stack = args[1] && typeof args[1] === 'object' ? String((args[1] as any).stack || '') : '';

    if (message.includes('Could not create /tmp') ||
        message.includes('Could not create /home') ||
        message.includes('mkdir failed') ||
        message.includes('FS is not defined') ||
        message.includes('JSON.parse: unexpected character') ||
        message.includes('Invalid PDF structure') ||
        message.includes('Invalid or corrupted PDF') ||
        message.includes('InvalidPDFException') ||
        stack.includes('pre.js') ||
        stack.includes('post.js') ||
        stack.includes('perlrunner.html')) {
        return;
    }
    originalConsoleError.apply(console, args);
};

const originalConsoleLog = console.log;
console.log = function (...args: unknown[]) {
    const message = String(args[0] || '');

    if (message.includes('Could not create') ||
        message.includes('mkdir failed') ||
        message.includes('asm.js is deprecated') ||
        message.includes('LazyFiles on gzip') ||
        message.includes('This is pdfTeX') ||
        message.includes('restricted \\write18') ||
        message.includes('entering extended mode') ||
        message.includes('LaTeX2e') ||
        message.includes('Document Class:') ||
        message.includes('//texmf-dist/') ||
        message.includes('./input.tex') ||
        message.includes('Successfully compiled asm.js') ||
        message.includes('No file input.aux') ||
        message.includes('[Loading MPS to PDF converter') ||
        message.includes('Output written on input.pdf') ||
        message.includes('Transcript written on input.log') ||
        message.match(/^\([\/\.]/) || // Lines starting with (/ or (.
        message.match(/^\)/) || // Lines starting with )
        message === '<empty string>') {
        return;
    }
    originalConsoleLog.apply(console, args);
};

const originalConsoleWarn = console.warn;
console.warn = function (...args: unknown[]) {
    const message = String(args[0] || '');

    if (message.includes('asm.js is deprecated') ||
        message.includes('Invalid absolute docBaseUrl') ||
        message.includes('Indexing all PDF objects') ||
        message.includes('Warning:')) {
        return;
    }
    originalConsoleWarn.apply(console, args);
};

// ============================================================================
// APPLICATION CODE
// ============================================================================

function setStatus(msg: string) {
    console.log("> ", msg)
    if (statusEl) statusEl.textContent = msg;
}

function ensureWrapped(content: string): string {
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

function waitForPDFTeX(): Promise<void> {
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

function cleanDiffTeX(diffTex: string): string {
    // The texlive.js distribution has very limited package support
    // We need to work with what's available: basic LaTeX commands only

    let cleaned = diffTex;

    // Remove all package imports except inputenc
    cleaned = cleaned
        .replace(/\\RequirePackage\{color\}/g, '')
        .replace(/\\usepackage\{xcolor\}/g, '')
        .replace(/\\usepackage\{color\}/g, '')
        .replace(/\\usepackage\[T1\]\{fontenc\}/g, '')
        .replace(/\\usepackage\{lmodern\}/g, '')
        .replace(/\\usepackage\{textcomp\}/g, '')
        .replace(/\\usepackage(\[.*?\])?\{ulem\}/g, '')
        .replace(/\\usepackage(\[.*?\])?\{changebar\}/g, '');

    // Remove color definitions
    cleaned = cleaned.replace(/\\definecolor\{RED\}\{rgb\}\{1,0,0\}/g, '');
    cleaned = cleaned.replace(/\\definecolor\{BLUE\}\{rgb\}\{0,0,1\}/g, '');

    // Remove or simplify all color commands since we don't have the color package
    // Replace \color{red} and \color{blue} commands - remove them or use text markers
    cleaned = cleaned.replace(/\\color\{red\}/g, '');
    cleaned = cleaned.replace(/\\color\{blue\}/g, '');
    cleaned = cleaned.replace(/\{\s*\\protect\\color\{[^}]+\}\s*/g, '{');

    // Simplify font commands
    cleaned = cleaned.replace(/\\DeclareOldFontCommand\{\\sf\}\{\\normalfont\\sffamily\}\{\\mathsf\}/g, '');

    // Replace DIFadd and DIFdel with simple text markers
    // Note: The definitions from latexdiff are already there, we just need to ensure they work
    // without color package

    // Redefine the DIF commands to work without color package
    const simpleCommands = `
%DIF SIMPLIFIED COMMANDS (no color package needed)
\\providecommand{\\DIFadd}[1]{\\textbf{[ADDED: #1]}}
\\providecommand{\\DIFdel}[1]{\\tiny [DELETED: #1]}
\\providecommand{\\DIFaddFL}[1]{\\textbf{[ADDED: #1]}}
\\providecommand{\\DIFdelFL}[1]{\\tiny [DELETED: #1]}
`;

    // Find where to insert the new commands (after the preamble definitions)
    const endPreambleMarker = '%DIF END PREAMBLE EXTENSION ADDED BY LATEXDIFF';
    if (cleaned.includes(endPreambleMarker)) {
        cleaned = cleaned.replace(endPreambleMarker, endPreambleMarker + simpleCommands);
    } else {
        // Insert before \begin{document}
        cleaned = cleaned.replace(/\\begin\{document\}/, simpleCommands + '\n\\begin{document}');
    }

    return cleaned;
}

async function compilePdf(diffTex: string): Promise<string> {
    const PDFTeX = window.PDFTeX;
    if (!PDFTeX) {
        throw new Error("PDFTeX not available.");
    }

    try {
        const workerPath = window.TEXLIVE_CONFIG?.workerPath || './vendor/texlive.js/pdftex-worker.js';
        const engine = new PDFTeX(workerPath);

        // Clean the TeX before compilation
        const cleanedTex = cleanDiffTeX(diffTex);

        // Save the cleaned version for download
        latestDiffTex = cleanedTex;
        downloadTexBtn.style.display = 'inline-block';

        const pdfDataUrl = await engine.compile(cleanedTex);

        if (!pdfDataUrl || pdfDataUrl === 'false') {
            throw new Error("Compilation failed - no PDF produced. Check the LaTeX syntax or package availability.");
        }

        const blob = dataURLtoBlob(pdfDataUrl);
        const blobUrl = URL.createObjectURL(blob);

        return blobUrl;
    } catch (error) {
        console.error("PDFTeX compilation error:", error);
        throw new Error(`PDF compilation failed: ${error instanceof Error ? error.message : String(error)}`);
    }
}

function downloadTextFile(content: string, filename: string) {
    const blob = new Blob([content], { type: 'text/plain;charset=utf-8' });
    const url = URL.createObjectURL(blob);
    const link = document.createElement('a');
    link.href = url;
    link.download = filename;
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
    URL.revokeObjectURL(url);
}

function downloadPdfFile(blobUrl: string, filename: string) {
    const link = document.createElement('a');
    link.href = blobUrl;
    link.download = filename;
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
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

        // Use CFONT type which uses basic LaTeX commands
        const diff = await diffTool.diff(oldWrapped, newWrapped, {
            type: "CFONT",
            flatten: true
        });

        setStatus("Compiling PDF...");
        const pdfBlobUrl = await compilePdf(diff.output);

        // Clean up previous blob URL if exists
        if (pdfViewer.src && pdfViewer.src.startsWith('blob:')) {
            URL.revokeObjectURL(pdfViewer.src);
        }

        // Try to display PDF in iframe, but don't fail if it doesn't work
        try {
            pdfViewer.src = pdfBlobUrl;
            pdfContainer.style.display = 'block';
        } catch (e) {
            console.warn("Could not display PDF in iframe, but download should work");
        }

        // Store the blob URL for download
        (window as any).__lastPdfBlobUrl = pdfBlobUrl;

        setStatus("PDF generated! Click 'Download diff.tex' for LaTeX source or 'Download PDF' for the compiled file.");

        // Show download PDF button
        const downloadPdfBtn = document.getElementById('downloadPdfBtn') as HTMLButtonElement;
        if (downloadPdfBtn) {
            downloadPdfBtn.style.display = 'inline-block';
        }
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

downloadTexBtn.addEventListener("click", () => {
    if (latestDiffTex) {
        downloadTextFile(latestDiffTex, 'diff.tex');
        setStatus("diff.tex downloaded!");
    } else {
        setStatus("No diff available to download. Generate a diff first.");
    }
});

// Add download PDF button handler
const downloadPdfBtn = document.getElementById('downloadPdfBtn');
if (downloadPdfBtn) {
    downloadPdfBtn.addEventListener("click", () => {
        const pdfBlobUrl = (window as any).__lastPdfBlobUrl;
        if (pdfBlobUrl) {
            downloadPdfFile(pdfBlobUrl, 'diff.pdf');
            setStatus("diff.pdf downloaded!");
        } else {
            setStatus("No PDF available to download. Generate a diff first.");
        }
    });
}

safeInit();