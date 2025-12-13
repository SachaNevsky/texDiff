\DeclareRobustCommand\PST{\texttt{PSTricks\xspace}}
\DeclareRobustCommand\PS{\texttt{PostScript\xspace}}
\def\dt{\ensuremath{\,\mathrm{d}t}}
\def\Index#1{\index{#1}#1}
%
\def\LPack#1{\texttt{#1}\index{#1@\texttt{#1}}\index{Package!#1@\texttt{#1}}}
\def\nxLPack#1{\texttt{#1}}
\def\Lprog#1{\texttt{#1}\index{#1@\texttt{#1}}\index{Program!#1@\texttt{#1}}}
\let\nxLprog\nxLPack
\def\LFile#1{\texttt{#1}\index{#1@\texttt{#1}}\index{File!#1@\texttt{#1}}}
\def\nxLFile#1{\texttt{#1}}
\def\Lext#1{\texttt{.#1}\index{#1@\texttt{.#1}}\index{Extension!#1@\texttt{.#1}}}
\def\nxLext#1{\texttt{.#1}}
\def\xLcs#1{\index{#1@\nxLcs{#1}}\index{Macro!#1@\nxLcs{#1}}}
\def\Lcs#1{\nxLcs{#1}\xLcs{#1}}
\def\LcsStar#1{\index{#1*@\nxLcs{#1*}}\index{Macro!#1@\nxLcs{#1*}}\nxLcs{#1}\OptArg*{*}}
\def\nxLcs#1{\texttt{\textbackslash#1}}
\def\xLenv#1{\index{#1@\texttt{#1}}\index{Environment!#1@\texttt{#1}}}
\def\Lenv#1{\texttt{#1}\xLenv{#1}}
\def\Ldim#1{\texttt{\textbackslash#1}\index{#1@\texttt{\textbackslash#1}}\index{Dimension!#1@\texttt{\textbackslash#1}}}
\def\Lskip#1{\texttt{\textbackslash#1}\index{#1@\texttt{\textbackslash#1}}\index{Skip!#1@\texttt{\textbackslash#1}}}
\def\Lkeyword#1{\texttt{#1}\xLkeyword{#1}}
\def\xLkeyword#1{\index{#1@\texttt{#1}}\index{Keyword!#1@\texttt{#1}}}
\def\nxLkeyword#1{\texttt{#1}}

\def\LKeyword#1{\LKeyword@i#1!!}
\def\LKeyword@i#1=#2!!{\Lkeyword{#1}\nxLkeyword{=#2}}
\let\nxLKeyword\nxLenv % same formatting

