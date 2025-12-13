% Template file: amsart.tpl

% Preamble
\documentclass{amsart}
\usepackage{amssymb,latexsym}

% Option 1
% Theorems, lemmas, definitions in the most
% emphatic (plain) style, all separately numbered.

\theoremstyle{plain}
\newtheorem{theorem}{Theorem}
\newtheorem{lemma}{Lemma}
\newtheorem{definition}{Definition}

% Option 2
% Theorems, lemmas, definitions, and corollaries in the most
% emphatic (plain) style, all consecutively numbered.

\theoremstyle{plain}
\newtheorem{theorem}{Theorem}
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem{definition}[theorem]{Definition}
\newtheorem{corollary}[theorem]{Corollary}

% Option 3
% Theorems, propositions, lemmas, and definitions
% in the most emphatic (plain) style. Propositions and lemmas are
% consecutively numbered within sections.
% Notations in the less emphatic (definition) style;
% the notations are not numbered.

\theoremstyle{plain}
\newtheorem{theorem}{Theorem}
\newtheorem{proposition}{Proposition}[section]
\newtheorem{lemma}[Proposition]{Lemma}
\newtheorem{definition}{Definition}

\theoremstyle{definition}
\newtheorem*{notation}{Notation}

% Option 4
% Theorems, definitions, and lemmas in the most emphatic 
% (plain) style. Definitions and lemmas are consecutively 
% numbered within sections. There is a Main Theorem in 
% the most emphatic (plain) style, unnumbered. There are 
%rules, in the less emphatic (definition) style, unnumbered.

\theoremstyle{plain}
\newtheorem{theorem}{Theorem}
\newtheorem*{main}{Main Theorem}
\newtheorem{definition}{Definition}[section]
\newtheorem{lemma}[Definition]{Lemma}[section]

\theoremstyle{definition}
\newtheorem*{Rule}{Rule}

% Option 5
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
% One author
\title[shorttitle]{titleline1\\ 
                   titleline2}
\author{name}
\address{line1\\
         line2\\ 
         line3} 
\email{name@address}
\urladdr{http://webaddress}
\thanks{thanks} 
% End one author

% Two authors
\title[shorttitle]{titleline1\\ 
                   titleline2}
\author{firstauthor}
\address{line1\\
         line2\\
         line3}
\email{firstauthor@email address}
\urladdr{http://firstauthorwebaddress}
\thanks{The firstauthor  ... thanks} 
\author{secondauthor}
\address{address2line1\\
         address2line2\\
         address2line3}
\email{secondauthor@email address}
\urladdr{http://secondauthorwebaddress}
\thanks{The second author ... thanks}
% End two authors

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