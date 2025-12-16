export function findMatchingBrace(str: string, startPos: number): number {
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