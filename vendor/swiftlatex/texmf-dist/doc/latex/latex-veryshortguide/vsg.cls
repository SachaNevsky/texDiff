%%
%% This is file `vsg.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% vsg.dtx  (with options: `class')
%% This file was generated from an XML master source.
%% Amendments and corrections should be notified to the
%% maintainer for inclusion in future versions.
\NeedsTeXFormat{LaTeX2e}[2015/01/01]
\ProvidesClass{vsg}[2016/08/12 v0.6
 The Very Short Guide to LaTeX]
\RequirePackage{fix-cm}
\PassOptionsToPackage{svgnames}{xcolor}
\PassOptionsToPackage{hyphens}{url}
\newif\iflegal
\newif\ifafive
\afivetrue
\gdef\VSG@papersize{a5paper}
\gdef\VSG@margins{margin=12mm,bottom=10mm}
\DeclareOption{a5paper}{%
  \gdef\VSG@papersize{a5paper}%
  \gdef\VSG@margins{margin=12mm,bottom=10mm}
  \afivetrue\legalfalse}
\DeclareOption{legalpaper}{%
  \gdef\VSG@papersize{papersize={7in,8.5in}}%
  \gdef\VSG@margins{margin=15mm,bottom=15mm}
  \legaltrue\afivefalse}
