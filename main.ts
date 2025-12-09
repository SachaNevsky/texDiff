
// main.ts
import { WebPerlRunner, LatexDiff } from "wasm-latex-tools";

const statusEl = document.getElementById("status") as HTMLSpanElement;
const oldInput = document.getElementById("oldInput") as HTMLTextAreaElement;
const newInput = document.getElementById("newInput") as HTMLTextAreaElement;
const diffBtn = document.getElementById("diffBtn") as HTMLButtonElement;

const runner = new WebPerlRunner({
    webperlBasePath: "./vendor/wasm-latex-tools/webperl",
    perlScriptsPath: "./vendor/wasm-latex-tools/perl",
});

function setStatus(msg: string) {
    console.log("> ", msg)
    if (statusEl) statusEl.textContent = msg;
}

function ensureWrapped(content: string): string {
    const hasDocClass = /\\documentclass/.test(content);
    const hasBeginDoc = /\\begin\\{document\\}/.test(content);
    const hasEndDoc = /\\end\\{document\\}/.test(content);
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
        setStatus("Ready.");
    } catch (e) {
        console.error(e);
        setStatus("Failed to initialize diff tools.");
    }
}

async function compilePdf(diffTex: string) {
    // texlive.js attaches PDFTeX to window via pdftex.js
    // eslint-disable-next-line @typescript-eslint/ban-ts-comment
    // @ts-ignore
    const PDFTeX = (window as any).PDFTeX;
    if (!PDFTeX) {
        throw new Error("PDFTeX not available. Check that vendor/texlive.js/pdftex.js is loaded.");
    }
    const engine = new PDFTeX();
    // The demo shows compile() returning a blob URL or Blob. [4](https://manuels.github.io/texlive.js/)
    const urlOrBlob = await engine.compile(diffTex);
    if (typeof urlOrBlob === "string") return urlOrBlob;
    return URL.createObjectURL(urlOrBlob);
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

        const diff = await diffTool.diff(oldWrapped, newWrapped, {
            type: "UNDERLINE",
            flatten: true
        });

        setStatus("Compiling PDF...");
        const pdfUrl = await compilePdf(diff.output);
        window.open(pdfUrl, "_blank");
        setStatus("PDF opened.");
    } catch (e) {
        console.error(e);
        setStatus("Error during diff or compile.");
    }
}

diffBtn.addEventListener("click", generateDiffPdf);
initTools();
