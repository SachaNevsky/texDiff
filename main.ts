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
        await runner.initialize();

        // Wait for SwiftLaTeX to be available
        await waitForSwiftLaTeX();

        setStatus("Ready.");
    } catch (e) {
        console.error(e);
        setStatus("Failed to initialize diff tools.");
    }
}

function waitForSwiftLaTeX(): Promise<void> {
    return new Promise((resolve, reject) => {
        let attempts = 0;
        const maxAttempts = 50;

        const checkSwiftLaTeX = () => {
            // @ts-ignore
            if (typeof PdfTeXEngine !== 'undefined') {
                resolve();
            } else if (attempts >= maxAttempts) {
                reject(new Error("SwiftLaTeX failed to load"));
            } else {
                attempts++;
                setTimeout(checkSwiftLaTeX, 100);
            }
        };

        checkSwiftLaTeX();
    });
}

async function compilePdf(diffTex: string): Promise<string> {
    // @ts-ignore
    if (typeof PdfTeXEngine === 'undefined') {
        throw new Error("SwiftLaTeX not available.");
    }

    console.log("Creating SwiftLaTeX engine...");

    try {
        // @ts-ignore
        const engine = new PdfTeXEngine();
        await engine.loadEngine();

        console.log("Compiling LaTeX...");
        console.log("LaTeX source length:", diffTex.length);

        // Write the main tex file
        engine.writeMemFSFile("main.tex", diffTex);

        // Compile
        const result = await engine.compileLaTeX();

        console.log("Compilation result:", result);

        if (result.status === 0) {
            // Read the PDF from memory
            const pdfData = engine.readMemFSFile("main.pdf");
            const blob = new Blob([pdfData], { type: 'application/pdf' });
            return URL.createObjectURL(blob);
        } else {
            const log = engine.readMemFSFile("main.log");
            console.error("Compilation log:", new TextDecoder().decode(log));
            throw new Error("LaTeX compilation failed");
        }
    } catch (error) {
        console.error("SwiftLaTeX compilation error:", error);
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