\DeclareOption*{%
  \PassOptionsToClass{%
    \CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}
%%
%% Packages required
%%
%% Package for establishing margins and text area.
\RequirePackage[nohead,\VSG@papersize,
  \VSG@margins]{geometry}
%% Font specification setup for use with \XeLaTeX{}.
\RequirePackage{fontspec}
%% Caladea family of fonts, designed by Carolina Giovagnoli and Andres Torresi of the Huerta Tipografica foundry and adopted by Google for ChromeOS as a font-metric compatible replacement for Cambria.
\RequirePackage{caladea}
%% The current Raleway family is an extension of the original Raleway Thin by Matt McInerney. The family has been extended by Impallari, for more information see the impallari website http://www.impallari.com/projects/overview/matt-mcinerneys-raleway-family.
\RequirePackage[scale=.9]{raleway}
%% Provide for graphics (PNG, JPG, or PDF format (only) for pdflatex; EPS format (only) for standard \LaTeX{}).
\RequirePackage{graphicx}
%% Handling of URI formatting.
\RequirePackage{url}
%% This provides round-cornered and drop-shadow boxes.
\RequirePackage{fancybox}
%% List variants: inline and compact. Note that this replaces the earlier defaults of paralist and mdwlist.
\RequirePackage[inline]{enumitem}
  \setlist[description]{style=unboxed}
%% Allow infinitely-variable font scaling.
\RequirePackage{fix-cm}
%% Provides multi-column typesetting.
\RequirePackage{multicol}
%% Slanted fractions, even in math mode.
\RequirePackage{nicefrac}
%% Add more robust verbatim facilities.
\RequirePackage{fancyvrb}
%% Karel Horak's dingbats symbols.
\RequirePackage{bbding}
%% Creates paragraphs separated by white-space with no indentation.
\RequirePackage{parskip}
%% Allow hyphenation in ragged setting.
\RequirePackage{ragged2e}
%% Required for calculations involving lengths or counters, such as changes to widths for margin adjustment.
\RequirePackage{calc}
%% Package to enable if--then--else conditional processing.
\RequirePackage{ifthen}
%% Additional commands for common symbols and punctuation.
\RequirePackage{textcomp}
%% Additional column formatting for tables.
\RequirePackage{array}
%% Provides size-relative font size changes (smaller, larger, etc).
\RequirePackage{relsize}
%% Provides a more sophisticated casing function than the default.
\RequirePackage{textcase}
%% Allows user-programmable changes to the positioning of letters in the \TeX{}-related logos on a per-font basis.
\RequirePackage{flexlogo}
%% Underlining as an option (not automatically replacing italics).
\RequirePackage[normalem]{ulem}
%% Provide color.
\RequirePackage{xcolor}
  \@ifundefined{T}{%
    \newcommand{\T}[2]{{\fontencoding{T1}\selectfont#2}}}{}
%% Add language, cultural changes, and H\&J support for many languages.
\RequirePackage[british]{babel}
%% Use biblatex instead of \BibTeX{}
\RequirePackage[backend=biber,doi=true,
  isbn=true,url=true,uniquename=false,style=apa]{biblatex}
  \AtBeginDocument{\setlength{\bibitemsep}{1ex}
  \defbibheading{shortbib}[Bibliography]{\section{#1}}}
    \@ifpackagewith{babel}{british}{%
    \DeclareLanguageMapping{british}{british-apa}}{\relax}
%% Adds correct curly quotes for cited titles when using biblatex
\RequirePackage{csquotes}
%% Graphical representations of menus, directories, and keys.
\RequirePackage{menukeys}
  \renewmenumacro{\menu}[>]{roundedmenus}
  \renewmenumacro{\directory}[/]{hyphenatepathswithfolder}
  \renewmenumacro{\keys}{shadowedroundedkeys}
\setmonofont[Scale=MatchLowercase]{zcoN}
\renewcommand{\labelitemi}{%
  \raisebox{-.5ex}{\textcolor{Purple}{\PencilRight}}}
\setlength{\leftmargini}{18pt}% don't waste margin space in lists
\newcommand{\example}{%
  \color{DarkGreen}\textsf{\bfseries Example:} \color{MediumBlue}}
\def\endexample{\color{black}}
\newcommand{\gives}[1]{%
  \thinspace\color{DarkGreen}\raisebox{-.4ex}
    {\ArrowBoldRightStrobe}~\color{DarkRed}{\rmfamily
     #1}\color{black}}
\newcommand{\nobox}{~\raisebox{-.25ex}{%
  \footnotesize\Square\llap\XSolidBrush}}
\newcommand{\yesbox}{~\raisebox{-.25ex}{%
  \footnotesize\Square\llap\CheckmarkBold}}
\newcommand{\comment}[1]{\ifthenelse{\equal{#1}{ }}{}{#1}\normalfont
  \itshape\footnotesize\color{DarkRed}}
\newcommand{\added}{\color{MediumBlue}}
\newcommand{\revert}{\ttfamily\upshape\color{black}}
\newcommand{\monthdate}{\ifcase\month\or January\or
  February\or March\or April\or May\or June\or July\or August\or
  September\or October\or November\or December\fi\space\number\year}
\hyphenation{mathe-mati-cal auto-mati-cal-ly docu-ment docu-ments
  docu-men-tation statis-ti-cal}
\renewcommand{\maketitle}{%
  \hbox to\textwidth{%
    \vbox{\hsize=.73\textwidth\huge\bfseries\raggedright
      \@title}
    \hss
    \vbox{\hsize=.27\textwidth\scriptsize\raggedright
      \@author
      \par
      \textit{\@date}}}
  \par\bigskip\hrule\medskip
}
\renewcommand\section{\@startsection{subsection}{1}{\z@}%
  {-0pt\@plus -.2ex \@minus -.2ex}%
  {1pt \@plus .2ex}%
  {\sffamily\Large\bfseries}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
  {-0pt\@plus -.2ex \@minus -.2ex}%
  {1pt \@plus .2ex}%
  {\sffamily\large\bfseries}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
  {-.5ex\@plus -1ex \@minus -.2ex}%
  {.25ex \@plus .2ex}%
  {\sffamily\normalsize\bfseries}}
\renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
  {1ex \@plus1ex \@minus.2ex}%
  {-1em}%
  {\sffamily\normalsize}}
\setcounter{secnumdepth}{5}% we don't want numbered sections
\renewcommand{\thesection}{}
\renewcommand{\thesubsection}{}
\renewcommand{\thesubsubsection}{\arabic{subsubsection}}
\DeclareTeXLogo{Caladea(0)}{m}{n}{.1667}{.125}[.4]
\DeclareTeXLogo{Caladea(0)}{m}{it}{.1667}{.08}[.4]
\DeclareTeXLogo{Caladea(0)}{bx}{n}{.1667}{.125}[.4]
\DeclareLaTeXLogo{Caladea(0)}{bx}{n}{.27}{.1333}[.1]
\DeclareLaTeXLogo{Caladea(0)}{m}{n}{.3}{.1}[.1]
\DeclareTeXLogo{Raleway(0)}{bx}{n}{.1667}{.125}[.38]
\DeclareLaTeXLogo{Raleway(0)}{m}{n}{.3}{.1}[.1]
\DeclareLaTeXLogo{Raleway(0)}{b}{n}{.27}{.15}[.1]
\renewcommand{\footnoterule}{\kern-3pt
  \hrule height.2pt width.25\columnwidth\kern 2.8pt}
\pagestyle{empty}
\spaceskip=4pt plus4pt minus3pt
\renewcommand{\textsc}[1]{{\smaller\MakeTextUppercase{#1}}}
\newcommand{\ff}[2][T1]{\fontencoding{#1}\fontfamily{#2}\selectfont}
\renewcommand{\descriptionlabel}[1]{%
  \hspace\labelsep{\sffamily\bfseries #1}}
\newenvironment{note}{\small\textbf{Note.}\quad}{\par}

\endinput
%%
%% End of file `vsg.cls'.
