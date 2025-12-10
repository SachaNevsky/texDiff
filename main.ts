// main.ts
import { WebPerlRunner, LatexDiff } from "wasm-latex-tools";

const statusEl = document.getElementById("status") as HTMLSpanElement;
const oldInput = document.getElementById("oldInput") as HTMLTextAreaElement;
const newInput = document.getElementById("newInput") as HTMLTextAreaElement;
const diffBtn = document.getElementById("diffBtn") as HTMLButtonElement;

const runner = new WebPerlRunner({
    webperlBasePath: './vendor/wasm-latex-tools/webperl',
    perlScriptsPath: './vendor/wasm-latex-tools/perl'
});

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
        "\\usepackage[T1]{fontenc}",
        "\\usepackage[utf8]{inputenc}",
        "\\usepackage{lmodern}",
        "\\begin{document}",
        content,
        "\\end{document}"
    ].join("\n");
}

async function initTools() {
    try {
        setStatus("Loading diff tools...");
        await runner.initialize(); // WebPerl WASM + Perl scripts

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
        const maxAttempts = 50; // 5 seconds max

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
    compile(tex: string): Promise<string | Blob>;
}

interface PDFTEXConstructor {
    new(): PDFTEXEngine;
    isReady?: boolean;
}

declare global {
    interface Window {
        PDFTeX?: PDFTEXConstructor;
        TEXLIVE_CONFIG?: {
            workerPath?: string;
        };
    }
}

async function compilePdf(diffTex: string): Promise<string> {
    const PDFTeX = window.PDFTeX;
    if (!PDFTeX) {
        throw new Error("PDFTeX not available.");
    }

    console.log("Creating PDFTeX engine...");

    try {
        const engine = new PDFTeX();
        console.log("Compiling LaTeX...");
        console.log("LaTeX source length:", diffTex.length);

        // Add timeout for compilation
        const compilePromise = engine.compile(diffTex);
        const timeoutPromise = new Promise<never>((_, reject) => {
            setTimeout(() => reject(new Error("Compilation timeout after 30 seconds")), 30000);
        });

        const urlOrBlob = await Promise.race([compilePromise, timeoutPromise]);

        console.log("Compilation result type:", typeof urlOrBlob);
        console.log("Compilation result:", urlOrBlob);

        if (typeof urlOrBlob === "string") {
            return urlOrBlob;
        } else if (urlOrBlob instanceof Blob) {
            return URL.createObjectURL(urlOrBlob);
        } else {
            throw new Error("Unexpected compile result type: " + typeof urlOrBlob);
        }
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
            type: "UNDERLINE",
            flatten: true
        });

        const diff = await diffTool.diff(oldWrapped, newWrapped, {
            type: "UNDERLINE",
            flatten: true
        });

        console.log("Diff completed, output length:", diff.output.length);
        console.log("First 500 chars of diff output:", diff.output.substring(0, 500));

        setStatus("Compiling PDF...");
        const pdfUrl = await compilePdf(diff.output);
        console.log("PDF URL generated:", pdfUrl);

        window.open(pdfUrl, "_blank");
        setStatus("PDF opened.");
    } catch (e) {
        console.error("Error details:", e);
        const errorMsg = e instanceof Error ? e.message : String(e);
        setStatus(`Error: ${errorMsg}`);
    }
}

// Prevent multiple initializations
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