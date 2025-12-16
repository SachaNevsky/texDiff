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
    body = body.replace(/\\mbox\\hskip/g, ' ');
    body = body.replace(/\\href\{[^}]*\}\{([^}]*)\}/g, '$1');
    body = body.replace(/\\url\{([^}]*)\}/g, '$1');
    body = body.replace(/\\hyperlink\{[^}]*\}\{([^}]*)\}/g, '$1');
    body = body.replace(/\\hypertarget\{[^}]*\}\{([^}]*)\}/g, '$1');

    body = body.replace(/\\begin\{figure\}[\s\S]*?\\end\{figure\}/g, '');
    body = body.replace(/\\begin\{table\}[\s\S]*?\\end\{table\}/g, '');

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
        const pattern = new RegExp(`\\\\${cmd}(?![a-zA-Z])`, 'g');
        body = body.replace(pattern, cmd);
    }

    body = body.replace(/\\addtocounter\{[^}]+\}\{[^}]+\}%DIFAUXCMD\s*/g, '');
    body = body.replace(/\\setcounter\{[^}]+\}\{[^}]+\}%DIFAUXCMD\s*/g, '');
    body = body.replace(/%DIFAUXCMD\s*/g, '');
    body = body.replace(/%DIFDELCMD < [^\n]*\n/g, '');
    body = body.replace(/%DIFDELCMD < /g, '');
    body = body.replace(/%DIF > /g, '');
    body = body.replace(/%DIF < /g, '');

    body = body.replace(/\\DIFdelbegin\s*\\iffalse([\s\S]*?)\\fi\s*\\DIFdelend/g, '');
    body = body.replace(/\\DIFdelbegin[\s\S]*?\\DIFdelend/g, '');

    body = body.replace(/\\DIFaddbegin\s*/g, '');
    body = body.replace(/\\DIFaddend\s*/g, '');

    body = body.replace(/\\iffalse/g, '');
    body = body.replace(/\\fi(?!\w)/g, '');

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