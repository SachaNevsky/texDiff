// main.ts - SwiftLaTeX version
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

let pdfEngine: any = null;

let latestDiffTex: string = '';
let currentPdfBlobUrl: string | null = null;

// ============================================================================
// SwiftLaTeX Type Definitions
// ============================================================================

declare global {
    interface Window {
        PdfTeXEngine: any;
    }
}

// ============================================================================
// MINIMAL ERROR SUPPRESSION
// ============================================================================

window.addEventListener('error', (event) => {
    const message = event.message || '';
    const filename = event.filename || '';

    if (message.includes('Could not create /tmp') ||
        message.includes('Could not create /home') ||
        message.includes('mkdir failed') ||
        filename.includes('perlrunner.html')) {
        event.preventDefault();
        event.stopPropagation();
        return false;
    }
}, true);

const originalConsoleLog = console.log;
console.log = function (...args: unknown[]) {
    const message = String(args[0] || '');
    if (message.includes('Could not create') ||
        message.includes('mkdir failed')) {
        return;
    }
    originalConsoleLog.apply(console, args);
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
        setStatus("Initializing SwiftLaTeX...");
        await initSwiftLaTeX();
        setStatus("Ready.");
    } catch (e) {
        console.error(e);
        setStatus("Failed to initialize tools.");
    }
}

async function initSwiftLaTeX() {
    try {
        // Wait for SwiftLaTeX to be available
        await waitForSwiftLaTeX();

        // Initialize SwiftLaTeX engine
        pdfEngine = new window.PdfTeXEngine();

        // Load the engine
        await pdfEngine.loadEngine();

        console.log("SwiftLaTeX engine loaded successfully");
    } catch (error) {
        console.error("Failed to initialize SwiftLaTeX:", error);
        throw error;
    }
}

function waitForSwiftLaTeX(): Promise<void> {
    return new Promise((resolve, reject) => {
        let attempts = 0;
        const maxAttempts = 100;

        const checkSwiftLaTeX = () => {
            if (window.PdfTeXEngine) {  // Changed from PDFTeXEngine
                console.log("SwiftLaTeX is ready!");
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

function cleanDiffTeX(diffTex: string): string {
    let cleaned = diffTex;

    // Replace \RequirePackage with \usepackage for consistency
    cleaned = cleaned.replace(/\\RequirePackage\{color\}/g, '\\usepackage{color}');

    // Remove problematic font packages if they exist
    cleaned = cleaned.replace(/\\usepackage\[T1\]\{fontenc\}/g, '');
    cleaned = cleaned.replace(/\\usepackage\{lmodern\}/g, '');

    return cleaned;
}

async function compilePdf(diffTex: string): Promise<Blob> {
    if (!pdfEngine) {
        throw new Error("PDF engine not initialized");
    }

    try {
        // Clean the TeX
        const cleanedTex = cleanDiffTeX(diffTex);

        // Save for download
        latestDiffTex = cleanedTex;
        downloadTexBtn.style.display = 'inline-block';

        console.log("Starting SwiftLaTeX compilation...");
        console.log("LaTeX length:", cleanedTex.length, "characters");

        // Write the main TeX file
        pdfEngine.writeMemFSFile("main.tex", cleanedTex);

        // Compile the LaTeX document
        const result = await pdfEngine.compileLaTeX();

        console.log("Compilation result:", result);

        if (result.status !== 0) {
            console.error("Compilation failed with status:", result.status);
            if (result.log) {
                console.error("Compilation log:", result.log);
            }
            throw new Error(`LaTeX compilation failed with status ${result.status}`);
        }

        // Read the generated PDF from memory filesystem
        const pdfData = pdfEngine.readMemFSFile("main.pdf");

        if (!pdfData || pdfData.length === 0) {
            throw new Error("No PDF was generated");
        }

        console.log("PDF generated successfully, size:", pdfData.length, "bytes");

        // Create blob from Uint8Array
        const blob = new Blob([pdfData], { type: 'application/pdf' });

        return blob;
    } catch (error) {
        console.error("PDF compilation error:", error);
        throw error;
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
    const newWindow = window.open(blobUrl, '_blank');
    if (!newWindow) {
        setStatus("PDF generated! Please allow pop-ups to view. Preview below.");
        pdfViewer.src = blobUrl;
        pdfContainer.style.display = 'block';
    } else {
        setStatus("PDF opened in new tab!");
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

        const diff = await diffTool.diff(oldWrapped, newWrapped, {
            type: "CFONT",
            flatten: true,
            oldContent: oldWrapped,
            input: newWrapped
        });

        setStatus("Compiling PDF with SwiftLaTeX...");
        const pdfBlob = await compilePdf(diff.output);

        // Clean up previous blob URL
        if (currentPdfBlobUrl) {
            URL.revokeObjectURL(currentPdfBlobUrl);
        }

        // Create new blob URL
        const pdfBlobUrl = URL.createObjectURL(pdfBlob);
        currentPdfBlobUrl = pdfBlobUrl;

        // Open PDF
        openPdfInNewTab(pdfBlobUrl);
    } catch (e) {
        console.error("Error details:", e);
        const errorMsg = e instanceof Error ? e.message : String(e);
        setStatus(`Error: ${errorMsg}. Download diff.tex for details.`);
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
        setStatus("Initialization failed. Please refresh the page.");
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
        setStatus("No diff available. Generate a diff first.");
    }
});

// Initialize on page load
safeInit();