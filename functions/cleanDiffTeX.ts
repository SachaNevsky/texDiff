import { findMatchingBrace } from "./findMatchingBrace"

export function cleanDiffTeX(diffTex: string): string {
    const beginDocMatch = diffTex.match(/\\begin\{document\}/);
    if (!beginDocMatch) {
        return diffTex;
    }

    const splitIndex = beginDocMatch.index! + beginDocMatch[0].length;
    let preamble = diffTex.substring(0, splitIndex);
    let body = diffTex.substring(splitIndex);

    preamble = preamble.replace(/\\RequirePackage\{color\}/g, '\\usepackage{color}');
    preamble = preamble.replace(/\\usepackage\[T1\]\{fontenc\}/g, '');
    preamble = preamble.replace(/\\usepackage\{lmodern\}/g, '');
    preamble = preamble.replace(/\\usepackage\[.*?\]\{hyperref\}/g, '');
    preamble = preamble.replace(/\\usepackage\{hyperref\}/g, '');

    body = body.replace(/\\href\{[^}]*\}\{([^}]*)\}/g, '$1');
    body = body.replace(/\\url\{([^}]*)\}/g, '$1');
    body = body.replace(/\\hyperlink\{[^}]*\}\{([^}]*)\}/g, '$1');
    body = body.replace(/\\hypertarget\{[^}]*\}\{([^}]*)\}/g, '$1');
    body = body.replace(/\\begin\{figure\*?\}[\s\S]*?\\end\{figure\*?\}/g, '');
    body = body.replace(/\\begin\{table\*?\}[\s\S]*?\\end\{table\*?\}/g, '');
    body = body.replace(/\\begin\{wrapfigure\}[\s\S]*?\\end\{wrapfigure\}/g, '');
    body = body.replace(/\\begin\{wraptable\}[\s\S]*?\\end\{wraptable\}/g, '');

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

    for (const cmd of allProblematicCommands) {
        let pos = 0;
        while (pos < body.length) {
            const cmdPattern = `\\${cmd}`;
            const idx = body.indexOf(cmdPattern, pos);

            if (idx === -1) break;

            const charBefore = idx > 0 ? body[idx - 1] : '';
            const charAfter = body[idx + cmdPattern.length];

            if ((charBefore === '\\' || /[a-zA-Z]/.test(charBefore)) ||
                (charAfter && /[a-zA-Z]/.test(charAfter))) {
                pos = idx + 1;
                continue;
            }

            let searchPos = idx + cmdPattern.length;
            while (body[searchPos] && /\s/.test(body[searchPos])) searchPos++;

            if (body[searchPos] === '[') {
                const closeBracket = body.indexOf(']', searchPos);
                if (closeBracket !== -1) {
                    searchPos = closeBracket + 1;
                    while (body[searchPos] && /\s/.test(body[searchPos])) searchPos++;
                }
            }

            if (body[searchPos] === '{') {
                const closeBrace = findMatchingBrace(body, searchPos + 1);
                if (closeBrace !== -1) {
                    const content = body.substring(searchPos + 1, closeBrace);
                    const escapedContent = content.replace(/_/g, '\\_');

                    body = body.substring(0, idx) + escapedContent + body.substring(closeBrace + 1);
                    pos = idx + escapedContent.length;
                    continue;
                }
            }

            body = body.substring(0, idx) + cmd + body.substring(idx + cmdPattern.length);
            pos = idx + cmd.length;
        }
    }

    body = body.replace(/\\addtocounter\{[^}]+\}\{[^}]+\}%DIFAUXCMD\s*/g, '');
    body = body.replace(/\\setcounter\{[^}]+\}\{[^}]+\}%DIFAUXCMD\s*/g, '');
    body = body.replace(/%DIFAUXCMD\s*/g, '');
    body = body.replace(/%DIFDELCMD < [^\n]*\n/g, '');
    body = body.replace(/%DIFDELCMD < /g, '');
    body = body.replace(/%DIF > /g, '');
    body = body.replace(/%DIF < /g, '');
    body = body.replace(/\\DIFdelbegin\s*/g, '');
    body = body.replace(/\\DIFdelend\s*/g, '');
    body = body.replace(/\\DIFaddbegin\s*/g, '');
    body = body.replace(/\\DIFaddend\s*/g, '');
    body = body.replace(/\\iffalse[\s\S]*?\\fi(?!\w)/g, '');
    body = body.replace(/\\DIFadd\{\}/g, '');
    body = body.replace(/\\DIFdel\{\}/g, '');
    body = body.replace(/\\DIFaddFL\{\}/g, '');
    body = body.replace(/\\DIFdelFL\{\}/g, '');
    body = body.replace(/\s{3,}/g, '  ');
    body = body.replace(/\{\s*\}/g, '');
    body = body.replace(/\s+([.,;:!?])/g, '$1');

    return preamble + body;
}