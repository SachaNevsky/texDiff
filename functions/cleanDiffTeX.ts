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

    body = body.replace(/~\\mbox\\hskip\s*0\s*pt/g, '~');
    body = body.replace(/\\mbox\\hskip\s*\d+(?:\.\d+)?\s*pt/g, ' ');
    body = body.replace(/\\mbox\\hskip\s*\d+(?:\.\d+)?\s*em/g, ' ');
    body = body.replace(/\\mbox\\hskip/g, '\\hskip');
    body = body.replace(/\\href\{[^}]*\}\{([^}]*)\}/g, '$1');
    body = body.replace(/\\url\{([^}]*)\}/g, '$1');
    body = body.replace(/\\hyperlink\{[^}]*\}\{([^}]*)\}/g, '$1');
    body = body.replace(/\\hypertarget\{[^}]*\}\{([^}]*)\}/g, '$1');

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

                const charBefore = idx > 0 ? body[idx - 1] : '';
                const charAfter = body[idx + cmdPattern.length];

                if ((charBefore === '\\' || /[a-zA-Z]/.test(charBefore)) ||
                    (charAfter && /[a-zA-Z]/.test(charAfter))) {
                    result += body.substring(pos, idx + 1);
                    pos = idx + 1;
                    continue;
                }

                result += body.substring(pos, idx);
                let searchPos = idx + cmdPattern.length;

                while (body[searchPos] === '[') {
                    const closeBracket = body.indexOf(']', searchPos);
                    if (closeBracket !== -1) {
                        searchPos = closeBracket + 1;
                    } else {
                        break;
                    }
                }

                if (body[searchPos] === '{') {
                    const closeBrace = findMatchingBrace(body, searchPos + 1);
                    if (closeBrace !== -1) {
                        pos = closeBrace + 1;
                        changed = true;
                        continue;
                    }
                }

                pos = searchPos;
            }

            body = result;
            if (!changed) break;
        }
    }

    body = body.replace(/\\addtocounter\{[^}]+\}\{[^}]+\}%DIFAUXCMD\s*/g, '');
    body = body.replace(/\\setcounter\{[^}]+\}\{[^}]+\}%DIFAUXCMD\s*/g, '');
    body = body.replace(/%DIFAUXCMD\s*/g, '');
    body = body.replace(/%DIFDELCMD < [^\n]*\n/g, '');
    body = body.replace(/%DIFDELCMD < /g, '');
    body = body.replace(/%DIF > /g, '');
    body = body.replace(/%DIF < /g, '');
    body = body.replace(/\\DIFdelbegin\s*\\iffalse([\s\S]*?)\\fi\s*\\DIFdelend/g, '\\DIFdelbegin$1\\DIFdelend');
    body = body.replace(/\\DIFadd\{\}/g, '');
    body = body.replace(/\\DIFdel\{\}/g, '');
    body = body.replace(/\\DIFaddFL\{\}/g, '');
    body = body.replace(/\\DIFdelFL\{\}/g, '');
    body = body.replace(/\\mbox\s+(?![{])/g, ' ');
    body = body.replace(/\s{3,}/g, '  ');
    body = body.replace(/\{\s*\}/g, '');
    body = body.replace(/\s+([.,;:!?])/g, '$1');

    return preamble + body;
}