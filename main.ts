// ./main.ts

import { WebPerlRunner, LatexDiff, TexCount } from "wasm-latex-tools";
import { cleanDiffTeX } from "./functions/cleanDiffTeX";
import { ensureWrapped } from "./functions/ensureWrapped";
import { downloadTextFile } from "./functions/downloadTextFile";
import { updateWordCount } from "./functions/updateWordCount"

const statusEl = document.getElementById("status") as HTMLSpanElement;
const oldInput = document.getElementById("oldInput") as HTMLTextAreaElement;
const newInput = document.getElementById("newInput") as HTMLTextAreaElement;
const diffBtn = document.getElementById("diffBtn") as HTMLButtonElement;
const downloadTexBtn = document.getElementById("downloadTexBtn") as HTMLButtonElement;
const pdfContainer = document.getElementById("pdfContainer") as HTMLDivElement;
const pdfViewer = document.getElementById("pdfViewer") as HTMLIFrameElement;
const oldWordCount = document.getElementById("oldWordCount") as HTMLDivElement;
const newWordCount = document.getElementById("newWordCount") as HTMLDivElement;

const runner = new WebPerlRunner({
    webperlBasePath: './vendor/wasm-latex-tools/webperl',
    perlScriptsPath: './vendor/wasm-latex-tools/perl'
});

let pdfEngine: unknown = null;
let texCount: TexCount | null = null;

let latestDiffTex: string = '';
let currentPdfBlobUrl: string | null = null;

let oldCountTimer: ReturnType<typeof setTimeout> | null = null;
let newCountTimer: ReturnType<typeof setTimeout> | null = null;

declare global {
    interface Window {
        PdfTeXEngine: unknown;
    }
}

interface SwiftLaTeXEngine {
    loadEngine(): Promise<void>;
    writeMemFSFile(filename: string, content: string): void;
    compileLaTeX(): Promise<{
        status: number;
        pdf: Uint8Array<ArrayBuffer>;
        log?: string;
    }>;
}

function setStatus(msg: string) {
    if (statusEl) statusEl.textContent = msg;
}

async function runTexCount(content: string): Promise<number> {
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
        console.error('Error running texcount:', error);
        return 0;
    }
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
        pdfEngine = new (window.PdfTeXEngine as new () => SwiftLaTeXEngine)();
        await (pdfEngine as SwiftLaTeXEngine).loadEngine();
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

async function compilePdf(diffTex: string): Promise<Blob> {
    if (!pdfEngine) {
        throw new Error("PDF engine not initialized");
    }

    try {
        const cleanedTex = cleanDiffTeX(diffTex);
        latestDiffTex = cleanedTex;
        downloadTexBtn.style.display = 'inline-block';

        console.log("=== CLEANED TEX (first 2000 chars) ===");
        console.log(cleanedTex.substring(0, 2000));
        console.log("=== CLEANED TEX (last 1000 chars) ===");
        console.log(cleanedTex.substring(cleanedTex.length - 1000));

        const figureCount = (cleanedTex.match(/\\begin\{figure/g) || []).length;
        const endFigureCount = (cleanedTex.match(/\\end\{figure/g) || []).length;
        console.log(`Figure environments: ${figureCount} begins, ${endFigureCount} ends`);

        const engine = pdfEngine as SwiftLaTeXEngine;
        engine.writeMemFSFile("main.tex", cleanedTex);
        const result = await engine.compileLaTeX();

        if (result.status !== 0) {
            console.error("Compilation failed with status:", result.status);
            if (result.log) {
                console.error("Compilation log:", result.log);

                const lineMatch = result.log.match(/l\.(\d+)/);
                if (lineMatch) {
                    const lineNum = parseInt(lineMatch[1], 10);
                    const lines = cleanedTex.split('\n');
                    console.error(`Problem at line ${lineNum}:`);
                    console.error(lines[lineNum - 1]);
                    if (lineNum > 1) console.error('Previous line:', lines[lineNum - 2]);
                    if (lineNum < lines.length) console.error('Next line:', lines[lineNum]);
                }
            }
            throw new Error(`LaTeX compilation failed with status ${result.status}`);
        }

        const pdfData = result.pdf;

        if (!pdfData || pdfData.length === 0) {
            throw new Error("No PDF was generated");
        }

        console.log("PDF generated successfully, size:", pdfData.length, "bytes");

        const pdfBytes = new Uint8Array(pdfData);
        const blob = new Blob([pdfBytes], { type: 'application/pdf' });

        return blob;
    } catch (error) {
        console.error("PDF compilation error:", error);
        throw error;
    }
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
            type: "UNDERLINE",
            flatten: true,
            oldContent: oldWrapped,
            input: newWrapped,
            excludeTextcmd: "cite,citet,citep,citealt,citealp,citeauthor,citeyear,citeyearpar,Cite,Citet,Citep,Citealt,Citealp,ref,autoref,eqref,figref,tabref,pageref,nameref,hyperref,cref,Cref,vref,Vref,labelcref,labelcpageref",
            excludeSafecmd: "label,hypertarget,hyperlink",
            appendSafecmd: "includegraphics,caption",
            appendTextcmd: "caption"
        });

        console.log("=== LATEXDIFF RAW OUTPUT (first 500 chars) ===");
        console.log(diff.output.substring(0, 500));
        console.log("=== Has DIFadd? ===", diff.output.includes('DIFadd'));
        console.log("=== Has DIFdel? ===", diff.output.includes('DIFdel'));
        console.log("=== Has \\mbox\\hskip? ===", diff.output.includes('\\mbox\\hskip'));

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

oldInput.addEventListener("input", debouncedCountOld);
newInput.addEventListener("input", debouncedCountNew);

safeInit();