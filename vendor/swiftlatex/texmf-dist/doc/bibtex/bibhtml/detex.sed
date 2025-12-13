# Edit TeXisms in the .bbl output, to make it HTML-ready
# From bibhtml release 2.0.2, of 2013 September 8.
# Hg node 7076ce83a035.
# See http://purl.org/nxg/dist/bibhtml

# Remove %\n line-breaks added by BibTeX
/% *$/{
  :a
  N
  s/% *\n//
  t a
}

# Escape ampersands
s,&,&amp;,g

# Process DOI:{...} lines, escaping '<' characters in DOIs and rearranging into a <a> element
# (the substitutions below probably rely on the "DOI:" being at the beginning of a line).
# First, turn DOI:{X} into DOI:{X|X}
/^ *DOI/s,DOI:{\([^}]*\)},DOI:{\1|\1},
# Escape the two DOIs differently...
#    ...first do URL escaping
#    ...then do HTML/XML escaping
/^ *DOI:/{
  :bx
  s,\([^<|]*\)<\([^|]*\)|,\1%3C\2|,
  t bx
  :cx
  s,\([^<}]*\)<\([^}]*\)},\1\&lt;\2},
  t cx
}
# ...and then turn the result into a <a> element
/^ *DOI:{/s,DOI:{\([^|]*\)|\([^}]*\)},doi:<a href='http://dx.doi.org/\1'><code>\2</code></a>,

# Get rid of TeX braces (I hope there aren't any of these in DOIs or other URLs)
s/[{}]//g

# Replace '~' ties with spaces, as lont as they aren't URL ".../~user"
s,\([^/]\)~,\1 ,g
# ...and '\ ' with plain space
s,\\ , ,g

# accented characters
s,\\'a,á,g
s,\\'e,é,g
s,\\`e,è,g
s,\\^o,ô,g
s+\\,c+ç+g
s,\\ss,ß,g
s,\\"a,ä,g
s,\\"o,ö,g
s,\\"u,ü,g
# We could include the following substitution, but I'm nervous of that,
# because I'm not positive that "--" can't legitimately appear in DOIs
# (the above substitutions are also in principle illegitimate for the same reason,
# but they seem safely unlikely).
#s,--,–,
