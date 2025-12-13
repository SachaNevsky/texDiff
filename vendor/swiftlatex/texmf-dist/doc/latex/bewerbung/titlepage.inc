%%
%% This is file `titlepage.inc',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% bewerbung.dtx  (with options: `titlepage.inc,package')
%% 
%%  bewerbung.dtx
%%  Copyright 2015-07-14:14:18:49 -- Version 1.1 André Hilbig, mail@andrehilbig.de
%% 
%%  This work may be distributed and/or modified under the
%%  conditions of the LaTeX Project Public License, either version 1.3
%%  of this license of (at your option) any later version.
%%  The latest version of this license is in
%%    http://www.latex-project.org/lppl.txt
%%  and version 1.3 or later is part of all distributions of LaTeX
%%  version 2005/12/01 or later.
%% 
%%  This work has the LPPL maintenance status `maintained'.
%% 
%%  The Current Maintainer of this work is André Hilbig, mail@andrehilbig.de.
%% 
%%  This work consists of the files bewerbung.dtx and bewerbung.ins and the derived files bewerbung-cv-casual.sty, bewerbung-cv-classic.sty, bewerbung-cv-oldstyle.sty, bewerbung-cv.sty, bewerbung.sty, argetabelle.cls, bewerbung.cls, neueBewerbung.sh, config.inc, titlepage.inc.
%% 
%% \CharacterTable
%%  {Upper-case    \A\B\C\D\E\F\G\H\I\J\K\L\M\N\O\P\Q\R\S\T\U\V\W\X\Y\Z
%%   Lower-case    \a\b\c\d\e\f\g\h\i\j\k\l\m\n\o\p\q\r\s\t\u\v\w\x\y\z
%%   Digits        \0\1\2\3\4\5\6\7\8\9
%%   Exclamation   \!     Double quote  \"     Hash (number) \#
%%   Dollar        \$     Percent       \%     Ampersand     \&
%%   Acute accent  \'     Left paren    \(     Right paren   \)
%%   Asterisk      \*     Plus          \+     Comma         \,
%%   Minus         \-     Point         \.     Solidus       \/
%%   Colon         \:     Semicolon     \;     Less than     \<
%%   Equals        \=     Greater than  \>     Question mark \?
%%   Commercial at \@     Left bracket  \[     Backslash     \\
%%   Right bracket \]     Circumflex    \^     Underscore    \_
%%   Grave accent  \`     Left brace    \{     Vertical bar  \|
%%   Right brace   \}     Tilde         \~}
%% zusätzliche
%% Farbdefinitionen:
\begin{titlepage}
\begin{comment}
\applyCSVfile{../anschrift.csv}{
\ifthenelse{\equal{\insertbyname{ID}}{\id}}{
\renewcommand{\firma}{\insertbyname{Firma}}
\renewcommand{\firmaAnrede}{\insertbyname{FirmaAnrede}}
\renewcommand{\firmaName}{\insertbyname{FirmaName}}
\renewcommand{\firmaStreet}{\insertbyname{Str}}
\renewcommand{\firmaPlz}{\insertbyname{PLZ}}
\renewcommand{\firmaStadt}{\insertbyname{Ort}}
\renewcommand{\beruf}{\insertbyname{Stelle}}
%%   \hrule
\end{comment}
  \begin{multicols*}{2}[][0cm]
    \setlength{\columnseprule}{1pt}

    \textbf{\fullname}\\
    \textbf{\meinBeruf} \\ \ \\
    \street\\
    \plz\ \stadt\\
    \Letter\enskip \email\\
    \Telefon\enskip \tel\\
    \Mobilefone\enskip \mobile

\vfill
      \textbf{Inhalt}
\renewcommand{\labelitemi}{}
\begin{itemize}
\anhang[title]
\end{itemize}
    \columnbreak
    \vspace*{1.8cm}
    \hspace*{0.5cm}\textsc{\Huge{\textbf{Bewerbung}}}
    \vspace*{2cm}
    \begin{flushleft}
      \setlength{\parindent}{-0.1cm}
      \leftskip=0.3cm
      \hspace*{0.1cm}\textit{bei}\\ % hier gehört bei rein
      \textbf{\bewerbungFirma}\\
      \bewerbungFirmaAnrede\
                      \bewerbungFirmaName\\
\bewerbungFirmaStr\\
      \bewerbungFirmaPlz\ \bewerbungFirmaOrt
      \vspace*{1.5cm}
      \hspace*{0.1cm}\textit{als}\\
      \textbf{\bewerbungStelle}\\
    \end{flushleft}
    \vfill
    \hspace*{0.2cm}\includegraphics[width=5cm]{Foto.pdf} %\\
  \end{multicols*}
\end{titlepage}
\endinput
%%
%% End of file `titlepage.inc'.
