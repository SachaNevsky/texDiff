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
let currentPdfBlobUrl: string | null = null;

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
    try {
        // More robust data URL parsing
        const parts = dataURL.split(',');
        if (parts.length !== 2) {
            throw new Error('Invalid data URL format');
        }

        const mimeMatch = parts[0].match(/:(.*?);/);
        const contentType = mimeMatch ? mimeMatch[1] : 'application/pdf';

        // Remove any whitespace from base64 string
        const base64Data = parts[1].trim().replace(/\s/g, '');

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

function cleanDiffTeX(diffTex: string): string {
    // The color package IS available in texlive.js
    // Replace \RequirePackage with \usepackage

    let cleaned = diffTex;

    // Replace \RequirePackage with \usepackage for color
    cleaned = cleaned.replace(/\\RequirePackage\{color\}/g, '\\usepackage{color}');

    // Remove problematic packages that aren't available
    cleaned = cleaned
        .replace(/\\usepackage\[T1\]\{fontenc\}/g, '')
        .replace(/\\usepackage\{lmodern\}/g, '')
        .replace(/\\usepackage\{textcomp\}/g, '')
        .replace(/\\usepackage(\[.*?\])?\{ulem\}/g, '')
        .replace(/\\usepackage(\[.*?\])?\{changebar\}/g, '');

    // Keep your custom deletion format with raisebox
    cleaned = cleaned.replace(
        /\\providecommand\{\\DIFdelFL\}\[1\]\{\{\\color\{red\}\{\\color\{red\}\[deleted: #1\]\}\}\}/g,
        '\\providecommand{\\DIFdelFL}[1]{{\\color{red}\\raisebox{1ex}{\\underline{\\smash{\\raisebox{-1ex}{#1}}}}}}'
    );

    cleaned = cleaned.replace(
        /\\providecommand\{\\DIFdel\}\[1\]\{\{\\protect\\color\{red\} \\scriptsize #1\}\}/g,
        '\\providecommand{\\DIFdel}[1]{{\\color{red}\\raisebox{1ex}{\\underline{\\smash{\\raisebox{-1ex}{#1}}}}}}'
    );

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

        console.log("Starting PDF compilation...");
        const pdfDataUrl = await engine.compile(cleanedTex);
        console.log("Compilation complete, data URL length:", pdfDataUrl?.length);

        if (!pdfDataUrl || pdfDataUrl === 'false' || pdfDataUrl.length < 100) {
            throw new Error("Compilation failed - no valid PDF data produced");
        }

        // Verify the data URL starts correctly
        if (!pdfDataUrl.startsWith('data:application/pdf') && !pdfDataUrl.startsWith('data:;base64,')) {
            console.error("Invalid data URL format:", pdfDataUrl.substring(0, 100));
            throw new Error("Invalid PDF data format returned");
        }

        const blob = dataURLtoBlob(pdfDataUrl);
        console.log("Created blob, size:", blob.size, "bytes");

        if (blob.size < 100) {
            throw new Error("Generated PDF is too small, likely corrupted");
        }

        // Clean up previous blob URL
        if (currentPdfBlobUrl) {
            URL.revokeObjectURL(currentPdfBlobUrl);
        }

        // Create new blob URL
        const blobUrl = URL.createObjectURL(blob);
        currentPdfBlobUrl = blobUrl;

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

function openPdfInNewTab(blobUrl: string) {
    // Open in new tab instead of iframe to avoid blob URL issues with PDF.js
    const newWindow = window.open(blobUrl, '_blank');
    if (!newWindow) {
        setStatus("PDF generated! Please allow pop-ups to view the PDF, or use the iframe below.");
        // Fallback to iframe if popup blocked
        pdfViewer.src = blobUrl;
        pdfContainer.style.display = 'block';
    } else {
        setStatus("PDF opened in new tab!");
        // Also show in iframe as backup
        pdfViewer.src = blobUrl;
        pdfContainer.style.display = 'block';
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

        // Use CFONT type which uses basic LaTeX commands (color, textbf)
        const diff = await diffTool.diff(oldWrapped, newWrapped, {
            type: "CFONT",
            flatten: true
        });

        setStatus("Compiling PDF...");
        const pdfBlobUrl = await compilePdf(diff.output);

        // Open PDF in new tab
        openPdfInNewTab(pdfBlobUrl);
    } catch (e) {
        console.error("Error details:", e);
        const errorMsg = e instanceof Error ? e.message : String(e);
        setStatus(`Error: ${errorMsg}. Check diff.tex for details.`);
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
        setStatus("diff.tex downloaded! Compile this locally if PDF viewer issues persist.");
    } else {
        setStatus("No diff available to download. Generate a diff first.");
    }
});

safeInit();