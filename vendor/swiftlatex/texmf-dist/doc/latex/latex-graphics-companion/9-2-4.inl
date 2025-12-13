\usepackage {color}
\newsavebox{\X}
\sbox{\X}{[black text] and
 \color[cmyk]{0,0.6,0.8,0}[orange text]}

Start with \usebox{\X},
and return to black

{\color{green}Start in green, see
\usebox{\X} and once again green}
