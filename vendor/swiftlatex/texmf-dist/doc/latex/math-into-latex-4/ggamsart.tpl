% Template file: amsart.tpl

% Preamble
\documentclass{amsart}
\usepackage{amssymb,latexsym}

% Theorems, corollaries, lemmas, and propositions, in the most 
% emphatic (plain) style. All are numbered separately.
% There is a Main Theorem in the most emphatic (plain) 
% style, unnumbered. There are definitions, in the less emphatic
% (definition) style. There are notations, in the least emphatic
%(remark) style, unnumbered.

\theoremstyle{plain}
\newtheorem{theorem}{Theorem}
\newtheorem{corollary}{Corollary}
\newtheorem*{main}{Main Theorem}
\newtheorem{lemma}{Lemma}
\newtheorem{proposition}{Proposition}

\theoremstyle{definition}
\newtheorem{definition}{Definition}

\theoremstyle{remark}
\newtheorem*{notation}{Notation}

\begin{document}

\title[shorttitle]{titleline1\\ 
                   titleline2}
\author{George~Gr\"{a}tzer}
\address{University of Manitoba\\ 
         Department of Mathematics\\  
         Winnipeg, MB R3T 2N2\\ 
         Canada} 
\email{gratzer@ms.umanitoba.ca}
\urladdr{http://server.maths.umanitoba.ca/homepages/gratzer/}
\thanks{Research supported by the NSERC of Canada.} 

\keywords{keywords}
\subjclass[2000]{Primary: subject; Secondary: subject}
\date{date}

\begin{abstract}
   abstract
\end{abstract}
\maketitle

\begin{thebibliography}{99}

\end{thebibliography}
\end{document}

Papers:

\bibitem{xxx}
   author, \emph{title}, journal \textbf{volume} 
    (year), pp.~pages.

Books:

\bibitem{xxx}
   author, \emph{title}, publisher, address, year.

\bibitem{xxx}
   author, \emph{title}, series, vol.~volume, 
    publisher, address, edition, date.

\bibitem{xxx}
   editor, ed., \emph{title}, publisher, address, year.

Papers in books:

\bibitem{xxx}
   author, \emph{title}, book title, publisher, 
    year, pp~pages.

\bibitem{xxx}
   author, \emph{title}, book title (editor, ed.), 
    vol.~volume, publisher, publisher address, date, 
    pp.~pages.

Theses:

\bibitem{xxx}
   author, \emph{title}, Ph.D. thesis, university, year.

Tech reports:

\bibitem{xxx}
   author, \emph{title}, tech. report, university, year.

Research notes:

\bibitem{xxx}
   author, \emph{title}, Research Note number,  
    university, location, date, research paper in
    preparation. 

Conference proceedings:

\bibitem{xxx}
   author, \emph{title}, conference title (location, 
    year).

\bibitem{xxx}
   author, \emph{title}, conference title, year
    (editor, ed.), vol.~volume, publisher, address, 
    pp.~pages. 
  
Abstracts:

\bibitem{xxx}
   author, \emph{title}, Abstract: journal, volume, 
    year.