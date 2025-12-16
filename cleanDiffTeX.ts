export function cleanDiffTeX(diffTex: string): string {
    // Split into preamble and document body
    const beginDocMatch = diffTex.match(/\\begin\{document\}/);
    if (!beginDocMatch) {
        return diffTex;
    }

    const splitIndex = beginDocMatch.index! + beginDocMatch[0].length;
    let preamble = diffTex.substring(0, splitIndex);
    let body = diffTex.substring(splitIndex);

    // ========== CLEAN PREAMBLE ==========

    preamble = preamble.replace(/\\RequirePackage\{color\}/g, '\\usepackage{color}');
    preamble = preamble.replace(/\\usepackage\[T1\]\{fontenc\}/g, '');
    preamble = preamble.replace(/\\usepackage\{lmodern\}/g, '');
    preamble = preamble.replace(/\\usepackage\[.*?ps2pdf.*?\]\{hyperref\}/g, '\\usepackage[pdftex]{hyperref}');
    preamble = preamble.replace(/\\usepackage\{hyperref\}/g, '\\usepackage[pdftex]{hyperref}');

    // ========== CLEAN BODY ==========

    // Helper function to find matching brace
    function findMatchingBrace(str: string, startPos: number): number {
        let braceCount = 1;
        let pos = startPos;

        while (pos < str.length && braceCount > 0) {
            const char = str[pos];
            const prevChar = pos > 0 ? str[pos - 1] : '';

            if (char === '{' && prevChar !== '\\') {
                braceCount++;
            } else if (char === '}' && prevChar !== '\\') {
                braceCount--;
                if (braceCount === 0) {
                    return pos;
                }
            }
            pos++;
        }

        return -1;
    }

    // STEP 1: Remove problematic commands EARLY (before unwrapping DIF)
    // This includes citations, references, and labels that would cause errors

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

    const labelCommands = ['label'];

    const allProblematicCommands = [...citationCommands, ...refCommands, ...labelCommands];

    // Replace problematic commands with placeholders (preserves text flow)
    for (const cmd of allProblematicCommands) {
        const cmdPattern = `\\${cmd}`;

        for (let iter = 0; iter < 3; iter++) {
            let pos = 0;
            let result = '';
            let changed = false;

            while (pos < body.length) {
                const idx = body.indexOf(cmdPattern, pos);

                if (idx === -1) {
                    result += body.substring(pos);
                    break;
                }

                // Check if this is actually the command (not part of another word)
                const charAfter = body[idx + cmdPattern.length];
                if (charAfter && /[a-zA-Z]/.test(charAfter)) {
                    // Part of a longer command name, skip it
                    result += body.substring(pos, idx + cmdPattern.length);
                    pos = idx + cmdPattern.length;
                    continue;
                }

                // Add everything before this command
                result += body.substring(pos, idx);

                // Skip past the command name
                let searchPos = idx + cmdPattern.length;

                // Skip optional argument [...]
                while (body[searchPos] === '[') {
                    const closeBracket = body.indexOf(']', searchPos);
                    if (closeBracket !== -1) {
                        searchPos = closeBracket + 1;
                    } else {
                        break;
                    }
                }

                // Handle mandatory argument {...}
                if (body[searchPos] === '{') {
                    const closeBrace = findMatchingBrace(body, searchPos + 1);
                    if (closeBrace !== -1) {
                        // Replace with empty string (or could use placeholder like "[?]")
                        // result += '[?]';  // Use this if you want to see where citations were
                        pos = closeBrace + 1;
                        changed = true;
                        continue;
                    }
                }

                // If no braces found, just skip the command name
                pos = searchPos;
            }

            body = result;
            if (!changed) break;
        }
    }

    // STEP 2: Remove DIFAUXCMD comments and the commands they mark
    body = body.replace(/\\addtocounter\{[^}]+\}\{[^}]+\}%DIFAUXCMD\s*/g, '');
    body = body.replace(/\\setcounter\{[^}]+\}\{[^}]+\}%DIFAUXCMD\s*/g, '');
    body = body.replace(/%DIFAUXCMD\s*/g, '');

    // STEP 3: Handle DIFdel blocks with \iffalse...\fi wrappers
    body = body.replace(/\\DIFdelbegin\s*\\iffalse[\s\S]*?\\fi\s*\\DIFdelend/g, '');
    body = body.replace(/\\DIFdelbegin[\s\S]*?\\DIFdelend/g, '');

    // STEP 4: Remove DIFDELCMD markers
    body = body.replace(/%DIFDELCMD < [^\n]*\n/g, '');
    body = body.replace(/%DIFDELCMD < /g, '');
    body = body.replace(/%DIF > /g, '');
    body = body.replace(/%DIF < /g, '');

    // STEP 5: Remove DIFaddbegin/DIFaddend markers
    body = body.replace(/\\DIFaddbegin\s*/g, '');
    body = body.replace(/\\DIFaddend\s*/g, '');

    // STEP 6: Unwrap DIF commands (now that problematic commands are already removed)
    for (let iteration = 0; iteration < 10; iteration++) {
        const before = body;
        let result = '';
        let pos = 0;

        while (pos < body.length) {
            let handled = false;

            // Check for DIFadd or DIFaddFL - keep content
            const addCommands = ['\\DIFadd{', '\\DIFaddFL{'];
            for (const cmd of addCommands) {
                if (body.substring(pos).startsWith(cmd)) {
                    const startPos = pos + cmd.length;
                    const endPos = findMatchingBrace(body, startPos);

                    if (endPos !== -1) {
                        // Keep the content inside
                        result += body.substring(startPos, endPos);
                        pos = endPos + 1;
                        handled = true;
                        break;
                    }
                }
            }

            if (handled) continue;

            // Check for DIFdel or DIFdelFL - remove content
            const delCommands = ['\\DIFdel{', '\\DIFdelFL{'];
            for (const cmd of delCommands) {
                if (body.substring(pos).startsWith(cmd)) {
                    const startPos = pos + cmd.length;
                    const endPos = findMatchingBrace(body, startPos);

                    if (endPos !== -1) {
                        // Skip the entire deleted section
                        pos = endPos + 1;
                        handled = true;
                        break;
                    }
                }
            }

            if (handled) continue;

            // Regular character - keep it
            result += body[pos];
            pos++;
        }

        body = result;
        if (body === before) break;
    }

    // STEP 7: Clean up any remaining orphaned \iffalse or \fi commands
    body = body.replace(/\\iffalse/g, '');
    body = body.replace(/\\fi(?!\w)/g, '');

    // STEP 8: Clean up empty DIF commands (if any remain)
    body = body.replace(/\\DIFadd\{\}/g, '');
    body = body.replace(/\\DIFdel\{\}/g, '');
    body = body.replace(/\\DIFaddFL\{\}/g, '');
    body = body.replace(/\\DIFdelFL\{\}/g, '');

    // STEP 9: Fix malformed \mbox commands (e.g., \mbox\hskip -> \mbox{\hskip})
    // This might be in the original latexdiff output
    body = body.replace(/\\mbox\\hskip\s*(\d+(?:\.\d+)?)\s*pt/g, '\\mbox{\\hskip $1pt}');
    body = body.replace(/\\mbox\\hskip\s*(\d+(?:\.\d+)?)\s*em/g, '\\mbox{\\hskip $1em}');

    // More general fix: if we see \mbox followed by something other than {, wrap it
    body = body.replace(/\\mbox\s+([^{])/g, '\\mbox{} $1');

    // STEP 10: Clean up excessive whitespace
    body = body.replace(/\s{3,}/g, '  '); // Max 2 spaces
    body = body.replace(/\{\s*\}/g, '');

    // Clean up space before punctuation
    body = body.replace(/\s+([.,;:!?])/g, '$1');

    return preamble + body;
}