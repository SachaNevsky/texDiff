#!/usr/bin/perl -w

# Author: Alexey Shipunov, dactylorhiza@gmail.com
# Version 1.01, 20191002
# Simple text to LaTeX converter, uses 'qqru' package to define "universal" (Russian or English) quotes
# Usage: perl ./txt2qq.pl input.txt > output.tex

while(<>){
	s| "| <<|g;
	s|^"|<<|g;
	s|\t"|\t<<|g;
	s|\("|\(<<|g;
	s|\["|\[<<|g;
	s|="|=<<|g;
	s|"|>>|g;
	s|``|<<|g;
	s|''|>>|g;
	s|`|<<|g;
	s|'([^\w])|>>$1|g;
	s| - | --- |g;
	s| ---$| ---|g;
	s|^--- |--* |g;
	s|\\|BACKSLASH|g;
	s|&|\\&|g;
	s|\{|\\\{|g;
	s|\}|\\\}|g;
	s|\$|\\\$|g;
	s|\#|\\\#|g;
	s|%|\\%|g;
	s|BACKSLASH|\$\\backslash\$|g;
	s@\|@\$\\mid\$@g;
	s|_(.+?)_|\\textit\{$1\}|g;
	s|\*(.+?)\*|\\textbf\{$1\}|g;
	s|  +| |g;
	s|<<|\\<|g;
	s|>>|\\>|g;
print;
}

BEGIN {
print <<END_OF_BEGIN
\\documentclass{article}
% add more oprions here
\\usepackage[ru]{qqru}

\\begin{document}

END_OF_BEGIN
}

END{
print <<END_OF_END

\\end{document}
END_OF_END
}

#