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

    // STEP 1: Fix latexdiff-specific constructs FIRST before any other processing
    // These are special constructs that latexdiff inserts that only work with its macros

    // Replace ~\mbox\hskip0pt with just ~ (non-breaking space)
    body = body.replace(/~\\mbox\\hskip\s*0\s*pt/g, '~');

    // Replace other \mbox\hskip variants
    body = body.replace(/\\mbox\\hskip\s*\d+(?:\.\d+)?\s*pt/g, ' ');
    body = body.replace(/\\mbox\\hskip\s*\d+(?:\.\d+)?\s*em/g, ' ');

    // Replace standalone \mbox\hskip (without the tilde prefix)
    body = body.replace(/\\mbox\\hskip/g, '\\hskip');

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

    // STEP 2: Remove problematic commands EARLY (before unwrapping DIF)

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

    // Replace problematic commands with empty string
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
                const charBefore = idx > 0 ? body[idx - 1] : '';
                const charAfter = body[idx + cmdPattern.length];

                // Must not be preceded by backslash or letter, and not followed by letter
                if ((charBefore === '\\' || /[a-zA-Z]/.test(charBefore)) ||
                    (charAfter && /[a-zA-Z]/.test(charAfter))) {
                    result += body.substring(pos, idx + 1);
                    pos = idx + 1;
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

    // STEP 3: Remove DIFAUXCMD comments and the commands they mark
    body = body.replace(/\\addtocounter\{[^}]+\}\{[^}]+\}%DIFAUXCMD\s*/g, '');
    body = body.replace(/\\setcounter\{[^}]+\}\{[^}]+\}%DIFAUXCMD\s*/g, '');
    body = body.replace(/%DIFAUXCMD\s*/g, '');

    // STEP 4: Handle DIFdel blocks with \iffalse...\fi wrappers
    body = body.replace(/\\DIFdelbegin\s*\\iffalse[\s\S]*?\\fi\s*\\DIFdelend/g, '');
    body = body.replace(/\\DIFdelbegin[\s\S]*?\\DIFdelend/g, '');

    // STEP 5: Remove DIFDELCMD markers
    body = body.replace(/%DIFDELCMD < [^\n]*\n/g, '');
    body = body.replace(/%DIFDELCMD < /g, '');
    body = body.replace(/%DIF > /g, '');
    body = body.replace(/%DIF < /g, '');

    // STEP 6: Remove DIFaddbegin/DIFaddend markers
    body = body.replace(/\\DIFaddbegin\s*/g, '');
    body = body.replace(/\\DIFaddend\s*/g, '');

    // STEP 7: Unwrap DIF commands
    for (let iteration = 0; iteration < 10; iteration++) {
        const before = body;
        let result = '';
        let pos = 0;

        while (pos < body.length) {
            let handled = false;

            // Check for DIFadd or DIFaddFL - keep content
            const addCommands = ['\\DIFadd{', '\\DIFaddFL{'];
            for (const cmd of addCommands) {
                if (body.substring(pos, pos + cmd.length) === cmd) {
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
                if (body.substring(pos, pos + cmd.length) === cmd) {
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

    // STEP 8: Clean up any remaining orphaned \iffalse or \fi commands
    body = body.replace(/\\iffalse/g, '');
    body = body.replace(/\\fi(?!\w)/g, '');

    // STEP 9: Clean up empty DIF commands (if any remain)
    body = body.replace(/\\DIFadd\{\}/g, '');
    body = body.replace(/\\DIFdel\{\}/g, '');
    body = body.replace(/\\DIFaddFL\{\}/g, '');
    body = body.replace(/\\DIFdelFL\{\}/g, '');

    // STEP 10: Final cleanup of any remaining malformed \mbox constructs
    body = body.replace(/\\mbox\s+(?![{])/g, ' ');

    // STEP 11: Clean up excessive whitespace
    body = body.replace(/\s{3,}/g, '  ');
    body = body.replace(/\{\s*\}/g, '');
    body = body.replace(/\s+([.,;:!?])/g, '$1');

    return preamble + body;
}