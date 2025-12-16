// ./main.ts

import { WebPerlRunner, LatexDiff, TexCount } from "wasm-latex-tools";

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

// Debounce timer for word counting
let oldCountTimer: ReturnType<typeof setTimeout> | null = null;
let newCountTimer: ReturnType<typeof setTimeout> | null = null;

// ============================================================================
// SwiftLaTeX Type Definitions
// ============================================================================

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

const originalConsoleWarn = console.warn;
console.warn = function (...args: unknown[]) {
    const message = String(args[0] || '');
    // Suppress filesystem warnings from Perl runner
    if (message.includes('Could not create /tmp') ||
        message.includes('Could not create /home') ||
        message.includes('Could not create /perl') ||
        message.includes('mkdir failed')) {
        return;
    }
    originalConsoleWarn.apply(console, args);
};

// ============================================================================
// APPLICATION CODE
// ============================================================================

function setStatus(msg: string) {
    // console.log("> ", msg)
    if (statusEl) statusEl.textContent = msg;
}

function ensureWrapped(content: string): string {
    const hasDocClass = /\\documentclass/.test(content);
    const hasBeginDoc = /\\begin\{document\}/.test(content);
    const hasEndDoc = /\\end\{document\}/.test(content);
    if (hasDocClass && hasBeginDoc && hasEndDoc) return content;

    // Check if content contains chapter commands
    const hasChapter = /\\chapter\{/.test(content);

    // Use 'report' class if chapters are present, otherwise use 'article'
    const docClass = hasChapter ? 'report' : 'article';

    return [
        `\\documentclass{${docClass}}`,
        "\\usepackage[utf8]{inputenc}",
        "\\begin{document}",
        content,
        "\\end{document}"
    ].join("\n");
}

// ============================================================================
// TEXCOUNT FUNCTIONALITY
// ============================================================================

async function runTexCount(content: string): Promise<number> {
    if (!content.trim()) {
        // console.log("runTexCount: empty content");
        return 0;
    }

    if (!texCount) {
        // console.log("runTexCount: texCount not initialized yet");
        return 0;
    }

    try {
        // console.log("runTexCount: running count on", content.length, "chars");

        // Wrap content if needed
        const wrappedContent = ensureWrapped(content);

        // Run texcount with brief output
        const result = await texCount.count({
            input: wrappedContent,
            brief: true
        });

        // console.log("runTexCount: raw output:", result.output);

        // Parse the brief output format manually
        // Brief format is: "words+headers+captions (inline/display/headers/floats) File: filename"
        // Example: "354+0+4 (0/0/0/0) File: main.tex"
        let wordCount = 0;

        const briefMatch = result.output.match(/^(\d+)\+(\d+)\+(\d+)/);
        if (briefMatch) {
            wordCount = parseInt(briefMatch[1], 10);
            // console.log("runTexCount: parsed word count from brief format:", wordCount);
        } else {
            // Fallback to parseOutput method
            const parsed = texCount.parseOutput(result.output);
            // console.log("runTexCount: parsed result (fallback):", parsed);
            wordCount = parsed.words || 0;
        }

        // console.log("runTexCount: final word count:", wordCount);

        return wordCount;
    } catch (error) {
        console.error('Error running texcount:', error);
        return 0;
    }
}

function updateWordCount(element: HTMLDivElement, count: number) {
    element.textContent = `Words: ${count}`;
    // console.log("Updated word count display to:", count);
}

function debouncedCountOld() {
    if (oldCountTimer) {
        clearTimeout(oldCountTimer);
    }

    oldCountTimer = setTimeout(async () => {
        // console.log("Debounced count triggered for old input");
        const count = await runTexCount(oldInput.value);
        updateWordCount(oldWordCount, count);
    }, 500);
}

function debouncedCountNew() {
    if (newCountTimer) {
        clearTimeout(newCountTimer);
    }

    newCountTimer = setTimeout(async () => {
        // console.log("Debounced count triggered for new input");
        const count = await runTexCount(newInput.value);
        updateWordCount(newWordCount, count);
    }, 500);
}

// ============================================================================
// INITIALIZATION
// ============================================================================

async function initTools() {
    try {
        setStatus("Loading diff tools...");
        await runner.initialize();

        // Initialize TexCount
        // console.log("Initializing TexCount...");
        texCount = new TexCount(runner);
        console.log("TexCount initialized:", texCount);

        setStatus("Initializing SwiftLaTeX...");
        await initSwiftLaTeX();
        setStatus("Ready.");

        // Initial word counts (trigger immediately for any existing content)
        if (oldInput.value.trim()) {
            // console.log("Counting initial old input");
            const oldCount = await runTexCount(oldInput.value);
            updateWordCount(oldWordCount, oldCount);
        }
        if (newInput.value.trim()) {
            // console.log("Counting initial new input");
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
        // Wait for SwiftLaTeX to be available
        await waitForSwiftLaTeX();

        // Initialize SwiftLaTeX engine
        pdfEngine = new (window.PdfTeXEngine as new () => SwiftLaTeXEngine)();

        // Load the engine
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
                // console.log("SwiftLaTeX is ready!");
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

// ============================================================================
// PDF GENERATION
// ============================================================================

function cleanDiffTeX(diffTex: string): string {
    let cleaned = diffTex;

    // Replace \RequirePackage with \usepackage for consistency
    cleaned = cleaned.replace(/\\RequirePackage\{color\}/g, '\\usepackage{color}');

    // Remove problematic font packages if they exist
    cleaned = cleaned.replace(/\\usepackage\[T1\]\{fontenc\}/g, '');
    cleaned = cleaned.replace(/\\usepackage\{lmodern\}/g, '');

    // Fix hyperref driver issue - latexdiff adds hyperref with ps2pdf driver
    // Replace any hyperref with wrong driver with correct pdftex driver
    cleaned = cleaned.replace(/\\usepackage\[.*?ps2pdf.*?\]\{hyperref\}/g, '\\usepackage[pdftex]{hyperref}');

    // Also catch hyperref without explicit driver
    cleaned = cleaned.replace(/\\usepackage\{hyperref\}/g, '\\usepackage[pdftex]{hyperref}');

    // List of common citation and reference commands to remove
    const citationCommands = [
        'cite', 'citet', 'citep', 'citealt', 'citealp', 'citeauthor', 'citeyear', 'citeyearpar',
        'Cite', 'Citet', 'Citep', 'Citealt', 'Citealp',
        'citenum', 'citetext',
        'footcite', 'footcitet', 'footcitep',
        'parencite', 'textcite', 'autocite'
    ];

    const refCommands = [
        'ref', 'autoref', 'eqref', 'figref', 'tabref', 'pageref', 'nameref',
        'cref', 'Cref', 'vref', 'Vref', 'labelcref', 'labelcpageref'
    ];

    const allCommands = [...citationCommands, ...refCommands];

    // Remove DIFadd/DIFdel wrappers around citation/ref commands FIRST
    // This prevents creating unbalanced braces
    allCommands.forEach(cmd => {
        // Remove \DIFadd{\cite{...}} and similar
        cleaned = cleaned.replace(
            new RegExp(`\\\\DIFadd\\{\\\\${cmd}(?:\\[[^\\]]*\\])?\\{[^{}]*\\}\\}`, 'g'),
            ''
        );
        // Remove \DIFdel{\cite{...}} and similar
        cleaned = cleaned.replace(
            new RegExp(`\\\\DIFdel\\{\\\\${cmd}(?:\\[[^\\]]*\\])?\\{[^{}]*\\}\\}`, 'g'),
            ''
        );
    });

    // Now remove any remaining standalone citation/ref commands
    allCommands.forEach(cmd => {
        cleaned = cleaned.replace(
            new RegExp(`\\\\${cmd}(?:\\[[^\\]]*\\])?\\{[^{}]*\\}`, 'g'),
            ''
        );
    });

    // Clean up remaining DIF wrappers (for other content)
    // Do this iteratively to handle nested cases
    for (let i = 0; i < 10; i++) {
        const before = cleaned;
        cleaned = cleaned.replace(/\\DIFaddbegin\s*/g, '');
        cleaned = cleaned.replace(/\\DIFaddend\s*/g, '');
        cleaned = cleaned.replace(/\\DIFdelbegin\s*/g, '');
        cleaned = cleaned.replace(/\\DIFdelend\s*/g, '');
        cleaned = cleaned.replace(/\\DIFadd\{([^{}]*)\}/g, '$1');
        cleaned = cleaned.replace(/\\DIFdel\{([^{}]*)\}/g, '');

        // If nothing changed, we're done
        if (cleaned === before) break;
    }

    // Clean up empty DIF commands that might be left
    cleaned = cleaned.replace(/\\DIFadd\{\}/g, '');
    cleaned = cleaned.replace(/\\DIFdel\{\}/g, '');

    // Clean up any double spaces left behind
    cleaned = cleaned.replace(/\s{2,}/g, ' ');

    // Remove any stray empty braces
    cleaned = cleaned.replace(/\{\s*\}/g, '');

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

        // console.log("Starting SwiftLaTeX compilation...");
        // console.log("LaTeX length:", cleanedTex.length, "characters");

        const engine = pdfEngine as SwiftLaTeXEngine;

        // Write the main TeX file
        engine.writeMemFSFile("main.tex", cleanedTex);

        // Compile the LaTeX document
        const result = await engine.compileLaTeX();

        // console.log("Compilation result:", result);

        if (result.status !== 0) {
            console.error("Compilation failed with status:", result.status);
            if (result.log) {
                console.error("Compilation log:", result.log);
            }
            throw new Error(`LaTeX compilation failed with status ${result.status}`);
        }

        // Read the generated PDF from memory filesystem
        const pdfData = result.pdf;

        if (!pdfData || pdfData.length === 0) {
            throw new Error("No PDF was generated");
        }

        console.log("PDF generated successfully, size:", pdfData.length, "bytes");

        // Create blob from Uint8Array - explicitly create a new Uint8Array to ensure correct type
        const pdfBytes = new Uint8Array(pdfData);
        const blob = new Blob([pdfBytes], { type: 'application/pdf' });

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

// ============================================================================
// EVENT LISTENERS
// ============================================================================

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

// Add input event listeners for live word counting
oldInput.addEventListener("input", debouncedCountOld);
newInput.addEventListener("input", debouncedCountNew);

// Initialize on page load
safeInit();