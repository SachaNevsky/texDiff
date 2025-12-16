export function ensureWrapped(content: string): string {
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