\let\nxLkeyval\nxLkeyword
\let\nxLenv\nxLkeyword
\let\nxLps\nxLkeyword
\def\LColor#1{\texttt{#1}\xLColor{#1}}
\def\xLColor#1{\index{#1@\texttt{#1}}\index{Color!#1@\texttt{#1}}}
\def\Lkeyval#1{\texttt{#1}\xLkeyval{#1}}
\def\xLkeyval#1{\index{#1@\texttt{#1}}\index{Keyvalue!#1@\texttt{#1}}}
\def\xLoption#1{\index{#1@\texttt{#1}}\index{Package option!#1@\texttt{#1}}}
\def\Loption#1{\texttt{#1}\xLoption{#1}}
\def\LPS#1{\texttt{#1}\index{#1@\texttt{#1}}\index{PostScript!#1@\texttt{#1}}}
\def\xLps#1{\index{#1@\texttt{#1}}\index{PostScript!#1@\texttt{#1}}}
\def\nxLps#1{\texttt{#1}}
\def\Lps#1{\nxLps{#1}\xLps{#1}}
\def\LClass#1{\texttt{#1}\index{#1@\texttt{#1}}\index{Class!#1@\texttt{#1}}}
\let\nxLClass\nxLPack
\let\nxLdim\nxLcs
\let\nxLskip\nxLcs
\def\Lctr#1{\texttt{#1}\index{#1@\texttt{#1}}\index{Counter!#1@\texttt{#1}}}
\def\LCtr#1{\texttt{#1}\index{#1@\texttt{#1}}\index{TeX Counter@\TeX\ Counter!#1@\texttt{#1}}}
\def\nxLctr#1{\texttt{#1}}
%
\newcommand\Lnotation [1]{\nxLnotation{#1}\xLnotation{#1}}
\newcommand\Lmnotation[1]{\nxLnotation{#1}\xLmnotation{#1}}
\newcommand\xLnotation[1]{\index{Syntax!#1@\nxLnotation{#1}}\index{#1@\nxLnotation{#1}}}
\def\nxLnotation#1{\texttt{#1}}
\def\xLkeyset#1{\expandafter\xLkeyset@i#1\@nil}
\def\xLkeyset@i#1=#2\@nil{\index{#1@\texttt{#1}}\index{Keyword!#1@\texttt{#1}}
  \index{#2@\texttt{#2}}\index{Value!#2@\texttt{#2}}}
\def\Lkeyset#1{\expandafter\Lkeyset@i#1\@nil}
\def\Lkeyset@i#1=#2\@nil{\texttt{#1=#2}%
  \index{#1@\texttt{#1}}\index{Keyword!#1@\texttt{#1}}
  \index{#2@\texttt{#2}}\index{Value!#2@\texttt{#2}}}
%
\def\xLKeyset#1{\expandafter\xLKeyset@i#1\@nil}% without using the right value of =
\def\xLKeyset@i#1=#2\@nil{\index{#1@\texttt{#1}}\index{Keyword!#1@\texttt{#1}}}
\def\LKeyset#1{\expandafter\LKeyset@i#1\@nil}
\def\LKeyset@i#1=#2\@nil{\texttt{#1=#2}%
  \index{#1@\texttt{#1}}\index{Keyword!#1@\texttt{#1}}}
\let\LKeyword\LKeyset
%
\newcommand\Larg [1]{{\normalfont\itshape#1\/}}
\newcommand\Larga[1]{$\langle$\Larg{#1}$\rangle$}% angles
\newcommand\Largb[1]{\lcb\Larg{#1}\rcb}          % curly brace
\newcommand\Largs[1]{\lsb\Larg{#1}\rsb}          % square brackets
\newcommand\Largr[1]{\lrb\Larg{#1}\rrb}          % round brackets
\newcommand\LBEG[1]{{\normalfont\ttfamily\bs{}begin\lcb#1\rcb}\xLenv{#1}}
\newcommand\LmBEG[1]{{\normalfont\ttfamily\bs{}begin\lcb#1\rcb}\xLmenv{#1}}
\newcommand\LEND[1]{{\normalfont\ttfamily\bs{}end\lcb#1\rcb}\xLenv{#1}}
\newcommand\LmEND[1]{{\normalfont\ttfamily\bs{}end\lcb#1\rcb}\xLmenv{#1}}
%
\DeclareRobustCommand\bs{{\normalfont\ttfamily\textbackslash}}  % \let\bslash=\bs
\DeclareRobustCommand\lcb{{\normalfont\ttfamily\textbraceleft}}
\DeclareRobustCommand\rcb{{\normalfont\ttfamily\textbraceright}}
\DeclareRobustCommand\lsb{{\normalfont\ttfamily[}}
\DeclareRobustCommand\rsb{{\normalfont\ttfamily]}}
\DeclareRobustCommand\lrb{{\normalfont\ttfamily(}}
\DeclareRobustCommand\rrb{{\normalfont\ttfamily)}}
\DeclareRobustCommand\false{{\ttfamily false}}
\DeclareRobustCommand\true{{\ttfamily true}}

%
% without brackets
\def\Coordx#1{$x_{#1}$}
\def\Coordy#1{$y_{#1}$}
\def\Coordz#1{$z_{#1}$}
\def\Coord#1{\Coordx{#1},\kern 1pt\Coordy{#1}}
\def\Coordn{\Coordx{n},\kern 1pt\Coordy{n}}
\def\CoordIII#1{\Coordx{#1},\kern 1pt\Coordy{#1},\kern 1pt\Coordz{#1}}% HjG
\def\CAny{\Coordx{},\kern 1pt\Coordy{}}
\def\CIIIAny{\Coordx{},\kern 1pt\Coordy{},\kern 1pt\Coordz{}}%  hv
% with brackets
\def\coord#1{(\Coordx{#1},\kern 1pt\Coordy{#1})}
\def\coordn{(\Coordx{n},\kern 1pt\Coordy{n})}
\def\coordiii#1{(\Coordx{#1},\kern 1pt\Coordy{#1},\kern 1pt\Coordz{#1})}% hv
\def\coordx#1{($x_{#1}$)}
\def\coordy#1{($y_{#1}$)}
\def\coordz#1{($z_{#1}$)}
\def\cAny{(\Coordx{},\kern 1pt\Coordy{})}
\def\ciiiAny{(\Coordx{},\kern 1pt\Coordy{},\kern 1pt\Coordz{})}% hv
%
\newskip\BDefaboveskip
\newskip\BDefbelowskip
\newskip\BDefinlineskip
\setlength\BDefaboveskip{0pt plus 2pt}% first-level list topsep
\setlength\BDefbelowskip{10pt}
\setlength\BDefinlineskip{6pt}
%
\makeatletter
\newsavebox{\boxdef}
\newenvironment{BDef}
  {\begin{lrbox}\boxdef
      \def\arraystretch{1.0}
      \begin{tabular}{@{}l@{}l@{}l@{}}}
  {\end{tabular}\end{lrbox}
%
% braces around next block are needed to stop the list env checking for blank lines
% and the \aftergroups then for making sure no indentation happens ... as i said
% urg
%
   {\BCmd\fbox{\usebox\boxdef}\endBCmd}
   \aftergroup\@afterindentfalse\aftergroup\@afterheading
  }
\newenvironment{BDef*}
  {\begin{lrbox}\boxdef
      \def\arraystretch{1.0}
      \begin{tabular}{@{}l@{}l@{}l@{}}
  }
  {\end{tabular}\end{lrbox}
   {\begin{BCmd*}\fbox{\usebox\boxdef}\end{BCmd*}}
   \aftergroup\@afterindentfalse\aftergroup\@afterheading
  }
\newenvironment{BCmd}{
  \@beginparpenalty-\@lowpenalty
  \topsep\BDefaboveskip
  \fboxsep3pt
  \flushleft}
 {\@endparpenalty\@M
  \@topsepadd\BDefbelowskip
  \endflushleft}

\newenvironment{BCmd*}{
  \@beginparpenalty\@M
  \topsep\BDefinlineskip
  \fboxsep3pt
  \flushleft}
 {\@endparpenalty5000
  \endflushleft}


\def\OptArgs{\colorbox{black!20}{\texttt{[Options]}}\kern1pt}
\def\OptArg{\@ifnextchar*\OptArg@i{\OptArg@ii*}}% star version without braces
\def\OptArg@i*#1{\colorbox{black!20}{\texttt{#1}}\kern1pt}
\def\OptArg@ii*#1{\colorbox{black!20}{\texttt{[#1]}}\kern1pt}
\def\DBS{{\ttfamily\textbackslash\textbackslash}}

\makeatother