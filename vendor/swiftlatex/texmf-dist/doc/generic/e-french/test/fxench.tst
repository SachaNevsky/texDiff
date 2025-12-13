% This is the french torture file for all formats.
%                                   Copyright Bernard Gaulle as in french.doc
%
% \`{A} passer en 8 bits conform\'{e}ment \`{a} votre syst\`{e}me
%                                                       
%%      checksum        = "26167 3750 15103 125091"
%%
%
% For localisation:
%
\makeatletter%
\ifx\documentclass\undefined\let\kbAissue\relax\let\typeouA\typeout%
\else%
   \let\typeouA\@gobble%
% For debugging one can remove "msg" access, just uncomment
%\let\kbAissue\relax% this line.
   \ifx\kbAissue\undefined%
% Firstly we add the material to use the "msg" package for localization.
      \def\kb@issue#1#2{\kb@issue@[#1]#2\void}% The local \issuemsg macro.
                                      % which will call the real one;
                                      % #1 is the macro message required.
                                      % #2 is the message header + msg number
                                      %    such as "^^J -234-", just message 
                                      %    number (234) is kept. 
      \let\kbAissue\kb@issue%
      \def\kb@issue@[#1]#2-#3-#4\void{\issuemsg[#1]#3(french)}%
   \ifx\issuemsg\undefined\let\kbAissue\relax\let\typeouA\typeout\fi%
   \fi%
\fi%
\makeatother%
%
% For better debugging:
\ifx\IeC\undefined
\kbAissue% localise it.
\typeout{^^J-66- ERROR! This file can't be typeset without any input} 
   \typeouA{-66- encoding declaration (look at keyboard or inputenc packages.)}
\expandafter\stop% \usepackage[latin1]{keyboard} should be fine.
\fi
\let\FP\frenchpack\hyphenation{French-Pro}
\wlog{Formating \jobname\space with\space\FP\space(\frenchstyleid)}
%
%
\ifx\ProvidesFile\undefined\def\ProvidesFile#1[#2]{}\fi%
\ProvidesFile{french.tst}% 
        [2005/05/11 The torture test file for the package \FP]% **last mods**
\ifx\undefined\FmsG\def\FmsG{}\def\SmsG{}\fi
%
{\catcode`\<=\active\catcode`\>=\active%
% Je veux :
%\global\def<{\left\langle}\global\def>{\right\rangle}
% Et pour ne pas pouvoir avoir l'effet que localement, 
% je fais : 
\gdef<{\myinf}\gdef>{\mysup}
}
\label{nulllabel}% null \label for AmSTeX test \ref within a \ref
\iflatex\makeindex \makeglossary 
        \csname frhyphex\endcsname% load (again) the exceptions, outside babel
        \def\NL#1{\Sauter#1Lignes} 
        \begin{document}
        \makeatletter
        \ifx\babel@savevariable\undefined%
                             \let\FRENCH\frenchTeXmods% 
                        \else\def\FRENCH{\selectlanguage{french}}% pour babel
        \fi%
        \makeatother
        \csname onecolumn\endcsname % avoid writting \onecolumn 
                                    % (special effect in frencht.tex)
        \renewcommand{\thepage}{\roman{page}}%
        \ifx\documentclass\undefined\else% for 2e
        % As 2e doesn't accept \verb in arguments:
        \gdef\myverb|#1|{%\nonfrench
                         \texttt{#1}%
                         %\endnonfrench
                         \relax}%
        \fi
\else
        \let\FRENCH\frenchTeXmods% 
        \def\NL#1{\par} 
\fi
\ifx\myverb\undefined\let\myverb=\verb\fi%
% global here is just req. for TeX--XeT tests.
\global\let\myinf\inferieura% A no-op def
\global\let\mysup\superieura% for a temporary action
\ifx\undefined\english\let\english\relax\fi%
% Les \ldots sont $\ldots$ a cause de AmSLaTeX V1.1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\HyphDiff#1#2{{\setbox0=\vbox{%
                   \pretolerance=-1 \hyphenpenalty=-10000
                   \hsize=0pt \leftskip=0pt \rightskip=0pt \parfillskip=0pt
                   \parindent=0pt \hfuzz=\maxdimen \interlinepenalty=0
                   \clubpenalty=0 \widowpenalty=0 \brokenpenalty=0
                       \hskip 0pt #1}%
                   \setbox2=\hbox{}%
                   \setbox9=\vbox{\unvbox 0 \loop \unskip \setbox1=\lastbox
                                            \ifhbox 1 
                                                 \global\setbox 2 = \hbox{%
                                            \unhbox 1 \discretionary{}{}{}%
                                                           \unhbox 2}%
                                            \repeat}%
\setbox3\hbox{#2}\ifnum\wd2=\wd3\else
\kbAissue% localise it.
\typeout{-31- Wrong French Hyphenation\string! 
               Are you sure to run with a format ***********}
\typeouA{-31- in which the french patterns were 
                installed at initex time\string? ***********}
\ifECM\else%
\kbAissue% localise it.
\typeout{-32- if yes try to switch to T1 font 
             encoding (\noexpand\usepackage[T1]{fontenc})***}
\fi%
\showhyphens{#1}\typeout{(should be\string: #2) 
  \string<\string<======== *********************************}
\fi}}
\HyphDiff{\'{e}ventualit\'{e}}{\'{e}ven-tua-lit\'{e}}
\HyphDiff{d\'{e}gazonnage}{d\'{e}-ga-zon-nage}
\HyphDiff{chromosomique}{chro-mo-so-mique}
%%%%
\SmsG%
\typeout{V\'%
         erification de la sortie de caract\`%
         eres 8-bits \string:}
\message{L'\'% \typeout ne transforme pas en 8bits pour l'instant.
         et\'%
         e est l\`%
         a en ao\^%
         ut \string!} 
\iflatex%
\typeout{Essai de macro d'accentuation dans un ordre \string\showhyphens %
         \string:}
\showhyphens{Faut-il croire \`%
             a l'\'%
             ETERNIT\'%
             E ? \'%
             eludons ...}
\showhyphens{Ao\^%
             ut 2001 ou l'autre \`%
             ere ...}
\fi%
\FmsG%
%
\english% Title page is in english
\ifx\documentclass\undefined % Still Plain! so no \DeclareFontFamily
\else%
% To avoid "No file OMScmtt.fd" message 2004/10/29
\DeclareFontFamily{OMS}{cmtt}{\skewchar\font48 }
\DeclareFontShape{OMS}{cmtt}{m}{n}%
   {<->ssub*cmsy/m/n}{}
\DeclareFontShape{OMS}{cmtt}{m}{it}%
   {<->ssub*cmsy/m/n}{}
\DeclareFontShape{OMS}{cmtt}{m}{sl}%
   {<->ssub*cmsy/m/n}{}
\DeclareFontShape{OMS}{cmtt}{m}{sc}%
   {<->ssub*cmsy/m/n}{}
\DeclareFontShape{OMS}{cmtt}{bx}{n}%
   {<->ssub*cmsy/b/n}{}
\DeclareFontShape{OMS}{cmtt}{bx}{it}%
   {<->ssub*cmsy/b/n}{}
\DeclareFontShape{OMS}{cmtt}{bx}{sl}%
   {<->ssub*cmsy/b/n}{}
\DeclareFontShape{OMS}{cmtt}{bx}{sc}%
   {<->ssub*cmsy/b/n}{}
%%%%%%%%%%%%%%%%%%%%%%%
\fi% 
\makeatletter% for \f@encoding 
\title{\fbox{ \FP\ \LaTeX%
             \thanks{We are here in english, notice the problem when we use,
                     like in \texttt{frenchla}, a
                     {\mdseries\texttt{\textbackslash fnsymbol}}
                      in a box.\newline%
                     \indent \hspace*{0.5em}
                             Notice also that 
                             {\mdseries\texttt{\textbackslash backslash}}%
                             can't be used.%
                    }%
            }\\ \ \\%
             Version \frenchstyleid\\ \ \\
             ``Torture'' Test (\jobname) \\ with
             \ifx\encodingdefault\undefined Unknown
              \else\ifx\f@encoding\undefined\encodingdefault{} 
                     \else\f@encoding{} \fi
             \fi Font Encoding\\\ }
  \author{Bernard {\sc Gaulle}%
          \thanks{Thanks to those good guys who helped me.\newline%
                  \indent\hspace*{0.5em}
                          This test note is also referred by a
                         {\mdseries\texttt{\textbackslash refmark}} call.
                  \label{title:thanks}% 
                 }%
          \\ \ \\ et...\refmark{title:thanks}%
         }%
% AmS \normalparindent no more exists 2000/06/15, so the code is removed.
%\makeatletter% Don't let AMS change \parindent
%\ifx\RIfM@\undefined\else\normalparindent=1em\parindent=\normalparindent\fi%
%\makeatother
\makeatother%
\date{Printed on \today} 
% As the titlepage is in English but the date in French we let \ier defined:
{\def\ier{ier}\maketitle}
\setcounter{page}{2}\thispagestyle{empty}
\cleardoublepage\french
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\onecolumn
\sommaire[4]
\bigskip 
\begin{center}
\noindent\fbox{%
\begin{minipage}[t]{0.5\textwidth}
\begin{center} \fbox{\parbox{5cm}{{\bf Remarque} : \\ la commande
\texttt{\backslash som\-maire}\label{pbverb}%
\footnote{Cette note a \'{e}t\'{e} demand\'{e}e depuis une minipage.}%
\footnote{Cette deuxi\`{e}me note aussi.} 
%%%%NB : \verb|\sommaire| ou \verb|\tableofcontents| produisent des HORREURS,
%%%%     lorsqu'ils ont utilises dans un \fbox, BUG LATEX !
 est un apport de \FP.\hfill}} 
\end{center}
\end{minipage}
}
\end{center}

{% Not a LaTeX redefinition : \def\thefootnote{\fnsymbol{footnote}}
\renewcommand{\thefootnote}{\fnsymbol{footnote}}%
Essai de note avec \verb|\fnsymbol|
\footnote{Note avec une \'{e}toile.}.

\def\thefootnote{\relax}
Essai de note de bas de page non num\'{e}rot\'{e}e
\footnote{Note non num\'{e}rot\'{e}e.}.
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\cleardoublepage
\chapter*{\prefacename}

{\em Certains croient qu'une pr\'{e}face peut apporter de la valeur au livre,
moi je pense plut\^{o}t que cela apporte de la {\em valeur} 
\`{a} l'auteur...} (dans
tous les sens du terme).

\cleardoublepage

\twocolumn 
\renewcommand{\thepage}{\arabic{page}}\setcounter{page}{1}%
\chapter*{Introduction}

\begin{motsclef}
french, style, francisation, francophonie, multilingue, 
english, option, extension. 
\end{motsclef}

\begin{resume} 
Ce document a \'{e}t\'{e} con\c{c}u
uniquement pour tester intensivement \FP\ (anciennement appel\'{e} 
option de style% 
   \glossary{<< : ; style ? ! >>}\index{<< : ; style ? >>}%
   \footnote{Cette note a pour but de faire appel \`{a} une macro
             \texttt{\backslash index} contenant des caract\`{e}res actifs.%
             \index{<< : ; depuis la note de bas de page ? >>}%
            } 
\index{french!Le point d'exclamation est un caract\`{e}re sp\'{e}cial de Makeindex}%
\index{<@{\tt\protect\inferieura} ({\tt\protect\backslash inferieura})}% 
\index{>@{\tt\protect\superieura} ({\tt\protect\backslash superieura})}%
\index{Magic di N'Konga (auteur c\'{e}l\`{e}bre)}%
 \texttt{french}).  
\end{resume}

\bigskip Notez que les deux environnements \verb|resume| et \verb|motsclef|
(ainsi que \verb|keywords|)
sont des apports de \FP.

\bigskip Si le libell\'{e} << R\'{e}sum\'{e} >> appara\^{\i}t dans la partie
 anglaise, cela
signifie que \FP\ ne poss\'{e}dait pas de d\'{e}finition
d'\verb|\abstract| et donc l'a remplac\'{e} par \verb|\resume|. Cela signifie
aussi que les libell\'{e}s anglais n'ont pas \'{e}t\'{e} d\'{e}finis 
(\verb|\captionnames|%
\footnote{Une extension {\tt fenglish} est fournie conjointement avec
\FP\ ; {\tt\backslash captionnames} y est d\'{e}fini. 
Cette extension {\tt
fenglish} est automatiquement appel\'{e}e par \FP\  dans le
cas que nous avons cit\'{e}.}
 n'\'{e}tait pas d\'{e}fini par les extensions appel\'{e}es avant
 \FP).
Rappelez-vous aussi que \verb|\abstract| ne fait pas partie de la classe
de document \verb|book|.

Remarquez les diff\'{e}rences entre les num\'{e}ros de notes de bas de page en 
fran\c{c}ais et en anglais, ainsi que l'impression de ce m\^{e}me num\'{e}ro en
bas de la page.

\english\newpage
\begin{keywords} %???\relax% for AMS which has its own macro with #1
French, Style, Option, Package, French-Speaking usage, English, Multilingual.
\end{keywords}

\begin{abstract} The object of this paper is to test intensively \FP.
\end{abstract}
\NL1

\bigskip Notice that the three environments 
\verb|resume|, \verb|keywords| and \verb|motsclef|
are all introduced by \FP.

\bigskip Notice that if the abstract name printed here is not ``Abstract'' you
are using packages that have no \verb|\abstractname| defined for eng\-lish. 
 The english package defining such captions is loaded only 
if \verb|\captionsnames|%
\footnote{The {\tt fenglish} package is given with \FP,
so {\tt$\backslash$captionnames} are normally defined because 
\FP\ is calling automatically the {\tt fenglish} package in the 
pre\-viously cited case.} was
previously undefined.  (Remember also that as \verb|\abstract| is not defined
in the \verb|book| document class the \FP\ assumes it is a
\verb|\resume|.)

Notice the different typesetting of the footnote numbers in French and English
as well as the printing of that numbers before the footnote text.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\french
\part{Ce qui marche est ici...}
\disallowuchyph% ce que je prefere...

\chapter{Avertissements}

Seul le document authentique qui est fourni par l'auteur
 sous une forme compos\'{e}e
constitue la r\'{e}f\'{e}rence. Cela veut dire que l'installateur de \FP\ 
sur un syst\`{e}me doit comparer son r\'{e}sultat 
(sous forme papier ou
fichier \verb|.dvi|) avec la forme authentique fournie par l'auteur.

\bigskip

\bigskip \FP\  a \'{e}t\'{e} con\c{c}u pour fonctionner 
avec la majorit\'{e} bas\'{e}s sur \LaTeX{}
\footnote{Au si\`{e}cle dernier (XX\ieme), \FP\ \'{e}tait appel\'{e} << style 
\texttt{french} >> et pouvait fonctionner en dehors de \LaTeX\ mais
l'effort pour assurer cette facilit\'{e} dans de trop nombreux formats
exotiques \'{e}tait totalement disproportionn\'{e} ; ceci a donc \'{e}t\'{e}
abandonn\'{e} (au moment de la sortie de \LaTeXe).}%
. 

\bigskip \AllTeX{} est mon logo ; il symbolise {\em tous les \TeX{}} ; on peut
l'imprimer correctement dans toutes les polices ({\em \AllTeX}, {\bf \AllTeX}, 
{\sf \AllTeX}, {\tt \AllTeX}, ...) gr\^{a}ce \`{a} la partie NFSS de \LaTeXe%
\footnote{Le document de r\'{e}f\'{e}rence ({\tt frenchrf})
a \'{e}t\'{e} produit avec NFSS. Ce document-ci a \'{e}t\'{e} compos\'{e} avec le format 
{\tt \fmtname}.}
.

\newpage\english Only the authentic author's document in a composed form is
the reference.  That means that the on site \FP\ installator must
compare his result (paper or \verb|.dvi| file) with the authentic form
provided by the author.
\NL3

\bigskip \FP\ was designed to work with all {\em formats\/} 
based on \LaTeX.

\bigskip \AllTeX{} is my logo ; it's a  symbol for expressing 
{\em all \TeX{}} ; one can print it correctly in all shapes
({\em \AllTeX}, {\bf \AllTeX}, 
{\sf \AllTeX}, {\tt \AllTeX}, etc.) due to the NFSS part of \LaTeXe%
\footnote{The
reference document was produced with NFSS of {\tt \fmtname}.}%
.

\french
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\chapter{La torture} 

\section{Le saviez-vous ?} Nos journaux, livres, revues,
articles scientifiques ou autres ont \'{e}t\'{e}
 pendant ces trente derni\`{e}res ann\'{e}es imprim\'{e}s 
par des machines d'origine
am\'{e}ricaine. Ainsi, petit \`{a} petit, nous perd\^{\i}mes 
l'habitude de lire des
majuscules accentu\'{e}es parce que tout simplement les polices
 de caract\`{e}res
utilisables sur ces machines n'en comportaient pas.

L'usage de plus en plus g\'{e}n\'{e}ralis\'{e} de l'infor\-ma\-tique 
{\em am\'{e}ricaine} fit ainsi dispara\^{\i}tre pendant un temps tous
 les accents de notre langue \'{e}crite.

De la m\^{e}me mani\`{e}re un certain nombre de 
{\em mauvaises habitudes} furent
prises quasiment inconsciemment tout simplement parce que les programmes
informatiques ne pouvaient pas faire autrement. Ainsi de nombreuses {\it
coquetteries} de notre typographie sont tomb\'{e}es dans l'oubli.

Saviez-vous par exemple qu'on n'imprime pas des guillemets comme ceci `` '' ni
m\^{e}me ` ' mais ainsi << >> ? Nous nous autoriserons toutefois
 \`{a} utiliser dans
ce document ces guillemets %\noenglishquote 
(` ') que nous consid\'{e}rons comme
{\em techniques}.

\newpage\english \section{Did you know that?}
Our (french)
newspapers, books, magazines, scientific articles and other things have
been printed with american machines during these last thirty years. So our
habits to read accented uppercase letters declined because they simply were
not included in the machinery.\NL2

Together with American computer usage growth, all french
diacritics disappeared from our french written language.\NL1

In a same way {\em bad
habits} took place, inconsciously, for the only reason that computer programs
could not do otherwise. So, a lot of  french typographic {\em coquetteries\/}
are largely forgotten.\NL2

 Did you know for example that we never typeset french
guillemets like this `` '' neither ` ' but%
{\makeatletter\def\GOfrench{T1}\ifx\GOfrench\f@encoding\else%
\footnote{We switched to \emph{French} here to be able %
          to print valid glyphs.}%
\fi} %
\begin{french}<< and >>\end{french}? Instead, we will
authorised ourselves to use (` ') in this document 
because we consider they are {\em technical} guillemets.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newpage\french
*** Cet espace est laiss\'{e} intentionellement \`{a} blanc ***
\NL3
\section{Typographie fran\c{c}aise}
%\noenglishquote 
La typographie fran\c{c}aise est sp\'{e}cifique en ce qui concerne
l'utilisation des signes sui\-vants : 
`\verb|.| \verb|:| \verb|;| \verb|!| \verb|?| \verb|<<| \verb|>>|'. 

La r\'{e}partition des espaces dans une ligne se fait de fa\c{c}on 
\'{e}quitable entre les
mots (jamais \`{a} l'int\'{e}rieur des mots) et apr\`{e}s 
la ponctuation (c'est le
\verb|\frenchspacing| de \TeX{}) contrairement \`{a} la
 typographie anglaise.

Les `\verb|; ! ?|' doivent \^{e}tre pr\'{e}c\'{e}d\'{e}s d'une espace fine 
ins\'{e}cable.  C'est
ce que nous avons appliqu\'{e} dans \FP.  
Le cas du `\verb|?|'
a \'{e}t\'{e} trait\'{e} sp\'{e}cialement car l'espace fine ayant 
\'{e}t\'{e} jug\'{e}e trop grande (par
des sp\'{e}cialistes), a \'{e}t\'{e} r\'{e}duite tout en adjoignant une peu de 
{\em glue} d'extensibilit\'{e}.

En ce qui concerne le `\verb|:|', le code typogra\-phi\-que%
\footnote{Nous
avons choisi d'adopter les recommandations de l'imprimerie nationale
fran\c{c}aise.} pr\'{e}cise qu'il est pr\'{e}c\'{e}d\'{e} 
d'une espace {\em mot\/} 
ins\'{e}cable.
D'autres ont jug\'{e} que c'\'{e}tait inesth\'{e}tique et cela a \'{e}t\'{e} 
remplac\'{e} par une espace fine. 

Les guillemets fran\c{c}ais << doivent \^{e}tre suivis d'une espace mot 
ins\'{e}cable qui
a \'{e}t\'{e} remplac\'{e}e ici par une espace moindre. 
Les guillemets fermants >>
sont, eux, pr\'{e}c\'{e}d\'{e}s de la m\^{e}me espace.

\SmsG%
Lorsque la ligne n'est pas assez remplie et qu'il existe un `:', les
typographes ont --~semble-\hbox{t-il}~-- l'habitude 
de r\'{e}partir largement les espaces autour
des deux points. C'est ce qui a \'{e}t\'{e} fait dans \FP\ qui
pourra \'{e}ventuellement produire une ligne : 
peu remplie\footnote{Le cas pr\'{e}sent\'{e} ici a \'{e}t\'{e} 
cr\'{e}\'{e} artificiellement et peut donc appara\^{\i}tre exag\'{e}r\'{e} dans
certaines mises-en-pages.}%
\penalty-10000% 
 ou aussi bien une ligne se terminant ainsi : << {\em com\-me % \- pour fourier
font les pros\/} >>
lorsqu'ils ne trouvent pas d'autre moyen mais il devrait s'agir que de cas
extr\^{e}mes. \`{A} noter que cela a pour avantage de r\'{e}duire les
\verb|over/under-full hbox| de fa\c{c}on significative.

Paragraphe de remplissage...\\ ...\\... pour v\'{e}rifier que le `:' ne 
termine ni la page ni la colonne. Ainsi : 

%\englishquote 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\begin{itemize} 
\item %qu'il s'agisse de verbatim ou d'une liste d'\'{e}l\'{e}ments 
les deux points et  le  texte qui suit  
sont  tous  deux sur la  m\^{e}me  page.
\end{itemize}
%\newpage % already done with the previous list
\FmsG%
\english

\smallskip

\section{French printing}

French printing use specific typographic rules specially in concern with 
the following: `. : ; ! ?' and french guillemets.

Interword spacing in a line is allways equal (and never modified inside a
word). It's the same way after punctuation (standard \verb|\frenchspacing|) as
opposed to the english typography.\NL1

All `; ! ?' are preceeded by a thin and uncuttable space. We apply this
automatically in \FP. (We have added few stretching {\em glue} to
the question mark).\NL2

Regarding the `:' we have not inserted an inter-word space but a thin space 
and also have added some glue.\NL2

\smallskip
French guillemets are processed the same way. \NL3

In an {\em underfull\/} line containing a `:' man has habits to share spaces
around the double points. This way used in \FP\ can also produce a
line with a ragged right, as shown in the french column. This technique
 reduce a lot of {\em overfull} and {\em underfull} {\tt hboxes} 
produced by \TeX{}.
\NL3

As shown also, \FP\ is reluctant to print a double point at the
end of a page or a column.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newpage\french%\noenglishquote
\section[Dactylographie fran\c{c}aise]{Rappels concernant la \newline 
dactylographie}

Les habitudes de saisie c.-\`{a}-d. les habitudes dactylographiques,
 veulent que les signes suivants
`\verb|:| \verb|;| \verb|!| \verb|?| \verb|>>|' 
soient toujours pr\'{e}c\'{e}d\'{e}s d'un blanc
(barre d'espace sur les claviers) et les \verb|<<| toujours
suivis d'un blanc. \FP\ remplacera
automatiquement ce blanc (\`{a} la composition) par l'espace appropri\'{e}e.

{\moretolerance\moretolerance\moretolerance
Les guillemets fran\c{c}ais << (et respectivement >>)...
\footnote{\tthyphenation Avec les options fournies 
telles \vers|A4| et  \vers|double|\-\vers|column| on obtient
 l\`{a} un \vers|overfull| \vers|hbox| difficilement r\'{e}ductible
de fa\c{c}on automatique mais je l'ai r\'{e}duit 
avec 3 \texttt{\backslash moretolerance}%
\notthyphenation.} 
\par}
%\nooverfullhboxmark

Les vrais guillemets fran\c{c}ais << (et respectivement >>)
s'utilisent toujours doubl\'{e}s (\verb|<<| et respectivement 
\verb|>>|). Ainsi $<$ et $>$ ne 
sont que des signes math\'{e}matiques et n'ont pas
d'autre sens en fran\c{c}ais que : {\em inf\'{e}rieur \`{a}} et 
{\em sup\'{e}rieur \`{a}}.

Il est fortement conseill\'{e} de poursuivre
ces habitudes dactylographiques qui
contribuent aussi \`{a} \'{e}claircir le texte
saisi et donc ainsi \`{a} faciliter les
corrections ult\'{e}rieures.
\NL1

\subsection[Test de la ponctuation fran\c{c}aise 
            \mdseries`\protect\myverb|. : ; ! ?|']
{Test de la ponctuation \newline fran\c{c}aise 
            \mdseries`\protect\myverb|. : ; ! ?|'} 

Le deux points s'imprime comme ceci : s'il est pr\'{e}c\'{e}d\'{e} d'un blanc
(au moins un) sinon rien n'est chang\'{e} (par ex. 11:33). Notez 
l'espace apr\`{e}s le point terminant la phrase ; le point virgule
est aussi pr\'{e}c\'{e}d\'{e} d'une espace fine s'il n'est pas coll\'{e} 
au mot le pr\'{e}c\'{e}dant (comme dans cet exemple d\^{u} \`{a} une faute
de frappe; assez fr\'{e}quente).\\
{\moretolerance
Oh ! Quoi-donc ? Notez ici l'espacement utilis\'{e}
devant le `!' et le `?'. Il ne faut
pas oublier aussi de taper le blanc avant, sinon? tout est
%terriblement 
 coll\'{e}! Voyez-vous la diff\'{e}rence ? Bravo !
}

Mais pour les documents {\em mal\/} saisis (c.-\`{a}-d. sans blanc) il est
toujours possible de sp\'{e}cifier la sous-option \verb|\untypedspaces|
\untypedspaces pour obtenir une insertion automatique des espaces
manquants comme ici! o\`{u} il avait \'{e}t\'{e} saisi `\verb|ici!|'.
V\'{e}rifions pour les autres ponctuations :;? \typedspaces que nous 
n'obtenons pas :;? serr\'{e}es comme ici.

V\'{e}rification de l'espacement :

\noindent
\verb|  \typedspaces X~; Y ; Z;| = \typedspaces X~; Y ; Z;

\noindent
\verb|\untypedspaces X~; Y ; Z;| = \untypedspaces X~; Y ; Z; \typedspaces

\newpage\english
\section{French typing}
French typists have some habits. For example they type a space before `: ; ! ?
\verb|>>|' and after \verb|<<|. \FP\ replace automatically this
blank space by the appropriate spacing.

There is only one kind of quoting in French by the mean of guillemets which
are allways typed \verb|<<| and \verb|>>|. Usual english simple and double
quotes must be prohibited.

\subsection{\mdseries%
            \texttt{\textbackslash untypedspaces}}%
This control command offers the ability to repair automatically a document
badly typed i.e. in which spaces were not typed before french punctuation.
This bypass can help but is not the good way to use daily because there are
many cases where, for example, a double point must never be preceeded 
by a space.

Now we verify that the spacing is unchanged in English:

\noindent
\verb|  \typedspaces X~; Y ; Z;| = \typedspaces X~; Y ; Z;

\noindent
\verb|\untypedspaces X~; Y ; Z;| = \untypedspaces X~; Y ; Z; \typedspaces

\subsection{\mdseries%
            \texttt{\textbackslash wrongtypedspaces}}
A french typist may input  spaces before
punctuation as it is usual in French. These unfortunate space
 can be removed by simply letting \FP\ do it with* the control
sequence:

\begin{verbatim}
\letpunctuationactivefor
               \wrongtypedspaces
\end{verbatim}

\FRENCH% pour ne pas dire \french
\letpunctuationactivefor\wrongtypedspaces
\english
Let's try the previous example:\par
\noindent
\verb|  X~; Y ; Z;| =  X~; Y ; Z;

Now we say \verb|\nowrongtypedspaces|
\nowrongtypedspaces to come back to the normal
situation.

\vfill

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newpage\french
\nowrongtypedspaces% to be sure it is set when english text is skipped
\csname StopFrenchLbT\endcsname% special case, temporary.

\section[Test des guillemets fran\c{c}ais, 7 (<%
                                          < >%
                                            >) et 8-bits (<< >>)]%
{Test des guillemets \newline fran\c{c}ais (<< >>)}
\hyphenation{nor-ma-le-ment}

Les guillemets fran\c{c}ais s'\'{e}crivent et se saisissent 
<< normalement >> comme ceci : 
\verb|<< |{\tt nor}\-%
{\tt male}\-{\tt ment }\verb|>>| 
 ou \'{e}ventuellement en italiques mais toujours
\bgroup% for frenchle
<< \em normalement\/ >> %
\egroup% for frenchle
; ici nous avons tap\'{e} au clavier :
\verb|<< \em| {\tt normalement}\verb| >>|.
Et en tapant par contre :\\ \verb|<<\em| 
 {\tt anormale\-ment (sans espace)}\verb|>>| \  on  obtient...
\bgroup% for frenchle
<<\em anormale\-ment (sans espace)\/>>.
\egroup% for frenchle
Re\-mar\-quez que les guillemets font office d'acco\-lades \TeX{} et que donc
les changements de polices sont restaur\'{e}s en sortant de la citation.

Pour les documents d\'{e}j\`{a} saisis {\em sans espace} \FP\ 
ins\'{e}rera syst\'{e}matiquement un espace \`{a} l'endroit
d\'{e}sir\'{e} si l'on a donn\'{e} la sous-option \verb|\untypedspaces|. 
\untypedspaces 
Et en tapant \`{a} nouveau 
\verb|<<\em| {\tt anormale\-ment (sans espace)}\verb|>>| on obtient
\bgroup% for frenchle
<<\em anormalement (sans espace)\/>>. 
\egroup% for frenchle
\typedspaces

Parfois on d\'{e}sirera remplacer syst\'{e}matiquement tous les 
guillemets anglais (`` et '') d'un texte par de vrais guillemets 
fran\c{c}ais, il
suffira alors de fournir l'\'{e}trange option :\\
\texttt{\backslash noenglishdoublequotes}\\
\noenglishdoublequotes pour obtenir : `` ''.

``  '' (m\^{e}me test en d\'{e}but de paragraphe).\englishdoublequotes
 
Lorsqu'une citation est faite dans un texte, celle-ci commence
toujours par des guillemets. << Cette citation peut se poursuivre sur
plusieurs paragraphes. 

Dans ce cas, le style %\verb|french| 
ins\'{e}rera syst\'{e}matiquement les guillemets n\'{e}cessaires 
en d\'{e}but de 
chaque paragraphe. >>

Mais une citation peut aussi en contenir une autre. << Dans ce cas l'imprimerie
 nationale pr\'{e}cise dans   ses {\em R\`{e}gles typographiques} : 
\ancientguillemets
 << Lors\-que la premi\`{e}re citation est 
elle-m\^{e}me plac\'{e}e entre 
guillemets, chaque ligne de la seconde d\'{e}butera par un 
guillemet ouvrant. >> 
Ce dispositif, comme on le voit, n'est pas  mis en {\oe}uvre ici
 (voir son application au paragraphe \ref{noeveryparguillemets}). 
 << La deuxi\`{e}me citation peut aussi...

se poursuivre sur un ou 
plusieurs paragra\-phes. >> Notez bien qu'avant cette citation nous avons 
demand\'{e} les \verb|\ancientguillemets| 
pour produire ces guillemets fermants
en d\'{e}but de ligne. Le \verb|\todayguillemets| r\'{e}tablit la 
situation une fois
le deuxi\`{e}me niveau termin\'{e}. \todayguillemets

{\makeatletter\def\GOfrench{T1}\ifx\GOfrench\f@encoding
\enlargethispage{10pt}% increase probably due to EC fonts metrics?
\fi}
Il arrive que la fin d'une citation de deux\-i\`{e}me niveau 
co\"{\i}ncide avec celle
du premier niveau.  << Dans ce cas il faudra coder, comme ici :\\
\verb|\endguillemets| 
\`{a} la place de ``\verb|>>|'' \endguillemets. 

Deux tests : \fbox{\begin{guillemets} XXX \end{guillemets}}
et  \fbox{X \begin{guillemets} XXX \end{guillemets} X} servant \`{a}
v\'{e}rifier l'espacement quand on utilise \verb|\begin| et \verb|\end|.

Le paragraphe suivant va alors d\'{e}marrer de fa\c{c}on 
tout \`{a} fait normale...

On peut aussi coder :
\begin{verbatim}
\begin{guillemets}
Une citation...
\end{guillemets}
\end{verbatim}
ce qui donnera :
\begin{guillemets}
Une citation...
\end{guillemets}
et en tapant {\em \`{a} la \TeX} : \verb|\guillemets{}| \verb|Une citation...| 
\verb|\en|\vers|d|\-\vers|guillemets{}| nous devons  obtenir absolument la m\^{e}me chose :
\guillemets{} Une citation... \endguillemets{}

V\'{e}rifions maintenant l'espacement dans les diff\'{e}rents cas :

\noindent
\fbox{\parbox{2cm}{<<X\dotfill X>>}} \%\texttt{\backslash typedspaces}
 {\em sans blanc}

\noindent
\fbox{\parbox{2cm}{<< X\dotfill X >>}} \%\texttt{\backslash typedspaces} 
{\em normal}

\noindent\untypedspaces
\fbox{\parbox{2cm}{<< X\dotfill X >>}} \%\texttt{\backslash untypedspaces} 
{\em avec blanc}

\noindent
\fbox{\parbox{2cm}{<<X\dotfill X>>}} \%\texttt{\backslash untypedspaces} 
{\em sans blanc}
\typedspaces

\noindent
\fbox{\parbox{3cm}{A blabla bla blabla : << 
Ceci est mon test de c\'{e}sure >>}} <<...>> reste possible.

\begin{flushleft}
 Ceci est << un test avec \verb|\raggedright| >> qui 
--~th\'{e}oriquement~-- ne devrait plus nous poser de probl\`{e}me.
\end{flushleft}

\subsection{{\mdseries%
\texttt{\textbackslash noeveryparguillemets}}}\label{noeveryparguillemets}
Cette option permet de g\'{e}rer correctement les citations de second 
rang mais elle est tout \`{a} fait contraire
 au processus \verb|\everypar| cit\'{e} pr\'{e}c\'{e}demment gr\^{a}ce auquel
 les guillemets sont g\'{e}n\'{e}r\'{e}s automatiquement \`{a} chaque 
d\'{e}but de paragraphe.
Voici ce que produit l'option {\em normale\/} 
\texttt{\backslash every\-par\-guil\-lemets} sur le paragraphe suivant :

<< Tout le monde s'accorde \`{a} trouver l\'{e}gitime la division : 
{\tt extra-ordinaire}. Le cas des mots com\-pos\'{e}s est le seul 
\`{a} rencontrer 
cette unanimit\'{e}. Dans les autres, les opinions sont tr\`{e}s partag\'{e}es.
 Frey est le plus cat\'{e}gorique : il n'admet de division selon la formation 
que pour des mots de composition compl\`{e}tement fran\c{c}aise, et la rejette 
sinon... Le {\em Code typographique}, tout en adoptant ce m\^{e}me point
 de vue << ... [reconna\^{\i}t] n\'{e}anmoins que certains auteurs de travaux 
scientifiques pr\'{e}f\`{e}rent la division \'{e}ty\-mologique 
qui fait ressortir
 la racine grecque ou latine. >> Quant \`{a} Gouriou, il \'{e}crit :
<< On pr\'{e}f\`{e}rera cependant garder la coupure \'{e}tymologique
 chaque fois que les composants sont {\em ais\'{e}ment} re\-connaissables. >> 
(L'italique est de Gouriou.) 
\marginpar{{\footnotesize Ici on a trich\'{e} avec des} \texttt{\backslash!}}
\!Telle \!est aussi \!l'opinion \!de \!Girodet >>. 

Et voici l'effet de \verb|\noeveryparguillemets| :
\noeveryparguillemets

<< Tout le monde s'accorde \`{a} trouver l\'{e}gitime la division : 
{\tt extra-ordinaire}. Le cas des mots com\-pos\'{e}s est le seul 
\`{a} rencontrer 
cette unanimit\'{e}. Dans les autres, les opinions sont tr\`{e}s partag\'{e}es.
 Frey est le plus cat\'{e}gorique : il n'admet de division selon la formation 
que pour des mots de composition compl\`{e}tement fran\c{c}aise, et la rejette 
sinon... Le {\em Code typo\-graphique}, tout en adoptant ce m\^{e}me point
 de vue << ... [reconna\^{\i}t] n\'{e}anmoins que certains auteurs de travaux 
scientifiques pr\'{e}f\`{e}rent la division \'{e}ty\-mologique 
qui fait ressortir
 la racine grecque ou latine. >> Quant \`{a} Gouriou, il \'{e}crit :
<< On pr\'{e}f\`{e}rera cependant garder la coupure \'{e}tymologique
 chaque fois que les  composants sont {\em ais\'{e}ment} re\-connaissables. >> 
(L'italique est de Gouriou.) 
Telle est aussi l'opinion de Girodet >>. 
\everyparguillemets

Il faut noter que cette option impose que le paragraphe commence et se
termine par des guillemets. % sinon code \guillpar et \parguill
C'est pour cela que nous n'avons pas mis cette option par d\'{e}faut.

\subsubsection{Un test assez m\'{e}chant}
Voici un exemple d'utilisation dans un environement \verb|quotation|%
\footnote{Nous avons introduit \texttt{\backslash moretolerance} 
pour obtenir une composition correcte.} :
\begin{quotation}
\moretolerance\moretolerance\moretolerance
<< Je ne peux mieux faire que de citer la d\'{e}finition qu'a donn\'{e}e
de la gravure un de nos ma\^{\i}tres fondeurs, Fournier le Jeune :

<< La scien\-ce du graveur, dit-il, consiste \`{a} conna\^{\i}tre la figure
la plus parfaite que l'on puisse donner aux caract\`{e}res, les dimensions
qu'ils doivent avoir  et \`{a} les repr\'{e}senter sur l'acier pour les frapper
sur le cuivre afin d'en former des matrices qui perp\'{e}tuent des lettres
\`{a} l'infini par la fonte. \endguillemets
\end{quotation}

Le m\^{e}me exemple sans \verb|quotation|  :

<< Je ne peux mieux faire que de citer la d\'{e}finition qu'a donn\'{e}e
de la gravure un de nos ma\^{\i}tres fondeurs, Fournier le Jeune : 

<< La scien\-ce du graveur, dit-il, consiste \`{a} con\-na\^{\i}tre la figure
la plus parfaite que l'on puisse donner aux caract\`{e}res, les dimensions
qu'ils doivent avoir  et \`{a} les repr\'{e}senter sur l'acier pour les frapper
sur le cuivre afin d'en former des matrices qui perp\'{e}tuent des lettres
\`{a} l'infini par la fonte. \endguillemets
\bigskip

\noeveryparguillemets
Puis avec \verb|\noeveryparguillemets| (c.-\`{a}-d. sans \verb|quotation|) :

<< Je ne peux mieux faire que de citer la d\'{e}finition qu'a donn\'{e}e
de la gravure un de nos ma\^{\i}tres fondeurs, Fournier le Jeune : 

<< La scien\-ce du graveur, dit-il, consiste \`{a} conna\^{\i}\-tre la figure
la plus parfaite que l'on puisse donner aux caract\`{e}res, les dimensions
qu'ils doivent avoir  et \`{a} les repr\'{e}senter sur l'acier pour les frapper
sur le cuivre afin d'en former des matrices qui perp\'{e}tuent des lettres
\`{a} l'infini par la    % En cas d'arr\^{e}t \`{a} cet endroit : le format
fonte. \endguillemets%.fmt utilis\'{e} n'est prob. pas ds le bon codage !
\bigskip

Et enfin avec \verb|quotation|, voil\`{a} 
ce que cela peut donner\label{quotation} :
%%% La \marginpar suivante pose un pb de ``Lost Float'' qd elle est
%%% placee plus loin, pourquoi ?
\marginpar{{\footnotesize Il y a ici un probl\`{e}me \`{a} \'{e}tudier en 2 colonnes !}}
\begin{quotation}
<< Je ne peux mieux faire que de citer la d\'{e}finition qu'a donn\'{e}e
de la gravure un de nos ma\^{\i}tres fondeurs, Fournier le Jeune :

<< La scien\-ce du graveur, dit-il, consis\-te \`{a} conna\^{\i}tre la figure
la plus parfaite que l'on puisse donner aux caract\`{e}res, les dimensions
qu'ils doivent avoir  et \`{a} les repr\'{e}senter sur l'acier pour les frapper
sur le cuivre afin d'en former des matrices qui perp\'{e}tuent des lettres
\`{a} l'infini par la fonte.
 \endguillemets
\end{quotation}
\everyparguillemets
On notera ici les espaces inter-mots beaucoup plus {\em tol\'{e}rants}. C'est
la seule solution trouv\'{e}e pour arriver \`{a} imprimer 
quelque chose d'\`{a} peu
pr\`{e}s correct en double colonnage.

\vfill
Terminons la page en anglais pour tester le haut de page. Les guillemets
doivent \^{e}tre bons avec le codage T1.

\english
Let's complete the page with english text in order to test and show
how will be printed the header.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newpage\french
\onecolumn
\subsubsection{M\^{e}me test en \mdseries\texttt{\textbackslash onecolumn}}
Voici un exemple en environement \verb|quotation| :
\begin{quotation}
<< Je ne peux mieux faire que de citer la d\'{e}finition qu'a donn\'{e}e
de la gravure un de nos ma\^{\i}tres fondeurs, Fournier le Jeune :

<< La scien\-ce du graveur, dit-il, consiste \`{a} conna\^{\i}tre la figure
la plus parfaite que l'on puisse donner aux caract\`{e}res, les dimensions
qu'ils doivent avoir  et \`{a} les repr\'{e}senter sur l'acier pour les frapper
sur le cuivre afin d'en former des matrices qui perp\'{e}tuent des lettres
\`{a} l'infini par la fonte. \endguillemets
\end{quotation}

Le m\^{e}me exemple sans \verb|quotation|  :

<< Je ne peux mieux faire que de citer la d\'{e}finition qu'a donn\'{e}e
de la gravure un de nos ma\^{\i}tres fondeurs, Fournier le Jeune : 

<< La scien\-ce du graveur, dit-il, consiste \`{a} conna\^{\i}tre la figure
la plus parfaite que l'on puisse donner aux caract\`{e}res, les dimensions
qu'ils doivent avoir  et \`{a} les repr\'{e}senter sur l'acier pour les frapper
sur le cuivre afin d'en former des matrices qui perp\'{e}tuent des lettres
\`{a} l'infini par la fonte. \endguillemets
\bigskip

\noeveryparguillemets
Puis avec \verb|\noeveryparguillemets| (sans \verb|quotation|) :

<< Je ne peux mieux faire que de citer la d\'{e}finition qu'a donn\'{e}e
de la gravure un de nos ma\^{\i}tres fondeurs, Fournier le Jeune : 

<< La scien\-ce du graveur, dit-il, consiste \`{a} conna\^{\i}tre la figure
la plus parfaite que l'on puisse donner aux caract\`{e}res, les dimensions
qu'ils doivent avoir  et \`{a} les repr\'{e}senter sur l'acier pour les frapper
sur le cuivre afin d'en former des matrices qui perp\'{e}tuent des lettres
\`{a} l'infini par la fonte. \endguillemets
\bigskip

Et enfin avec \verb|quotation| :
\begin{quotation}
                    \let\bkORI\break
                    %\def\break{\bkORI\hbox to 0pt{/}}% for debug
                    %\ancientguillemets% for debug
<< Je ne peux mieux faire que de citer la d\'{e}finition qu'a donn\'{e}
de la gravure un de nos ma\^{\i}tres fondeurs, Fournier le Jeune : 

<< La scien\-ce du graveur, dit-il, consiste \`{a} conna\^{\i}tre la figure
la plus parfaite que l'on puisse donner aux caract\`{e}res, les dimensions
qu'ils doivent avoir  et \`{a} les repr\'{e}senter sur l'acier pour les frapper
sur le cuivre afin d'en former des matrices qui perp\'{e}tuent des lettres
\`{a} l'infini par la fonte. \endguillemets
\end{quotation}
\everyparguillemets

\subsubsection{Test de << stretchability >>}

Les espaces doivent \^{e}tre \'{e}galement r\'{e}partis sur la ligne :

\medskip
\hbox to \hsize{etiord-gauche\footnote{En plain \TeX{} l'espacement est ici
\label{etiord}
                                       curieusement incorrect ! ...}
 << centre-ertnec >> \hbox{}\footnote{... alors qu'il faudrait 
la m\^{e}me r\'{e}partition
                               de l'espace.}%
                               ehcuag-droite}
\medskip

\subsection{Test des commandes \mdseries\texttt{\textbackslash ifnum}}

\ifnum 1 < 3 1\verb| < |3 est VRAI, bien s\^{u}r ! 
       \else 1\verb| < |3 est FAUX ! \fi
comme 
\ifnum 3 > 1 3\verb| > |1 est aussi VRAI, bien s\^{u}r ! 
       \else 3\verb| > |1 est FAUX ! \fi

\medskip

\subsection{Test des commandes \mdseries\texttt{\textbackslash everypar}}

{J'ai cod\'{e} dans cette section \verb|\everypar{$++\,$}| : \everypar{$++\,$}

Paragraphe 1 << citation niveau 1

Paragraphe 2 << citation niveau 2

Paragraphe 3 fin citation niveau 2 >> puis fin niveau 1 >>

Paragraphe 4}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newpage% tjrs en 1 colonne
\hbox{}\ifx\itshape\undefined\else% avoid old frencht crash
\subsection{Test de fermeture pr\'{e}matur\'{e}e}

Il arrive que les guillemets soient ferm\'{e}s dans un environnement
plus int\'{e}rieur qui n'apparie donc pas  correctement les blocs.
Voici un exemple d'utilisation :

\begin{verbatim}
Ma\^{\i}tre Corbeau dit \`{a} son clerc : << \itshape Cher coll\`{e}gue,

\begin{itemize}
\item Ah que vous \^{e}tes joli !
\item Ah que vous me semblez beau ! >> \upshape  
et s'enfuit de ce pas...
\end{itemize}

\endguillemets
\textsf{Quel homme \'{e}trange, n'est-ce pas ?}
\end{verbatim}

Voici ce que cela donne comme composition :

\medskip
\bgroup% for frenchle
Ma\^{\i}tre Corbeau dit \`{a} son clerc : << \itshape Cher coll\`{e}gue,

\SmsG%
\begin{itemize}
\item Ah que vous \^{e}tes joli !
\item Ah que vous me semblez beau ! >> \upshape 
et s'enfuit de ce pas...
\end{itemize}
\FmsG%

\endguillemets
\egroup% for frenchle
\textsf{Quel homme \'{e}trange, n'est-ce pas ?}

\medskip
On notera plusieurs choses. Premi\`{e}rement il a fallu
r\'{e}tablir \verb|\upshape| apr\`{e}s les guillemets fermants,
du fait du mauvais appariement des blocs. Ensuite un message
sort indiquant une fermeture pr\'{e}matur\'{e}e des guillemets.
Cette fermeture restant incompl\`{e}te on note enfin que l'on a forc\'{e}
un \verb|\endguillemets| pour clore proprement et d\'{e}finitivement
l'environnement guillemets.

\subsection{\mdseries\texttt{\textbackslash everyparguillemetsremoved}}
\label{noeveryparguillemetsremoved}
Dans le m\^{e}me exemple nous pouvons aussi interdire la g\'{e}n\'{e}ration
automatique des guillemets ouvrants \`{a} chaque d\'{e}but de paragraphe ;
il faut alors saisir \verb|\everyparguillemetsremoved| :
\everyparguillemetsremoved

\medskip
\bgroup% for frenchle
Ma\^{\i}tre Corbeau dit \`{a} son clerc : << \itshape Cher coll\`{e}gue,

\SmsG%
\begin{itemize}
\item Ah que vous \^{e}tes joli !
\item Ah que vous me semblez beau ! >> \upshape 
et s'enfuit de ce pas...
\end{itemize}
\FmsG%

\endguillemets
\egroup% for frenchle
\textsf{Quel homme \'{e}trange, n'est-ce pas ?}

\medskip
Il suffit ensuite de r\'{e}tablir  \verb|\everyparguillemets|.
\everyparguillemets
\fi% ifx \itshape

\subsection{Test de l'espacement}
{\def\marque#1{\vbox{\halign{\hfil##\hfil\cr 
                               \llap{\vrule width4.5mm height.4pt}%
                               \rlap{\vrule width4.5mm height.4pt}\cr
                               \noalign{\vskip-1cm}%
                                   #1\cr}}}
 \Huge
 \def\ecartement{\fbox{a << \marque{\hbox{$|$}} >> b}}
 \ecartement
}
% Difference de taille a voir entre les deux %%%%%%
\setbox7\hbox{\leftguillemets\ X}
\setbox8\hbox{X\ \rightguillemets}
\SmsG%
\message{Taille des boites page \thepage\space \string: 
         \the\wd7=\string?=\the\wd8}
\FmsG%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\onecolumn
\newpage
\hbox{}
\vfill
\centerline{\Large Page intentionnellement laiss\'{e}e blanche}
\vfill
\twocolumn
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newpage

\subsection{Guillemets interrompus}
Une citation peut \^{e}tre en anglais et donc se commencer par
\vers|<< \|\vers|english| et se terminer par \vers|\|\vers|french >>|. Ce cas
ne doit plus g\'{e}n\'{e}rer de message 
{\em fermeture de guillemets non ouverts} !
Voici le test, r\'{e}alis\'{e} ici
tout d'abord avec l'environnement \vers|nonfrench| :

\medskip
1 \fbox{<< \begin{nonfrench}% LaTeX keeps space
          Text in English
          \end{nonfrench}% LaTeX keeps space
        >>}


\medskip
Puis avec : \\
\verb|\begin{english}| ... \verb|\end{english}| :

\medskip
% bypass here our TeX--XeT emulation to avoid message: english environment
% ended by \end{guillemets}
\def\temp{\begingroup}
\ifx\beginL\temp
\else
{% local redef of english for plain and our specific test file
 \ifx\undefined\englishORI\else\let\english\englishORI\fi%
2 \fbox{<< \begin{english}%  LaTeX keeps space
          Text in English 
          \end{english}%  LaTeX keeps space
        >>}

\medskip
Et enfin  avec \verb|\|\verb|english| ... \verb|\endenglish| :

\medskip
3 \fbox{<< {\csname english\endcsname
          Text in English
          \csname endenglish\endcsname}% space here to remove
        >>}
}% local redef of english for plain test
\fi

\medskip
Ceci avait aussi pour but de tester ces possibilit\'{e}s de
changement de langage et de v\'{e}rifier l'espacement qui
devrait \^{e}tre ainsi :

\medskip
0 \fbox{<< Text in English >>}

\noenglishdoublequotes
\subsection{`` {\mdseries\texttt{\textbackslash noenglishdoublequotes}} ''}

Nous avons mis la commande \vers|\noenglish|\-\vers|doublequotes| juste avant
le titre de section de fa\c{c}on \`{a} remplacer les << quotes >> anglaises
par des guillemets fran\c{c}ais dans ce titre.
Il s'agit de v\'{e}rifier aussi que la g\'{e}n\'{e}ration des fichiers auxiliaires
\verb|.aux| et \verb|.toc| ne pose pas de probl\`{e}me lorsque ces fichiers 
sont r\'{e}utilis\'{e}s. Bien s\^{u}r, si cette option n'est pas activ\'{e}e pour tout le
document, comme ici, on ne retrouvera pas les guillemets fran\c{c}ais
dans la table des mati\`{e}res.

\noenglishdoublequotes

\english% histoire de changer de langue ?

\newpage\french
\subsection%{<< no-french guillemets >>}
           {\mdseries\texttt{\textbackslash nofrenchguillemets}}
En codant \verb|\nofrenchguillemets|
\nofrenchguillemets on n'utilise plus
les guillemets programm\'{e}s dans l'extension {\tt french}. Si on les utilise
malgr\'{e} tout, le r\'{e}sultat d\'{e}pendra de la police. Ici nous utilisons la
police \fontname\font{} et nous obtenons : 

<%
 < en 7-bits >%
              >

et aussi :

<< en 8-bits >>. 

R\'{e}activons maintenant les guillemets avec la commande
\verb|\frenchguillemets|
\frenchguillemets et faisons le m\^{e}me test :

<%
 < en 7-bits >%
              >

et aussi :

<< en 8-bits >>. Voyez-vous ? 
\vfill
\subsection{Haut de page+guillemets}

\subsubsection{En 8-bits}
Il ne devrait pas y avoir de probl\`{e}me du tout. 
Car, puisqu'il s'agit d'un guillemet en 8-bits, cela doit
\^{e}tre forc\'{e}ment un vrai guillemet fran\c{c}ais. Mais, malheureusement,
{\em la solution pour l'impl\'{e}menter n'est pas encore trouv\'{e}e avec
le codage OT1}.
Le codage de fonte de ce document imprime : 
\nonfrench <%
           < >%
             >%
\endnonfrench{} 
 (doit \^{e}tre parfait en T1).

\subsubsection{En 7-bits}
En codage OT1 les guillemets 7-bits de haut de page ne peuvent \^{e}tre
bons sur cette page 
 {\bf QUE} parce que nous avons termin\'{e} la
page en fran\c{c}ais, sinon nous aurions eu :
\ifx\textexclamdown\undefined
    \def\textexclamdown{!`}\def\textquestiondown{?`}
\fi
\textexclamdown\textexclamdown{} et \textquestiondown\textquestiondown
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newpage
\hbox{ }\NL{25}

\subsection{Guillemets et maths}

L'\'{e}quation suivante ne doit plus produire le fameux message :

{\tt ! Argument of \backslash \string @genG % string pour amslatex
 has an extra % { pour emacs
 $\}$% c'est un \delimiter qui pose pb tq avec frencht d'ou mode math
.}

$$U^{k+1}=U^{k}- {<  g_{k},d_{k} >}$$
   
\section{D'autres guillemets}\label{autres}
Avec \FP\ il est possible de substituer automatiquement aux
guillemets `anglais' la forme  \noenglishquote `que voici' en donnant la
sous-option \verb|\noenglishquote|.
Mais attention, les apostrophes deviennent des accents 
comme dans : {\em il s'agit ici de l'exemple}
\englishquote qui aurait d\^{u} \^{e}tre imprim\'{e} : 
{\em il s'agit ici de l'exemple}.
Un usage intensif de cette option est plut\^{o}t \`{a} d\'{e}conseiller. 

\newpage\english
\section{French guillemets}
Using french guillemets in an english document (\verb|<<| and \verb|>>|) will
give (depending of font encoding) that: << and >>, it is normal!

As you can look in the previous columns, french guillemets have specific
rules. They are used for quotation when an author is cited or each time an
emphasis is needed. Normally, italic is not used inside a quoted french
text, excepted when you really want to show some wording.

When opened, each paragraph of the quoted text will start left
 with the opening french guillemets.

Another quotated text can take place inside a first level. This second level
citation is also very specific. Each line must start with guillemets. 

The style designer, from time to time, chose to apply here an ancient rule
by putting here closing guillemets.

The technical tools involved in \FP\ 
 disallow to have at the same time
the \verb|\everypar| possibility and the second level mechanism. 

\subsection{Guillemets and maths}

The following equation is always correct:

$$U^{k+1}=U^{k}- {<  g_{k},d_{k} >}$$

and never produce an error message.
\NL1
   
\section{Other guillemets}
With \FP\ it is possible to replace english guillemets by
diacritic caracters. But, be careful, all apostrophes will be diacritics too.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newpage\french 
\section{Trois petits points}
Les points de suspension sont : ... et non pas ceux de \TeX{} : $\ldots{}$
\noTeXdots
En codant \verb|\noTeXdots| les commandes \verb|\dots| ou \verb|\ldots| de
\LaTeX{} donneront : $\ldots{}$ Mais l'option par d\'{e}faut a \'{e}t\'{e}
volontairement maintenue au standard  (\verb|\TeXdots|) puisqu'il suffit
de ne pas les utiliser.\TeXdots

\section{Crochets}
IBM, en son temps, avait cr\'{e}\'{e} l'EBCDIC dans lequel ne figurait pas
les crochets ([ ]). C'est la raison pour laquelle les utilisateurs IBM
ont parfois substitu\'{e} $<$ et $>$ aux crochets.  La sous option
\verb|\EBCDICbrackets| \EBCDICbrackets
permet de les remplacer comme ici <automatiquement> par des crochets.
Mais faites attention, les doubles guillemets 
\verb|<|\verb|<| et \verb|>|\verb|>| % pour eviter la conversion 8bits
 ne donneront jamais des crochets mais << et >> 
(sauf en mode \verb|verbatim|). On peut en g\'{e}n\'{e}ral
se contenter de \verb|< <| et \verb|> >| pour obtenir < < et > >. 
On revient  \`{a} la situation ant\'{e}rieure en tapant la commande suivante :
\verb|\normalbrackets|\normalbrackets. 

\section{D\'{e}bordements}
Nous venons de choisir  l'option  d'indication de d\'{e}bordement de ligne 
\verb|\overfullhboxmark| et nous voyons son
effet lorsque la ligne ne peut \^{e}tre coup\'{e}e gr\^{a}ce \`{a} l'impression
de la petite bo\^{\i}te noire. 
%(cf. page \pageref{debordement}).
Cette option est activ\'{e}e au minimum pour une page enti\`{e}re. 
Ne pas sp\'{e}cifier l'option et son contraire sur la m\^{e}me page sinon
l'effet est inchang\'{e}.

\labelsinmargin
\section{\mdseries\texttt{\textbackslash labelsinmargin}}%
\label{labels: in: margin}
\FP\ offre la possibilit\'{e}, comme cela a \'{e}t\'{e} demand\'{e}
\`{a} partir de cette section, d'imprimer dans la marge le libell\'{e} des
\'{e}tiquettes utilis\'{e}es dans les ordres \verb|\label|. 
Cette option, utilisable
aussi en dehors du fran\c{c}ais, est la suivante :
\verb|\labelsinmargin|.

\newpage\english
\section{Three dots}
Usual and common \TeX{} and \LaTeX{} dots are not french dots.
\NL4

\section{Brackets}
An option is offered to replace \verb|<| and \verb|>| by brackets.
\NL{11}

\section{\mdseries\texttt{\textbackslash overfullhboxmark}}
The command \verb|\overfullhboxmark| print a black
box where your have an overfull \verb|hbox| i.e.\  when a line can't be
hyphenated. The default is \verb|\nooverfullhboxmark|.
\NL4

\section{Labels in margin}\label{labels are in margin}
An option allow you to print the labels you use in a page. These labels are
printed in margins.
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newpage\french
\section{Des points sur...}
Inutile de mettre les points sur les i quand on accentue un i. Tout bon
\'{e}diteur de texte doit faire ce travail pour vous. Sinon il existe la 
sous-option \verb|\idotless| qui produira \idotless
\let\XX\^% Pour \'{e}viter une traduction \'{e}ventuelle en 8 bits
\XX{i} si on lui demande d'imprimer \verb|\^i|.
\iwithdot La valeur par d\'{e}faut
dans \FP\ est \verb|\iwithdot| qui donnera malgr\'{e} tout de
bons i accentu\'{e}s avec ML\TeX{} (\^{\i}) s'ils sont saisis directement en 8 
bits (v\'{e}rifiez dans votre fichier source).

{\makeatletter\def\GOfrench{T1}\ifx\GOfrench\f@encoding
\section{Ponctuation et  mode \protect\linebreak % SPECIAL FONTES EC REELLES
         math\'{e}matique}
\else
\section{Ponctuation et  mode math\'{e}matique}
\fi}
Il s'agit de v\'{e}rifier que les modifications introduites 
par l'extension \FP\ 
ne posent aucun genre de probl\`{e}me en mode math\'{e}matique.
\\ Nous d\'{e}finissons une macro \verb|\test| :
\\  \verb|\def\test#1{#1}|\def\test#1{#1}
\\ pour voir si le mode math\'{e}matique peut \^{e}tre appel\'{e} 
sans probl\`{e}me en
argument de macro-instructions. L'appel de \verb|\test{$x''$}| ne doit
pas poser de probl\`{e}me%
\iflatex
, ni m\^{e}me \verb|\texttt{|\-\verb|[$x''=0$]}|
\\ Ainsi : \verb|\texttt{[$x''=0$]}|
\\donne : \texttt{[$x''=0$]} et
\else%
. \\Ainsi :
\fi
\\  \verb|$A':B''_1<C_{d'}>D^2\ et\,\ !n\ ?\ ;$|
\\  \verb|\test{$A':B''_1<C_{d'}$}|
\\donne : $A':B''_1<C_{d'}>D^2\ et\,\ !n\ ?\ ;$
\\\phantom{donne :} \test{$A':B''_1<C_{d'}$}
\\Avec \verb|\noenglishquote|\noenglishquote{} cela...
\\donne : $A':B''_1<C_{d'}>D^2\ et\,\ !n\ ?\ ;$
\\\phantom{donne :} \test{$A':B''_1<C_{d'}$}
\englishquote
\\ puis avec \verb|\noenglishdoublequotes| \noenglishdoublequotes et
`` mise en vedette '' :
$$%  \begin{displaymath}
            A':B''_1<C_{d'}>D^2\ et\,\ !n\ ?\ ;
$$%  \end{displaymath}
$$%  \begin{displaymath}
            \test{A':B''_1<C_{d'}}
$$%  \end{displaymath}
De m\^{e}me :
\begin{verbatim}
{\tt CALL SUBR($<$iopt$<$,ilopt$>%
                                 >$)}
\end{verbatim}
doit s'imprimer :\\
{\tt CALL SUBR($<$iopt$<$,ilopt$>%
                                 >$)}\\
sans produire le message d'erreur << Fermeture de guillemets non ouverts ! >>.
\englishdoublequotes


\newpage\english
\section{An \i dotless}
Everybody knows that a french ``{\em i circonflexe}'' has no dot on it. 
(In my opinion it is a \TeX{} bug to leave the dot when a diacritic is
put on.) To suppress the dot automatically the best way is to use a well
programmed text editor. \FP\ offers another opportunity with
\verb|\idotless|.

\NL2

\section[Math mode and punctuation]{Math mode and \newline punctuation}
Here we verify that french modifications about punctation
does not introduce any problem in printing mathematics. 
\\ We define a new  macro \verb|\test| :
\\  \verb|\def\test#1{#1}|\def\test#1{#1}
\\ in order to see if there is no more problem when passing maths
inside a macro argument. Calling  \verb|\test{$x''$}| must not
introduce any problem%
\iflatex
, as well as \verb|\texttt{|\-\verb|[$x''=0$]}|
\NL1\\So: \verb|\texttt{[$x''=0$]}|
\\gives: \texttt{[$x''=0$]} and
\else%
. \NL1\\So:
\fi
\\\verb|$A':B''_1<C_{d'}>D^2\ et\,\ !n\ ?\ ;$|
\\\verb|\test{$A':B''_1<C_{d'}$}|
\\ gives: $A':B''_1<C_{d'}>D^2\ et\,\ !n\ ?\ ;$
\\\phantom{gives:} \test{$A':B''_1<C_{d'}$}
\\With \verb|\noenglishquote|\noenglishquote{} it$\ldots{}$
\\gives: $A':B''_1<C_{d'}>D^2\ et\,\ !n\ ?\ ;$
\\\phantom{gives:} \test{$A':B''_1<C_{d'}$}
\englishquote
\\ and with \verb|\noenglishdoublequotes|\noenglishdoublequotes{}  
in ``display'' math mode:
$$%  \begin{displaymath}
            A':B''_1<C_{d'}>D^2\ et\,\ !n\ ?\ ;
$$%  \end{displaymath}
$$%  \begin{displaymath}
            \test{A':B''_1<C_{d'}}
$$%  \end{displaymath}
\englishdoublequotes 
Also:
\ifx\documentclass\undefined\\ % Still Plain!
\else\\[-2\baselineskip] % to keep the same spacing as in French
\fi
\begin{verbatim}
{\tt CALL SUBR($<$iopt$<$,ilopt$>%
                                 >$)}
\end{verbatim}
must print:\\
%\SmsG%
{\tt CALL SUBR($<$iopt$<$,ilopt$>%
                                 >$)}\\
%\FmsG%
without producing the error message: 
``Fermeture de guillemets non ouverts !''.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newpage\french
Pour ma part lorsque je d\'{e}sire des crochets que je n'ai pas
au clavier, je pr\'{e}f\`{e}re taper :\\
\verb|{\tt CALL SUBR(<iopt<,ilopt> >)}| et utiliser
l'option \verb|\EBCDICbrackets|\EBCDICbrackets{} :\\
{\tt CALL SUBR(<iopt<,ilopt> >)}

Cette option n'a pas d'effet en mode math\'{e}matique :
$$ 1233 < 1234 <%
                < 1235 >%
                        > 1234 > 1233 $$
\normalbrackets

\makeatletter% we should use \frac with AmS
\ifx\RIfM@\undefined%\ifx\csname amsmath.sty\endcsname\relax
     \long\def\text#1{#1}\long\def\frac#1#2{{#1\over#2}}
\fi
\makeatother

V\'{e}rifions aussi 
($x < {\frac{1}{3}} < {\frac{1}{2}} > {\frac{1}{4}}$) :
$$x <  \frac{1}{3}  < \frac{1}{2}   >  \frac{1}{4} $$
puis aussi :

 \text{\quad pour $|y| < \frac{111}{444}$}

\bigskip
La double ponctuation ne doit avoir aucun effet 
(visible) dans une formule en mode
math\'{e}matiques, est-ce bien le cas sur l'exemple ci-dessous :

{\LARGE $$a := b, (c!n=m) \textrm{ ; vrai ?}$$}

On notera que la partie texte de la formule a \'{e}t\'{e} saisie avec la
commande : \\
\verb|\textrm{ ; vrai ?}|\\
et que l'espacement fran\c{c}ais y a \'{e}t\'{e} appliqu\'{e}.

\iflatex
\subsection{Le cas de la virgule}
En standard \AllTeX{} (ou alors avec l'option sp\'{e}ciale 
\verb|\regularmathcomma| de \FP) le traitement de la virgule
est sp\'{e}cifique, ainsi quand on tape ce qui suit en mode
math\'{e}matique de mise en valeur :
\regularmathcomma%
\begin{versatim}
$$\textrm{La fonction}\ f(x,y)\ 
  \textrm{ou le Vecteur}\ V(x, y, z)$$
$$Total=1,255\,\$\ ou\ 1\,500,00\,\textrm{EUR}$$
\end{versatim}
on obtient des espacements apr\`{e}s les virgules,
qu'il y ait ou non des espaces dans le source \TeX\ :
$$\textrm{La fonction}\ f(x,y)\ 
  \textrm{ou le Vecteur}\ V(x, y, z)$$
$$Total=1,255\,\$\ ou\ 1\,500,00\,\textrm{EUR}$$
(ce qui montre une anomalie dans la composition
des nombres relatifs)
\frenchmathcomma
\fi

\newpage\english
When I have no brackets on my keyboard I prefer to type:\\
\verb|{\tt CALL SUBR(<iopt<,ilopt> >)}|\\ using
 the option \verb|\EBCDICbrackets| but the result in english
remains unchanged\EBCDICbrackets{}:\\
{\tt CALL SUBR(<iopt<,ilopt> >)}

And within math mode:
$$ 1233 < 1234 <%
                < 1235 >%
                        > 1234 > 1233 $$
\normalbrackets

\makeatletter% we should use \frac with AmS
\ifx\RIfM@\undefined%\ifx\csname amsmath.sty\endcsname\relax
     \long\def\text#1{#1}\long\def\frac#1#2{{#1\over#2}}
\fi
\makeatother

Let's verify also ($x < {\frac{1}{3}} < {\frac{1}{2}} > {\frac{1}{4}}$) :
$$x < \frac{1}{3} < \frac{1}{2} > \frac{1}{4}$$
and:

 \text{\quad pour $|y| < \frac{111}{444}$}

\bigskip
The ``double punctuation'' should not have any effect
in maths, which is obviously the case in the following
English example:
\NL1

{\LARGE $$a := b, (c!n=m) \textrm{ ; vrai ?}$$}

Though the text part of the formula has been typed
via a command: \\
\verb|\textrm{ ; vrai ?}|\\
the french spacing doesn't apply here.

\iflatex
\subsection{The comma case}
With \AllTeX{} standard (or with the special \FP\ 
\verb|\regularmathcomma| the processing of comma is really specific.
So, when you type in the following in display math mode:
\regularmathcomma%
\begin{verbatim}
$$\textrm{La fonction}\ f(x,y)\ 
  \textrm{ou le Vecteur}\ V(x, y, z)$$
$$Total=1,255\,\$\ ou\ 
      1\,500,00\,\textrm{EUR}$$
\end{verbatim}
you will get thin spaces after the commas,
no matter spaces are given or not in the \TeX\ source:
$$\textrm{La fonction}\ f(x,y)\ 
  \textrm{ou le Vecteur}\ V(x, y, z)$$
$$Total=1,255\,\$\ ou\ 1\,500,00\,\textrm{EUR}$$
(which shows a french typesetting error for
the relative numbers).
\frenchmathcomma
\fi%

\iflatex
\newpage\french
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Par contre avec \FP\ on n'obtient 
aucun espacement suppl\'{e}mentaire :
$$\textrm{La fonction}\ f(x,y)\ 
  \textrm{ou le Vecteur}\ V(x, y, z)$$
$$Total=1,255\,\$\ ou\ 1\,500,00\,\textrm{EUR}$$
cela est d\^{u} \`{a} l'option \verb|\frenchmathcomma| qui est
activ\'{e}e par d\'{e}faut avec \FP.
Mais cela montre alors une anomalie de composition
dans les listes $(x,y,z)$.

Si l'on veut des espaces il faut alors les indiquer
explicitement, comme cela est l'usage, plus
g\'{e}n\'{e}ralement, en mode math\'{e}matique :
\begin{versatim}
$$\textrm{La fonction}\ f(x,\,y)\ 
  \textrm{ou le Vecteur}\ V(x,\,y,\,z)$$
$$Total=1,255\,\$\ ou\ 1\,500,00\,\textrm{EUR}$$
\end{versatim}
ce qui donnera :
$$\textrm{La fonction}\ f(x,\,y)\ 
  \textrm{ou le Vecteur}\ V(x,\,y,\,z)$$
$$Total=1,255\,\$\ ou\ 1\,500,00\,\textrm{EUR}$$

\medskip

On notera que \FP\ ob\'{e}it \`{a} l'extension \texttt{icomma}
lorsque cette derni\`{e}re est charg\'{e}e avant \FP, mais
seulement en fran\c{c}ais.


\newpage\english
With the \FP\ package there is no space added
at all:
\frenchmathcomma%
$$\textrm{La fonction}\ f(x,y)\ 
  \textrm{ou le Vecteur}\ V(x, y, z)$$
$$Total=1,255\,\$\ ou\ 1\,500,00\,\textrm{EUR}$$
this is due to the option \verb|\frenchmathcomma| which is
defaultly activated in the \FP\ package.
People will then distinguish a typesetting error
in the lists $(x,y,z)$.

If you want spaces you should then give them to \TeX\
explicitely, as usually done, more generally in math mode:
\begin{verbatim}
$$\textrm{La fonction}\ f(x,\,y)\ 
  \textrm{ou le Vecteur}\ 
      V(x,\,y,\,z)$$
$$Total=1,255\,\$\ ou\ 
      1\,500,00\,\textrm{EUR}$$
\end{verbatim}
which will give:
$$\textrm{La fonction}\ f(x,\,y)\ 
  \textrm{ou le Vecteur}\ V(x,\,y,\,z)$$
$$Total=1,255\,\$\ ou\ 1\,500,00\,\textrm{EUR}$$
\fi

You should notice that \FP\ respect the choice of
the \texttt{icomma} package when that last one is loaded before
\FP; but it only applies in French.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newpage\french
\section{Mon antislash est \mdseries\texttt{\backslash}}

L'antislash n'existe pas dans toutes les polices en OT1.
Que vous utilisiez \verb|\backslash| ou \verb|\textbackslash|
vous obtiendrez la m\^{e}me chose, ainsi
en romain droit on obtient :

textbackslash=\textbackslash

backslash=\backslash

\noindent
mais avec la fonte tt on obtient :

{\tt
textbackslash=\textbackslash

backslash=\backslash
}
\NL2

\section{Notes de bas de page}

\iflatex\makeatletter\xdef\countSAVED{\the\c@footnote}\makeatother\fi
\long\def\XX{%
             Num\'{e}rotation normale\footnote{Une note normalement num\'{e}rot\'{e}e.}.
             {\setcounter{footnote}{0}
             \renewcommand{\thefootnote}{\fnsymbol{footnote}}
     
             Voici une note\footnote{Premi\`{e}re note.} 
             puis une autre\footnote{Deuxi\`{e}me note.}
             puis encore une autre\footnote{Troisi\`{e}me note.}
             }}

Nous comparons ici la composition des notes de bas de page
(avec et sans \verb|\fnsymbol|)
dans une langue et dans l'autre. Voyons ce que cela donne :

\XX

\newpage\english
\section{My antislash is \mdseries\texttt{\textbackslash}}

The antislash glyph doesn't exist in all OT1 font.
Whatever you use, \verb|\backslash| or \verb|\textbackslash|
you will obtain the same output, so
in upright roman you obtain:

textbackslash=\textbackslash

backslash=$\backslash$

\noindent
but with the tt font you obtain:

{\tt
textbackslash=\textbackslash

backslash=$\backslash$
}

\noindent
but \verb|\backslash| is only available in
math mode.

\section{Compared footnotes}

We compare the typesetting of footnotes 
(with and without \verb|\fnsymbol|)
in one language versus the other. Let's look at them.

\iflatex\makeatletter\c@footnote=\countSAVED\makeatother\fi

\XX
\iflatex\makeatletter\c@footnote=\countSAVED\makeatother\fi
\addtocounter{footnote}{1}
\NL1


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newpage\french

\section{\mdseries\texttt{\textbackslash guillemetsinarrays}}

Avec \FP\ l'utilisation de guillemets \`{a} la 
fran\c{c}aise en mode texte dans les environnements \texttt{array} ou 
\texttt{eqnarray} est possible
mais il est n\'{e}cessaire de prot\'{e}ger les op\'{e}rateurs
inf\'{e}rieur (\texttt{<}) et sup\'{e}rieur (\texttt{>}) lorsqu'ils terminent
une colonne. On rajoute alors une paire d'accolades ou \verb|\relax| 
pour terminer la macro-commande :
\begin{verbatim}
$
\begin{array}{ccc}  
a  & \inferieura        &b\\ 
a  & \protect<          &b\\ 
a  & b                  &<\\       
a  & >{}                &c\\      
<{}& << >>              &c\\     
<{}& \textrm{<< text >>}&c 
\end{array}
$
\end{verbatim}

\noindent ce qui donne : 

$
\begin{array}{ccc}
a  & \inferieura        &b\\ 
a  & \protect<          &b\\ 
a  & b                  &<\\       
a  & >{}                &c\\      
<{}& << >>              &c\\     
<{}& \textrm{<< text >>}&c 
\end{array}
$

\medskip
On peut \'{e}viter d'avoir \`{a} modifier des tableaux existants et dans ce
cas on codera \verb|\no|\-\verb|guil|\-\verb|lemetsinarrays| :

\begin{verbatim}
\noguillemetsinarrays
$
\begin{array}{ccc}
a  & \inferieura        &b\\ 
a  & <                  &b\\ 
a  & b                  &<\\       
a  & >                  &c\\      
<  & << >>              &c\\     
<  & \textrm{<< text >>}&c 
\end{array}
$
\end{verbatim}

\noindent ce qui donne alors :

\noguillemetsinarrays
$
\begin{array}{ccc}
a  & \inferieura        &b\\ 
a  & <                  &b\\ 
a  & b                  &<\\       
a  & >                  &c\\      
<  & << >>              &c\\     
<  & \textrm{<< text >>}&c 
\end{array}
$
\guillemetsinarrays% reset default

\newpage\english
\section{Guillemets in arrays}
The \FP\ package allows people to print french guillemets
in \texttt{array} environments (but in text mode). This usually breaks
the code for \texttt{<} or \texttt{>} when they finish an array slot.
So you should protect them; like this:
\NL2

\begin{verbatim}
$
\begin{array}{ccc}
a  & \inferieura        &b\\ 
a  & \protect<          &b\\ 
a  & b                  &<\\       
a  & >{}                &c\\      
<{}& \textrm{<< text >>}&c 
\end{array}
$
\end{verbatim}
\NL1

\noindent which gives: 

$
\begin{array}{ccc}
a  & \inferieura        &b\\ 
a  & \protect<          &b\\ 
a  & b                  &<\\       
a  & >{}                &c\\      
<{}& \textrm{<< text >>}&c 
\end{array}
$
\NL1

\medskip

One can avoid to modify existing arrays and then just say
\verb|\noguillemetsinarrays| but this command is not
interesting in English because the problem doesn't exist
at all:

\begin{verbatim}
$
\begin{array}{ccc}
a  & \inferieura        &b\\ 
a  & <                  &b\\ 
a  & b                  &<\\       
a  & >                  &c\\      
<  & \textrm{<< text >>}&c 
\end{array}
$
\end{verbatim}
\NL1

\noindent gives the following result:

\def\GOfrench{\let\ifCLA\iffalse}% To allow dmy and frencht to compile
\ifx\ifCLA\undefined\expandafter\GOfrench\fi% without error.
$
\begin{array}{ccc}
a  & \inferieura        &b\\ 
a  & 
\ifCLA\expandafter\protect\fi% To allow \ConstantLayout test file.
<                  &b\\ 
a  & b                  &<\\       
a  & 
\ifCLA\expandafter\protect\fi% To allow \ConstantLayout test file.
>                  &c\\      
\ifCLA\expandafter\protect\fi% To allow \ConstantLayout test file.
<  & \textrm{<< text >>}&c 
\end{array}
$
\NL1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newpage\french

\noguillemetsinarrays% for continuation of column
Cette commande est aussi valable  pour les environnements
\texttt{eqnarray} :

\begin{eqnarray}
a  & <                  &b\\ 
a  & >                  &c\\      
<  & << >>              &c\\     
<  & \textrm{<< text >>}&c 
\end{eqnarray}

Pour terminer je r\'{e}tablis la valeur par d\'{e}faut :
\verb|\guillemetsinarrays| 
\guillemetsinarrays
et si j'essaye le m\^{e}me exemple j'obtiendrais
le message : \\
{\makeatletter\let\@PreserveBraces={% uggly hack for plain
\vers|! Argument of \@PreserveBraces has an|\\
\vers|extra }.|
}% closing hack.

\section{Guillemets verbatim}

Avec l'option \verb|\nofrenchguillemets| il est possible
--~si \FP\ travaille en codage de fonte du genre \texttt{T1} 
{\makeatletter\def\GOfrench{T1}\ifx\GOfrench\f@encoding\else
(mais ca ne semble pas \^{e}tre le cas ici)\fi}%
~--
\nofrenchguillemets
d'imprimer des guillemets 8-bits en verbatim : \verb|<< >>|.
\frenchguillemets

\iflatex
\section{Environnement guillemets exclus}

\begin{versatim}
\guillemets{} Je me suis dit que : 
<< avec l'option [...] les  guillemets 
sont inop\'{e}rants. \endguillemets{}
\end{versatim}
\SmsG
\noeveryparguillemets
\guillemets{}
\verb|[\guillemets{}]| Je me suis dit que : 
<< avec l'option \vers|\noevery|\-\vers|par|\-\vers|guillemets|
on ne doit pas avoir un environnement qui se termine avant la fin
du paragraphe. C'est pourquoi l'environnement \texttt{guillemets} 
n'est plus autoris\'{e} dans ce cadre.
D\'{e}sormais un message est \'{e}mis et ces environnements 
guillemets sont inop\'{e}rants. \endguillemets{}

On note que \verb|\guillemets{}| n'a aucun effet visible
et que le d\'{e}but de paragraphe est forc\'{e} aux premiers 
caract\`{e}res-guillemets ouvrants qui suivent. Le 
\verb|\endguillemets{}| de fin d'environnement ferme cependant
le paragraphe.

\guillemets [\verb|\guillemets{}|]\!
Ces environnements exclus dans le cadre de cette option
 peuvent \^{e}tre de premier ou 
/\guillemets{} deuxi\`{e}me \endguillemets{}/ niveau
comme ici (slashs). [\verb|\endguillemets{}|]
\endguillemets{}

\FmsG
\frenchguillemets
\fi%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newpage\english
Notice that with standard \LaTeX\ you obtain a message
saying that \verb|\guillemotleft| and \verb|\guillemotright|
are invalid in math mode when you try to use guillemets
in an \texttt{array} environement.
\NL{9}

\smallskip

\section{Verbatim Guillemets}

The 8bit french guillemets chars printed within
a verbatim environnement give here: \verb|<< >>|

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newpage\french
\section{Utilisation de la \mdseries\texttt{toc}}

Il n'est pas pr\'{e}vu de pouvoir composer une table des mati\`{e}res ou un
sommaire dans plus d'une langue.
On notera que \verb|\sommaire| est un apport de \FP.

\section{Fichiers {\mdseries\texttt{lof}} et {\mdseries\texttt{lot}}}
On v\'{e}rifie ici que la ponctuation fran\c{c}aise n'a pas cr\'{e}\'{e} 
d'ennui particulier.
Nous avons laiss\'{e} en blanc la figure \ref{x<<:;!?>>x} 
qui n'est qu'un simple
test. De m\^{e}me le tableau \ref{y`<<:;!?>>'y} n'est l\`{a} que pour 
cr\'{e}er une entr\'{e}e dans la liste des tableaux.

Le {\em caption} de la figure 
\ref{x<<:;!?>>x} 
 doit appara\^{\i}tre com\-me ceci :
 {\it << essai >> ;  2 cm ! pourquoi pas ?}
\begin{figure}[h]
\begin{center}
\begin{tabular}{|c|}
\hline
\ \hfill \ \\%\vspace*{2cm}
\ \\
\ Peu importe la figure...\\
\ \\
\ \\
\hline
\end{tabular}
\end{center}
\caption{<< essai >> ;  2 cm ! pourquoi pas ? 
         \protect\\ (cf. aussi le tableau \ref{frenchdactylo})}
\label{x<<:;!?>>x}
\end{figure}

Le {\em caption} du tableau
\ref{y`<<:;!?>>'y}
 doit \^{e}tre comme ceci :
{\it ` << essai >> ;  2 cm ! pourquoi pas ? '}
\begin{table}[h]
\caption{` << essai >> ;  2 cm ! pourquoi pas ? '  
         \protect\\ (cf. aussi le tableau \ref{frenchdactylo})}
\label{y`<<:;!?>>'y}

\begin{center}
\begin{tabular}{|c|}
\hline
\ \hfill \ \\
\ \\
\ Peu importe le tableau\footnote{Une note de tableau.}...\\
\ \\
\ \\
\hline
\end{tabular}
\end{center}
\end{table}

On notera les libell\'{e}s ({\sc Fig.} et {\sc Tab.}) plus confor\-mes \`{a}
l'usage fran\c{c}ais. Ne pas oublier non plus que les titres de tableaux sont
toujours plac\'{e}s, en fran\c{c}ais, avant ceux-ci contrairement aux figures.

\FP\ ne pr\'{e}voit pas que l'on puisse composer une 
partie des tables des figures (ou tableaux) en fran\c{c}ais et une autre
en anglais par exemple. Les fichiers \verb|.lof| et \verb|.lot| seront
donc compos\'{e}s enti\`{e}rement dans la langue pr\'{e}s\'{e}lectionn\'{e}e.

\newpage\english
\section{{\mdseries\texttt{toc}} file use}
No facility is given to typeset the \verb|.toc| in various languages.

Notice that \verb|\sommaire| is a new command brought up with this
package.

\section{{\mdseries\texttt{lof}} and {\mdseries\texttt{lot}} files}
Same test in English just to verify  that our french modifications
does not affect the text in English.

You will notice, of course, that the caption names are re-established
to their original values ({\bf figure} and {\bf table}).

The following figure (not referable) %(\ref{ex<<:;!?>>ex}) 
caption must look like:
<< essai >>;  2 cm! Why not?
\begin{figure}[h]
\begin{center}
\begin{tabular}{|c|}
\hline
\ \hfill \ \\
\ \\
\ No matter how is the figure$\ldots{}$\\
\ \\
\ \\
\hline
\end{tabular}
\end{center}
\caption{<< essai >>;  2 cm! Why not?
         \protect\\ (cf. also the table \ref{frenchdactylo})}
%\label{ex<<:;!?>>ex}% produit un missing \endcsname
\end{figure}

The {\em caption} of the table (not referable) %\ref{ey`<<:;!?>>'ey} 
must look like: 
` << essai >>;  2 cm! Why not? '
\begin{table}[h]
\begin{center}
\begin{tabular}{|c|}
\hline
\ \hfill \ \\
\ \\
\ No matter how is the table\footnotemark% \footnotetext est perdu !
 $\ldots{}$\\
\ \\
\ \\
\hline
\end{tabular}
\end{center}
\caption{` << essai >>;  2 cm! Why not? '
         \protect\\ (cf. also the table \ref{frenchdactylo})}
%\label{ey`<<:;!?>>'ey}% generates missing \endcsname
\end{table}\footnotetext{A note from a table.}
\NL1

Notice that we have here the standard caption names used by \LaTeX{}.

You can see in the French column the specific labels and places of caption
titles (under the figure but over the table).

Don't try to compose \verb|.lof| and \verb|.lot| files in more than one
language, it's not designed in this (stupid?) way!

\french
\begin{table*}[tb]
\caption{` << essai >> ;  2 cm ! pourquoi pas ? '  
         (cf. aussi le tableau \ref{frenchdactylo})}
\label{2`<<:;!?>>'2}
\begin{center}
\begin{tabular}{|c|}
\hline
\ \hfill \ \\
\ \\
\ Peu importe le tableau sur deux colonnes%
\footnote{Une note de tableau.}...\\
\ \\
\ \\
\hline
\end{tabular}
\end{center}
\end{table*}

\newpage
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\section{Encore un tableau...}
Mais celui-ci est sur deux colonnes si l'option
\verb|twocolumn| est active. V\'{e}rifions simplement
que le traitement est le m\^{e}me qu'en une seule
colonne.

Le {\em caption} du tableau
\ref{2`<<:;!?>>'2}
 doit \^{e}tre comme ceci :
{\it ` << essai >> ;  2 cm ! pourquoi pas ? '}

\section{\sloppy Encore {\mdseries\texttt{\textbackslash labelsinmargin}}}

\`{A} nouveau nous utilisons \verb|\labelsinmargin|
\labelsinmargin
pour v\'{e}rifier son fonctionnement dans une figure
et un titre de figure 

\begin{figure}[h]
\label{label de la figure}
\begin{center}
\begin{tabular}{|c|}
\hline
\ \hfill \ \\
\ \\
\ Peu importe la figure...\\
\ \\
\ \\
\hline
\end{tabular}
\end{center}
\caption{le titre de la figure avec label
\label{label du titre fig.}}
\end{figure}

M\^{e}me test avec un tableau :
\begin{table}[h]
\label{label du tableau}
\caption{le titre du tableau avec label\label{label du titre tab.}}
\begin{center}
\begin{tabular}{|c|}
\hline
\ \hfill \ \\
\ \\
\ Peu importe le tableau...\\
\ \\
\ \\
\hline
\end{tabular}
\end{center}
\end{table}

\sloppypar{
D\'{e}sactivons d\'{e}finitivement l'option 
avec \verb!\nolabelsinmargin!.
}
\nolabelsinmargin

\newpage\english
\NL8
\section{{\mdseries\texttt{\textbackslash labelsinmargin}} again}

Again we test \verb|\labelsinmargin|
\labelsinmargin
to verify that it is running within a figure
and in a figure's caption. 

\begin{figure}[h]
\label{label in a figure}
\begin{center}
\begin{tabular}{|c|}
\hline
\ \hfill \ \\
\ \\
\ No matter the figure$\ldots{}$\\
\ \\
\ \\
\hline
\end{tabular}
\end{center}
\caption{title with a label\label{label in fig. caption}}
\end{figure}

Same test with a table:
\begin{table}[h]
\label{label in a table}
\begin{center}
\begin{tabular}{|c|}
\hline
\ \hfill \ \\
\ \\
\ No matter the table$\ldots{}$\\
\ \\
\ \\
\hline
\end{tabular}
\end{center}
\caption{title with a label\label{label in a tab. caption}}
\end{table}

Disactivate definitely the option with \verb!\nolabelsinmargin!.
\nolabelsinmargin

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newpage\french

\section{Notes dans \mdseries\texttt{\textbackslash caption}}

Si une note dans un tableau doit \^{e}tre imprim\'{e}e \`{a} la fin du
tableau, une note dans un titre de tableau doit \^{e}tre
imprim\'{e}e en fin de page. Malheureusement \LaTeX{} perd
le texte des notes dans les environnements {\tt figure} et 
{\tt table}. L'ex\-ten\-sion \FP\ pr\'{e}vient l'utilisateur
que le texte doit \^{e}tre r\'{e}ins\'{e}r\'{e} \`{a} l'aide de \verb|\footnotetext|.

\begin{table}[h]

\SmsG%
\caption[Essai de footnote dans un caption de tableau]
        {L\'{e}gende\protect\footnote{Une note de bas de page.}}
\FmsG%

\begin{center}
\begin{tabular}{|c|}
\hline
\ \hfill \ \\
%\ \\
\ Peu importe le tableau...\\
%\ \\
\ \\
\hline
\end{tabular}
\end{center}
\end{table}
\footnotetext{Une note de bas de page.}

\section{{\mdseries\texttt{\textbackslash caption}} vide}

\begin{table}[h]
\caption{}
\begin{center}
\begin{tabular}{|c|}
\hline
\ \hfill \ \\
%\ \\
\ Tableau sans l\'{e}gende\\
%\ \\
\ \\
\hline
\end{tabular}
\end{center}
\end{table}

\section{\mdseries\texttt{\textbackslash nombre}}

Les nombres en fran\c{c}ais sont imprim\'{e}s correctement lorsque l'on
utilise \verb|\nombre|, ainsi :

\begin{verbatim}
\nombre{123 456,123 456}
\end{verbatim}
imprime \nombre{123 456,123 456} au lieu de la forme habituelle
 {\regularmathcomma $123 456,123 456$}
ou \mbox{123 456,123 456} suivant que l'on est en mode math
ou en mode texte.

On y voit des espaces fines \`{a} chaque millier et (normalement)
une virgule sans espace suppl\'{e}mentaire comme cela se produit
en mode math avec \TeX{} standard.

\section{Autre chose ?}
Non !

[espace libre utilisable]

\newpage\english

\section{Notes within \mdseries\texttt{\textbackslash caption}}

Normally in French we print table's footnotes at the end of the table
but it can't be the case when a footnote is called from a caption title.
But unfortunately footnote's text is lost when inside a \LaTeX{} figure
or table environnement, as shown here.
Thus {\tt french.sty} warn the user with the appropriate message, but
in English nothing is done. 

\begin{table}[h]
\begin{center}
\begin{tabular}{|c|}
\hline
\ \hfill \ \\
%\ \\
\ No matter the table$\ldots{}$\\
%\ \\
\ \\
\hline
\end{tabular}
\end{center}
\caption[footnote try within a table's caption]
        {Caption title\protect\footnote{A footnote page.}}

\end{table}
%\footnotetext{A footnote page.}

\section{Empty \mdseries\texttt{\textbackslash caption}}

\begin{table}[h]
\begin{center}
\begin{tabular}{|c|}
\hline
\ \hfill \ \\
%\ \\
\ Empty caption\\
%\ \\
\ \\
\hline
\end{tabular}
\end{center}
\caption{}
\end{table}

\section{\mdseries\texttt{\textbackslash nombre}}

French number should be correctly printed using
\verb|\nombre|, so :

\begin{verbatim}
\nombre{123 456,123 456}
\end{verbatim}
should not print as usual
$123 456,123 456$ nor \mbox{123 456,123 456}
(depending you are in math or in text mode)
but $123\,456{,}123\,456$.
\NL1

We see here thin spaces between each thousand part and no
(usual) space after the comma (as it is in math with standard
\TeX{}).

\smallskip

\section{Anything else?}

No!

\noindent
[free space to reuse]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newpage\french
\section{Le 1\protect\fup{er} paragraphe}
Notez bien que le 1\fup{er} paragraphe d'une section 
ne commence jamais au fer \`{a} gauche 
en fran\c{c}ais, comme vous le voyez ici.

Le deuxi\`{e}me paragraphe d\'{e}marre comme le premier...\footnote{%
La typographie du titre de section (1\fup{er}) est \`{a} noter ;
 {\tt mysmaller.sty} a \'{e}t\'{e} utilis\'{e} 
\`{a} la compilation de {\tt frenchrf} avec \LaTeX{}. 
Il existe aussi l'extension {\tt relsize} qui fonctionne
bien avec \FP.}

\section{Test des listes}\label{listes}

Voici un test d'\'{e}num\'{e}ration (\verb|itemize|) de \LaTeX{} :

\begin{itemize}
\item liste de niveau 1 ;
      \begin{itemize}
      \item incluant un niveau 2,
            \begin{itemize}
            \item mais aussi un niveau 3,
            \item peu utilis\'{e} ;
            \end{itemize}
      \item le niveau 2 se terminant ici ;
      \end{itemize}
\item suite de la liste de niveau 1 ;
\item dernier \'{e}l\'{e}ment de niveau 1.
\end{itemize}

On remarquera les deux choses suivantes : 
\primo les marqueurs sont identiques quel que soit
le niveau et \secundo aucun \'{e}l\'{e}ment ne commence par une majuscule.
\NL2

\section{D\'{e}finition de langue}

On peut se d\'{e}finir une  langue comme par exemple le kathmandouais par : \\%
\verb|\NouveauLangage[2]|\verb|{kathmandouais}|\\%
\global% for TeX--XeT tests
\def\kathmandouaisTeXmods{\empty}
      \NouveauLangage[2]{kathmandouais} %
et ensuite on peut \'{e}crire kathmandouais en tapant : 
\verb|\kathmandouais|
\SmsG%
\kathmandouais%Message a ignorer si vous n'avez que 2 langues definies.
bla... blabla... bla%
\typeout{I AM WRITING KATMANDOUAIS, Ye\string! (language=\the\language)}%
\FmsG%
\footnote{Mais bien entendu les c\'{e}sures ne seront pas bonnes car elles
seront faites \`{a} partir d'un language existant. On notera la typographie
du num\'{e}ro de cette note saisie en {\em Katmandouais}.}
 et revenir au fran\c{c}ais par
\verb|\french|\french%
\footnote{Si le point qui suit n'est pas accol\'{e} au mot {\tt french}
alors cela signifie que des {\em blank space} tra\^{\i}nent dans 
\FP.}.
S'il n'y a  pas  de commande \verb|\kathmandouaisTeXmods| de d\'{e}finie 
rien ne se passera
vraiment, cela sera \'{e}quivalent \`{a} \verb|\relax|, seul un message 
d'avertissement sera \'{e}mis.

\newpage\english
\section{First paragraph}
In English each paragraph is indented except the first one of a section,
subsection, etc. as you can see in this example.

Subsequent paragraphs start indented$\ldots{}$\NL1 

\section{Itemized lists}
Here is the same  french \verb|itemize| list:\NL1 

\begin{itemize}
\item liste de niveau 1;
      \begin{itemize}
      \item incluant un niveau 2,
            \begin{itemize}
            \item mais aussi un niveau 3,
            \item peu utilis\'{e} ;
            \end{itemize}
      \item le niveau 2 se terminant ici ;
      \end{itemize}
\item suite de la liste de niveau 1 ;
\item dernier \'{e}l\'{e}ment de niveau 1.
\end{itemize}

You can compare english and french lists.
Notice firstly that item markers are identical at each level and secondly
that each item never starts with an uppercase letter.

\section{Create a language}
There is a new control sequence to allow {\em the creation} of new language:\\
\verb|\NouveauLangage[n]{language}|\\
This command is in fact used internally but it can be also used elsewhere 
to define a new language which rules will be set by:\\
 \verb|\<language>TeXmods| (if defined.) The internal language number \verb|n|
tells \TeX{} what hyphenation table is to use among those defined at
\verb|INITEX| time.

\begin{table*}[th]% pour la page suivante
\begin{center}
\fbox{Attention : psfig est p\'{e}rim\'{e} ; il n'est utilis\'{e} ici
      qu'\`{a} des fins de test.}
\end{center}
\end{table*}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newpage\french
\section{Caract\`{e}res actifs}
Quelques jeux de macros doivent parfois \^{e}tre charg\'{e}s 
directement dans le document
et utilisent  les caract\`{e}res {\em actifs\/} de \FP. Il y
a alors conflit ouvert. Plusieurs solutions sont offertes, soit utiliser
l'ordre : \\
\verb|   \originalinput{fichier}|\\
 soit :
\begin{verbatim}
   \begin{nonfrench}
          ... macros-instructions...
   \end{nonfrench}
\end{verbatim}
Nous avons adopt\'{e} la  deuxi\`{e}me solution ici : 

\tthyphenation
\begin{versatim}
Saluons au passage Trevor Darrell, l'auteur de \verb|psfig| :
 \begin{nonfrench}
   \let\psfig\undefined
   \input mypsfig.sty
   \begin{center}
       \ \hbox{\vbox{\psfig{figure=%
          myfigure.ps,height=1in}}}\  
   \end{center}
 \end{nonfrench}
\end{versatim}

Saluons au passage Trevor Darrell, l'auteur de \verb|psfig| :
\begin{nonfrench}
   \let\psfig\undefined
  \input mypsfig.sty
  \begin{center}
       \ \hbox{\vbox{\psfig{figure=%
          myfigure.ps,height=1in}}}\  
  \end{center}
\end{nonfrench}
Mais attention n'utilisez pas en fran\c{c}ais un code que 
vous auriez charg\'{e} 
en anglais ou r\'{e}ciproquement !

En fait, l'extension \FP\ est compatible avec \verb|psfig|.
En voici l'exemple -- sans utiliser \verb|nonfrench| -- avec 
\verb|\psdraft| : 
   \let\psfig\undefined
  \input mypsfig.sty
  \psdraft
  \begin{center}
       \ \hbox{\vbox{\psfig{figure=%
          myfigure.ps,height=1in}}}\  
  \end{center}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newpage\english
\section{Active characters}
Codes that were designed for English might bring problems when used with  
\FP\ because few characters are {\em activated\/}. 
Few solutions are offered, either:\\
\verb|   \originalinput{file}|

or:
\begin{verbatim}
   \begin{nonfrench}
          ... macros-instructions...
   \end{nonfrench}
\end{verbatim}
We used here the second solution:
\begin{verbatim}
Saluons au passage Trevor Darrell, 
           l'auteur de \verb|psfig| :
 \begin{nonfrench}
   \let\psfig\undefined
   \input mypsfig.sty
   \begin{center}
       \ \hbox{\vbox{\psfig{figure=%
          myfigure.ps,height=1in}}}\  
   \end{center}
 \end{nonfrench}
\end{verbatim}

\notthyphenation
Saluons au passage Trevor Darrell, %
           l'auteur de \verb|psfig| :
%\begin{nonfrench}% inutile d'obtenir un message de warning
   \let\psfig\undefined
  \input mypsfig.sty
  \begin{center}
       \ \hbox{\vbox{\psfig{figure=%
          myfigure.ps,height=1in}}}\  
  \end{center}
%\end{nonfrench}
But be carefull, don't use in French a code that was loaded in English
or reciprocally!
\NL1

In fact the \FP\ is fully compatible with \verb|psfig| once
\FP\ starts working i.e. after the 
\vers|\|\vers|begin{document}|.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newpage\french

\section{Abr\'{e}viations}
\abbreviations 
Si on demande \verb|\abbreviations| alors on a  
acc\`{e}s \`{a} un fichier d'abr\'{e}\-via\-tions 
typo\-graphi\-ques fran\c{c}aises. 
Ainsi je saisis \verb|"monseigneur"| et j'imprime "monseigneur"\!.
De m\^{e}me, avec ML\TeX{} je saisis \verb|"deuxi\`{e}me"| 
(v\'{e}rifiez dans le
source que ce mot est bien cod\'{e} en 8bits) et j'imprime "deuxi\`{e}me"\!%
. %alors que le fichier d'abr\'{e}viations contient \verb|"deuxi\`|\verb|eme"|.
Ainsi il n'est plus vraiment indispensable de se rappeler que
l'abr\'{e}viation de madame est "madame" (et ma\^{\i}tre : "ma\^{\i}tre"\!).

Lorsqu'un mot ne figure pas dans le fichier d'abr\'{e}viations, il est alors 
imprim\'{e} tel que. Ainsi \verb|"GUTenberg"| imprimera 
\SmsG%
"GUTenberg".
\FmsG%
 Mais n'oubliez jamais le double guillemet fermant sinon vous obtiendrez
 un message du genre : 
\begin{versatim}
 Paragraph ended before \AbbrevName was complete.
\end{versatim}
 
Je peux aussi donner mon  fichier personnel d'abr\'{e}viations en codant :\\
\verb|\abreviations[mon_fichier_personnel]|

On retire ces possibilit\'{e}s par la commande \verb|\noabbreviations|.
N'oublions pas que le caract\`{e}re \verb|"|  sert normalement en \TeX{} 
comme en \LaTeX{} \`{a} exprimer les nombres en hexad\'{e}cimal.

\section{Monsieur s'abr\`{e}ge "Monsieur"}

Que je saisisse \verb|"Monsieur"| ou \verb|"monsieur"|
j'obtiens la m\^{e}me abr\'{e}viation : "Monsieur" ou "monsieur", respectivement.

Il n'en est pas toujours de m\^{e}me... ainsi lorsqu'on saisit
\verb|"Num\'{e}ro"| et \verb|"num\'{e}ro"| on obtient respectivement : 
"Num\'{e}ro" et "num\'{e}ro", car \verb|Num\'{e}ro|
est une entr\'{e}e dans le fichier des abbr\'{e}viations o\`{u} il est \'{e}crit
\verb|{Num\'{e}ro}|.

Il est d\'{e}sormais possible de placer une abr\'{e}viation dans un titre
de chapitre ou de section, comme le titre de cette section le
d\'{e}montre ; nous avons saisi :
\begin{verbatim} 
\section{Monsieur s'abr\`{e}ge "Monsieur"}
\end{verbatim}

\noabbreviations

\newpage\english

\section{Abbreviations}
The abbreviation facility offered in \FP\ is based on
an abbreviations file. When requested by \verb|\abbreviations| one
may call any \verb|"abbreviation"|. If this abbreviation is found in the
file it will be replaced by the typographic expansion, if not it will
be printed as is.\NL2

But never forget the ending double quotes otherwise you will obtain the
terrible message:
{\tt Paragraph} {\tt ended before} \texttt{\textbackslash AbbrevName} 
{\tt was complete.}
\NL4

You can have your own abbreviations file by calling:
\verb|\abreviations[my_file]|.\NL1

Saying \verb|\noabbreviations| this facility is lost. Remember that the
char \verb|"| is used normally in \TeX{} as in \LaTeX{} to start an
hexadecimal number.

But used in English, \verb|"monsieur"| will give "monsieur"%
\footnote{Notice the quoting!}.

\newpage\french
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\section{Autres macros utiles}
\verb|\fsc{KnUtH}| permet d'imprimer \fsc{KnUtH} et \verb|\lsc{SnCf}| 
donne \lsc{SnCf}. Cela doit aussi marcher si le mot commence par une
accentuation comme ici avec le mot \fsc{\'% a laisser tq a cause du 7bits
epinal} et m\^{e}me quand cette accentuation est plus loin dans
le mot comme ici dans \fsc{ANDR\'% a laisser tq a cause du 7bits
E}.

\bigskip
Voici une note%
\footnote{La note.\label{NOTE}}
de bas de page command\'{e}e par \verb|\footnote{La note.\label{NOTE}}|.
Je peux faire \`{a} nouveau appel \`{a} cette note\refmark{NOTE} 
 par l'ordre \verb|\refmark{NOTE}|.

\bigskip
Par analogie avec l'environnement \verb|verse| :
\begin{verse}
%\moretolerance % pour eviter un leger overfull hbox
1\iere{} ligne : cette ligne est bien trop longue, elle doit \^{e}tre coup\'{e}e autant de fois que n\'{e}cessaire...\\
2\ieme{} ligne : le test terrible de...\\%
3\ieme{} ligne : `ceci est le test des quotes'\\
\end{verse}
\tthyphenation
voici le m\^{e}me test (sans \verb|\\|)
avec l'environnement \vers|versatim| qui est 
un environnement \vers|verba|\-\vers|tim| compos\'{e} 
avec des coupures de lignes
comme l'est l'environnement \verb|verse| et dont les {\em quotes} peuvent
\^{e}tre imprim\'{e}es avec des accents si on pr\'{e}cise 
\vers|\noenglishquote| :
\noenglishquote
\begin{versatim}
1\iere{} ligne : cette ligne est bien trop longue,  elle doit \^{e}tre coup\'{e}e autant de fois que n\'{e}cessaire...
2\ieme{} ligne : le test terrible de \end{document} 
3\ieme{} ligne : `ceci est le test des quotes'
\end{versatim}
\englishquote

\allowuchyph
Et maintenant voici l'ordre r\'{e}duit \verb|\vers| qui 
s'utilise comme \verb|\verb| et doit permettre de couper une
longue cha\^{\i}ne de caract\`{e}res \texttt{ver\-batim}. Celle-ci
sera coup\'{e}e par d\'{e}faut entre les mots (\vers|\notthyphe|\-\vers|nation|)
mais pourra l'\^{e}tre \`{a} l'int\'{e}rieur des mots si on pr\'{e}cise 
\tthyphenation \vers|\tthyphe|\-\vers|nation| comme ici : <<
\vers|Longue Cha\^{\i}ne De Caract\`{e}res \`{A} Couper Absolument| >>.
Les mots commen\c{c}ant en majuscule ne pourront \^{e}tre coup\'{e}s
que si \vers|\uchyph=1|, valeur par d\'{e}faut dans \FP\ 
(\vers|\|\vers|allow|\-\vers|uchyph|) qui est utilis\'{e}e pour cette
partie uniquement.

\subsection*{Test de {\mdseries\texttt{\textbackslash fsc}} 
(\fsc{French CAPS})}
Ce paragraphe teste la protection de certaines macro-instructions.

\disallowuchyph\notthyphenation
\newpage\english
\section{Other useful macros}
French patronymic names are printed in small capitals with the first
letter in uppercase. That is done with the \verb|\fsc| macro.
Another macro \verb|\lsc| is available to print all the word(s) in small
capitals, specially usefull for trademark or companies names.

\LaTeX{} is at the current time unable to print a \verb|\ref| as
a footnotemark, the command \verb|\refmark| is able to do that.

Also, \LaTeX{} doesn't offer any {\tt verbatim} style able to
hyphenate lines. \FP\ is able to do this with the
environment {\tt versatim} or the \texttt{\textbackslash vers} order within a
line.

These environments allow to replace the {\tt tt} quoting
({\tt ` '}) by more realistic ones ({\tt\`{ } \'{ }}) with
the order \texttt{\textbackslash noenglishquote}. Of course this environment
produce nothing different from the standard \verb|verbatim| when 
used in \verb|\english|:
{\overfullrule=5pt

\hfuzz=30pt
\begin{versatim}
1\iere{} ligne : cette ligne est bien trop
2\ieme{} ligne : le test terrible de...
3\ieme{} ligne : `ceci est le test des...
\end{versatim}

\SmsG%

And now this a test of a long string within a \verb|\vers|: 
``\vers|Longue Cha\^{\i}ne De Caract\`{e}res \`{A} Couper A|
This string would be hyphenated only if someone said
\verb|\tthyphenation| previously.
}

\FmsG%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newpage\french
\section{Accents et {\mdseries\tt tabbing}}
\FP\ apporte une solution pour pouvoir introduire
des lettres accentu\'{e}es dans un environnement \vers|tabbing| lorsque
le source \TeX{} est en 7bits ou utilise Ml\TeX{}
\footnote{%
Cette option est aussi utile d\'{e}sormais en T1 car les lettres accentu\'{e}es
sont traduites avec \FP, de fa\c{c}on interne, en 7-bits \`{a} la \TeX.
         }%
 ; c'est l'option par d\'{e}faut 
\vers|\|\vers|tabbing|\-\vers|accents|\tabbingaccents. L'exem\-ple :
\begin{tabbing}
Les TYPES : \=  Les matieres  \= Les genres \kill
Bidon :     \>   d'huile      \>$A'=B''$\` normal \\
Caisse :    \>   \`%
                   a outils     \> rustique \\
Toile :     \>   \a`%
                   a matelas    \> confort  
\end{tabbing}
\notabbingaccents
doit s'imprimer ainsi :
\begin{tabbing}
Les TYPES : \=  Les matieres  \= Les genres \kill
Bidon :     \>   d'huile      \>$A'=B''$\` normal \\
Caisse :    \>\a`a outils     \> rustique \\
Toile :     \>\a`a matelas    \> confort  \\
\end{tabbing}
\vspace*{-0.5\baselineskip}
Nous l'avions saisi comme suit :
\begin{versatim}
\begin{tabbing}
Les TYPES : \=  Les matieres  \= Les genres \kill
Bidon :     \>   d'huile      \>$A'=B''$\` normal \\
Caisse :    \>   \`%
                   a outils     \> rustique \\
Toile :     \>   \a`%
                   a matelas    \> confort  
\end{tabbing}
\end{versatim}

\section{Figurettes}
Le style \verb|french| propose un environnement sp\'{e}cial, appel\'{e} 
\verb|figurette|,
 pour placer les figures \`{a} l'enfroit exact o\`{u} 
ces figures se pr\'{e}sentent
dans le texte. Cela est particuli\`{e}rement utile pour des petites figures,
domaine o\`{u} \LaTeX{} n'est pas adapt\'{e} en standard. 
Pour r\'{e}aliser ceci :
  \begin{figurette}
        \center\fbox{essai}\endcenter% rajoute pour plain TeX
  \caption{Ceci est une figurette}
                 \label{figurette}
  \end{figurette}
Nous avons \'{e}crit :
\begin{verbatim}
  \begin{figurette}
        \center\fbox{essai}
  \caption{Ceci est une figurette}
                 \label{figurette}
  \end{figurette}
\end{verbatim}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newpage\english
\section{Diacritics \& {\mdseries\tt tabbing}}
There is no way in a \LaTeX{} \texttt{tabbing} to put diacritics on letters
as we use them usually. Here is how is printed the {\tt tabbing}
you can find in the french part:

\begin{tabbing}
Les TYPES : \=  Les matieres  \= Les genres \kill
Bidon :     \>   d'huile      \>$A'=B''$\` normal \\
Caisse :    \>   \`%
                   a outils     \> rustique \\
Toile :     \>   \`%
                   a matelas    \> confort  
\end{tabbing}

and that would normally be printed as follows:

\begin{tabbing}
Les TYPES : \=  Les matieres  \= Les genres \kill
Bidon :     \>   d'huile      \>$A'=B''$\` normal \\
Caisse :    \>\a`a outils     \> rustique \\
Toile :     \>\a`a matelas    \> confort  \\
\end{tabbing}

  \begin{figurette}
        \center\fbox{essai}\endcenter% rajoute pour plain TeX
  \caption{Originally a figurette}
        \label{engfig}
  \end{figurette}
\NL{4}

\section{Little figures}

\FP\ offers a special environment called
\verb|figurette| which allows to put little figures EXACTLY
where they appear in the text. This is a lack in the present
versions of \LaTeX{}. In English the environment \verb|figurette|
is replaced by an environment \verb|figure[h]|; look at figure
\ref{engfig} we tried to put here without success and we
typed like this:

\begin{verbatim}
  \begin{figurette}
        \center\fbox{essai}
  \caption{Originally a figurette}
        \label{engfig}
  \end{figurette}
\end{verbatim}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newpage\french
\ifx\drapeaufg\undefined\else
\section{Composition \protect\linebreak en drapeau}
\`{A} gauche on trouve une composition justifi\'{e}e standard \LaTeX.
Dessous, une composition avec l'environnement \texttt{drapeaufg}
propos\'{e} par l'extension \FP, il s'agit d'une composition
\emph{en drapeau, au fer} \`{a} gauche. \`{A} droite, il s'agit aussi d'une
composition \emph{en drapeau, au fer} \`{a} gauche mais cette fois-ci avec
l'environnement \texttt{drapeaufgIN}, sans coupure de mots, comme cela
est recommand\'{e} par l'imprimerie nationale.

\subsection{Tests ordinaires}
\textbf{\large Texte justifi\'{e} de r\'{e}f\'{e}rence}

\medskip
\def\GOfrench{\noindent{\fboxsep 0pt\fboxrule 0.2pt\fbox{\advance\hsize by -2pt
      \hbox{\vbox{\noindent
<< Par ailleurs, les lignes n'occupant pas toute la
  justification (titres ou l\'{e}gendes le plus souvent) peuvent \^{e}tre
  \emph{centr\'{e}es} ou se pr\'{e}senter align\'{e}es verticalement
  par la gauche sur la
  marge de gauche de la page, ou \XX 
  verticalement par la droite sur la marge de
  droite de la page. On dira alors qu'elles sont compos\'{e}es
\emph{en drapeau, au fer} \`{a} gauche ou \emph{en drapeau, au fer} \`{a} droite.
Dans ce type de composition, les coupures de mots sont proscrites et les
rejets \`{a} la ligne devront ob\'{e}ir \`{a} une certaine logique souvent dict\'{e}e par le
sens. Ainsi on ne s\'{e}parera pas l'article du substantif, le pronom personnel
sujet de son verbe, l'adjectif num\'{e}ral du nom auquel il se \XX
rapporte, \etc. >>
(r\`{e}gles Imprimerie Nationale, p~153)%
}}\hss}}}

\let\XX\relax
\GOfrench

\hbox{}

\textbf{\large Drapeau, au fer \`{a} gauche}

\medskip
\begin{drapeaufg}
\GOfrench
\end{drapeaufg}

\newpage
\enlargethispage{20pt}\hbox{}\smallskip

\hbox{}\smallskip\NL5
Dans ce dernier cas, des d\'{e}bordements dans la marge droite
sont possibles ; ils sont \`{a} traiter
au cas par cas par de simples coupures de lignes plac\'{e}es aux endroits
recommand\'{e}s par l'imprimerie nationale (selon texte encadr\'{e}). Le 
dernier texte est ainsi corrig\'{e}.\NL3\vspace*{-2.5pt}

\textbf{\large Drapeau << fg >>, selon IN}

\medskip
\begin{drapeaufgIN}
\GOfrench
\end{drapeaufgIN}

\medskip
\textbf{\large Drapeau << fg IN >>, corrig\'{e}}

\medskip
\let\XX\\
\begin{drapeaufgIN}
\GOfrench
\end{drapeaufgIN}

\newpage
\subsection{Tests en drapeau << fg >>, aux limites}
Voici deux tests aux limites de la composition 
\emph{en drapeau, au fer} \`{a} gauche, sur une colonne
\'{e}troite (2cm) tout d'abord avec l'environnement
\texttt{drapeaufg} et ensuite avec la recommandation
de l'imprimerie nationale appliqu\'{e}e \`{a} 
\FP\ (ou interpr\`{e}t\'{e}e par l'environnement \texttt{drapeaufgIN}).

Les coefficients de laideur (\texttt{badness})
accept\'{e}s sont \'{e}lev\'{e}s, c'est la raison pour laquelle
aucun message d'\texttt{underfull hbox} 
(tout comme celui d'\texttt{overfull}) 
n'est \'{e}mis dans les deux cas
ci-dessous.

\bigskip

\def\temp{\noindent{\fboxsep 0pt\fboxrule 0.2pt\fbox{\advance\hsize by -2pt
      \hbox{\vbox{\noindent
 instit  instits
institut instituts
institution institutions
institutionnel institutionnels
institutionnelle institutionnelles 
institutionnellement
constitutionnellement
inconstitutionnellement
}}\hss}}}

\let\XX\relax
\parbox{2cm}{%
\begin{drapeaufg}
\hsize=2cm
\temp
\end{drapeaufg}
}
\hspace*{0.5cm}
\parbox{2cm}{%
\begin{drapeaufgIN}
\hsize=2cm
\temp
\end{drapeaufgIN}
}

\newpage
\subsection{Tests en drapeau << fd >>, aux limites}
Nous effectuons ici les m\^{e}mes test mais avec
les environnements \texttt{drapeaufd} (fer \`{a} droite)
et \texttt{drapeaufdIN} (selon imprimerie nationale). 
En fait, l'environnement
\texttt{drapeaufd} est tout simplement
un \texttt{raggedleft}.
\NL{9}

\let\XX\relax
\parbox{2cm}{%
\begin{drapeaufd}
%\mbox{Avec \the\rightskip :}
\hsize=2cm
\temp
\end{drapeaufd}
}
\hspace*{0.5cm}
\parbox{2cm}{%
\begin{drapeaufdIN}
%\mbox{Avec \the\rightskip :}
\hsize=2cm
\temp
\end{drapeaufdIN}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newpage
\Large
\let\XX\relax
\subsection{Test << fd >> classique}

\begin{drapeaufd}
\GOfrench
\end{drapeaufd}

\normalsize\bigskip

L'{\oe}il aiguis\'{e} sera troubl\'{e} car
les deux colonnes ne sont pas align\'{e}es horizontalement ;
cela est d\^{u} \`{a} la diff\'{e}rence de mat\'{e}riel \`{a} composer, au total, 
dans chacune des deux colonnes.

\vfill

\newpage
\Large
\subsection{Test << fd >> IN}
\begin{drapeaufdIN}
\GOfrench
\end{drapeaufdIN}

\normalsize\bigskip

Quelque soit le corps de la police (dans les limites
classiques de \LaTeX{}), avec cette largeur de colonne, 
on n'obtient pas de diff\'{e}rence
de mise en page entre les deux environnements. Les r\`{e}gles
de l'imprimerie nationale sont donc plus largement appliqu\'{e}es
dans ce cas.

\vfill
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\onecolumn
\newpage\french
\hbox{}
\vfill
\centerline{\Large Page intentionnellement laiss\'{e}e blanche}
\vfill
\twocolumn

\fi% on a saute si drapeaufg est inconnu (frencht)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newpage\french
\section{Lettrines}
\SmsG% lettrine reduite a 1 seule lettre !
Voici le test des lettrines propos\'{e}es en mode semi-automatique
avec \FP\ :

\bigskip
\verb|                  \flettrine{Quoi ?}|
\flettrine{Quoi ?} {Paris}
{sera toujours Paris}.  Ceci est une lettrine obtenue
gr\^{a}ce au coll\`{e}gue allemand E.~{\sc Scha\-l\"{u}ck} et
 aux diff\'{e}rents codes qu'il
m'a donn\'{e}s.

<< Ici d\'{e}marre une lettrine dans une citation.

\bigskip
\lettrine{Paris}
{sera toujours Paris}.  Ceci est une lettrine obtenue
gr\^{a}ce au coll\`{e}gue allemand E.~{\sc Scha\-l\"{u}ck} et
 aux diff\'{e}rents codes qu'il
m'a donn\'{e}s.

\bigskip
\flettrine{Paris}
{sera toujours Paris}.  Ceci est une lettrine obtenue
gr\^{a}ce au coll\`{e}gue allemand E.~{\sc Scha\-l\"{u}ck} et
 aux diff\'{e}rents codes qu'il
m'a donn\'{e}s.

et la citation se termine ici. >>

\bigskip
\verb|     \font\lettrinefont=cmr17 scaled|\\
{\font\lettrinefont=cmr17 scaled \magstep5
\verb|   \magstep5\lettrine[`` {Paris} '']|
\lettrine[`` {Paris} '']
{sera toujours Paris}.  Ceci est une lettrine obtenue
gr\^{a}ce au coll\`{e}gue allemand E.~{\sc Scha\-l\"{u}ck} et
 aux diff\'{e}rents codes qu'il
m'a donn\'{e}s.\par}

\bigskip
\verb|            \lettrine[<< {Paris} >>]|
\lettrine[<< {Paris} >>]
{sera toujours Paris}.  Ceci est une lettrine obtenue
gr\^{a}ce au coll\`{e}gue allemand E.~{\sc Scha\-l\"{u}ck} et
 aux diff\'{e}rents codes qu'il
m'a donn\'{e}s.

\bigskip
\verb|             \flettrine[<< {Paris} ]|
\flettrine[<< {Paris} ] 
{sera toujours Paris}.  Ceci est une lettrine obtenue
gr\^{a}ce au coll\`{e}gue allemand E.~{\sc Scha\-l\"{u}ck} et
 aux diff\'{e}rents codes qu'il
m'a donn\'{e}s. >>

\bigskip
\tthyphenation\noindent
\vers|\|\vers|font\lettrinefont=cmti12 scaled| \!\vers| \magstep4\lettrine|
{\em \% v\'{e}rification d'italique.}
\font\lettrinefont=cmti12 scaled \magstep4\lettrine
Blalbla {\bf je blablate},  tu blablates,  ils blablatent, b... 
(ceci est l'exemple m\^{e}me de ce qu'il ne faut pas faire car ainsi
le mot n'est pas mis en petites capitales). Ceci avait pour but
de tester une police italique.

\bigskip
\lettrine{L'absurdit\'{e}} de cette lettrine...

\notthyphenation
\FmsG

\newpage\english

\section{Illuminated letters}

Look at the French part of this document because, in English,
these macros have no effect:

\bigskip
\verb|                  \flettrine{Quoi ?}|
\flettrine{Quoi ?} {Paris}
{sera toujours Paris}.  Ceci est une lettrine obtenue
gr\^{a}ce au coll\`{e}gue allemand E.~{\sc Scha\-l\"{u}ck} et
 aux diff\'{e}rents codes qu'il
m'a donn\'{e}s.

<< Ici d\'{e}marre une lettrine dans une citation.

\bigskip
\lettrine{Paris}
{sera toujours Paris}.  Ceci est une lettrine obtenue
gr\^{a}ce au coll\`{e}gue allemand E.~{\sc Scha\-l\"{u}ck} et
 aux diff\'{e}rents codes qu'il
m'a donn\'{e}s.

\bigskip
\flettrine{Paris}
{sera toujours Paris}.  Ceci est une lettrine obtenue
gr\^{a}ce au coll\`{e}gue allemand E.~{\sc Scha\-l\"{u}ck} et
 aux diff\'{e}rents codes qu'il
m'a donn\'{e}s.

et la citation se termine ici. >>

\bigskip
\verb|     \font\lettrinefont=cmr17 scaled|\\
{\font\lettrinefont=cmr17 scaled \magstep5
\verb|   \magstep5\lettrine[`` {Paris} '']|
\lettrine[`` {Paris} '']
{sera toujours Paris}.  Ceci est une lettrine obtenue
gr\^{a}ce au coll\`{e}gue allemand E.~{\sc Scha\-l\"{u}ck} et
 aux diff\'{e}rents codes qu'il
m'a donn\'{e}s.\par}

\bigskip
\verb|            \lettrine[<< {Paris} >>]|
\lettrine[<< {Paris} >>]
{sera toujours Paris}.  Ceci est une lettrine obtenue
gr\^{a}ce au coll\`{e}gue allemand E.~{\sc Scha\-l\"{u}ck} et
 aux diff\'{e}rents codes qu'il
m'a donn\'{e}s.

\bigskip
\verb|             \flettrine[<< {Paris} ]|
\flettrine[<< {Paris} ] 
{sera toujours Paris}.  Ceci est une lettrine obtenue
gr\^{a}ce au coll\`{e}gue allemand E.~{\sc Scha\-l\"{u}ck} et
 aux diff\'{e}rents codes qu'il
m'a donn\'{e}s. >>

\bigskip
\noindent
\verb|\font\lettrinefont=cmti12 scaled| \verb| \magstep4\lettrine|
%{\em \% v\'{e}rification d'italique.}
\font\lettrinefont=cmti12 scaled \magstep4\lettrine
Blalbla {\bf je blablate},  tu blablates, ils blablatent, b... 
(ceci est l'exemple m\^{e}me de ce qu'il ne faut pas faire car ainsi
le mot n'est pas mis en petites capitales). Ceci avait pour but
de tester une police italique.

\bigskip
\lettrine{L'absurdit\'{e}} de cette lettrine...

\onecolumn\newpage%
\french
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  ===>>>> Il n'y a plus d'anglais au del\`{a} de cette limite <<<<===
\def\lastlinein#1{\expandafter\gdef\csname #1\endcsname{\relax}}
\lastlinein{english}% this is for frencht.tex
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newpage\french
\section{Lettrines automatiques ou non}

\bigskip
\lettrine{THIS IS A TEST} (a non-automatic one)
is a piece of text and some more and some more
and some more and some more and some more and some more and some more
and some more and some more and some more and some more and some more
and some more and some more.
                   
\bigskip
\flettrine{THIS IS A TEST} (a non-automatic one)
is a piece of text and some more and some more
and some more and some more and some more and some more and some more
and some more and some more and some more and some more and some more
and some more and some more.

\bigskip
\automaticlettrine
\lettrine{THIS IS A TEST} (a default automatic one)
is a piece of text and some more and some more
and some more and some more and some more and some more and some more
and some more and some more and some more and some more and some more
and some more and some more.

\bigskip
\flettrine{THIS IS A TEST} (a default automatic one)
is a piece of text and some more and some more
and some more and some more and some more and some more and some more
and some more and some more and some more and some more and some more
and some more and some more.


\bigskip
\def\lettrinefontname{cmr17}
\lettrine{THIS IS A TEST} (a cmr17 automatic one)
is a piece of text and some more and some more
and some more and some more and some more and some more and some more
and some more and some more and some more and some more and some more
and some more and some more.

\bigskip
\flettrine{THIS IS A TEST} (a cmr17 automatic one)
is a piece of text and some more and some more
and some more and some more and some more and some more and some more
and some more and some more and some more and some more and some more
and some more and some more.

\bigskip
\lettrine{Que vaut ce test ?} (en automatique)
is a piece of text and some more and some more
and some more and some more and some more and some more and some more
and some more and some more and some more and some more and some more
and some more and some more.

\bigskip
\noautomaticlettrine
\lettrine{THIS IS A TEST} (a non-automatic one)
is a piece of text and some more and some more
and some more and some more and some more and some more and some more
and some more and some more and some more and some more and some more
and some more and some more.
                   
\bigskip
\lettrine{Que vaut ce test ?} (non-automatique)
is a piece of text and some more and some more
and some more and some more and some more and some more and some more
and some more and some more and some more and some more and some more
and some more and some more.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newpage
\section{\'{E}num\'{e}rations}
L'espacement des \'{e}num\'{e}rations fran\c{c}aises est
 profond\'{e}ment modifi\'{e} avec \FP, pour s'en
convaincre voir le test des listes page \pageref{listes} ou
l'environnement \texttt{order} ci-apr\`{e}s.

\section{L'environnement << {\mdseries\texttt{order}} >>}
Un environnement sp\'{e}cifique est propos\'{e}, il s'agit de l'environnement
\verb|order| pour \LaTeX{} dont voici un petit exemple :

\begin{order}
\item Bien regarder ;
\item l'espacement de chaque \'{e}l\'{e}ment est sp\'{e}cial ;
\item l'espacement vertical est aussi diff\'{e}rent.
\item A-D-O-P-T-E-Z \ \ L-E !
\end{order}

Ce prototype correspond bien aux \'{e}num\'{e}rations 
fran\c{c}aises  (je ne
parle pas uniquement des marqueurs  -- primo, secundo, \etc. -- 
mais aussi de la gestion des espaces). En voici un autre exemple
concret :
\NL1

Les guillemets entrent aussi en ligne de compte : << Je citerai
3 cas tr\`{e}s importants :
\begin{order}
\item le premier cas ;
\item le second ;
\item le dernier.
\end{order}
qui sont [...] >>
\NL1

\`{A} noter que ce m\'{e}canisme de rajout des guillemets en d\'{e}but de 
chaque \'{e}l\'{e}ment de liste marche aussi avec un environnement 
comme \texttt{itemize}.

\expandafter\ifx\csname frenchTeXmods\endcsname\relax
            \space% ce test ne marche pas en LaTeX standard.
\else
     \ifx\frenchTeXmods\empty\space% ni en dummy french !
     \else
\section{Tests aux limites des guillemets anglais}

V\'{e}rifions qu'il est possible d'activer temporairement
quelques caract\`{e}res sans perturber le traitement. Exemple :

\begin{verbatim}
{\catcode`\'=\active\catcode`\'=\active
 `` Test guillemets anglais ''
}
\end{verbatim}

{\catcode`\'=\active\catcode`\'=\active
 `` Test guillemets anglais ''
}
     \fi
\fi

Un cas bien sp\'{e}cial avait \'{e}t\'{e} rencontr\'{e} avec l'extension \myverb|amstex|
qui utilisait une r\'{e}f\'{e}rence avec des math\'{e}matiques dans une autre 
r\'{e}f\'{e}rence, ce qui entrainait une boucle infinie avec \FP. Voici 
le test en question : 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% this code generates a loop with versions of french < V3,42 %%%%%%
\makeatletter
\def\r@ref{{\ref{nulllabel}$'$}}{1}
\makeatother
\ref{ref} = 1 $'$ % boucle garantie si < V3,42
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Autre test aux limites ?

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newpage
\section{<< Autres tests >>}
Nous sommes ici en une colonne.

\bigskip
Voici un test d'encadr\'{e} contenant le mode \verb|centering| : 
\begin{center}\fbox{%
\parbox{6cm}{\begin{center}Information : si vous voulez  me joindre,
mon t\'{e}l.  : 01 69 35 85 40. Je n'y suis qu'aux horaires de
bureau.\end{center}}%
     }\end{center}

Bon ?\footnote{L'objet de cette note de bas de page est 
de v\'{e}rifier l'espacement des inf\'{e}rieurs et sup\'{e}rieurs,
\primo en \texttt{\backslash tt} : 
\texttt{XXXX ===> <=== YYYY} et
\secundo en {\tt verbatim} : 
\myverb|french V4 < french V5 > frenchOLD|% 
.}

\begin{table*}[h]
\caption{Dactylographie et typographie compar\'{e}es}
\label{frenchdactylo}
\vspace*{1cm}
\huge
\begin{tabular}{|r|r|}
\hline
dactylographie\ \ \ \ \hfill & \ \ \ typographie\ \ \ \hfill\\
\hline
    \verb|use \dots or \ldots| \ & use \dots\ or $\ldots{}$\ \\
        \verb|utilisez...|     \           & utilisez...\  \\
        \verb|semi-colon;|     \           &  semi-colon;\ \\
        \verb|point-virgule ;| \           & point-virgule ;\  \\
        \verb|My god!|         \           & My god!\ \\
        \verb|Mon dieu !|      \           & Mon Dieu !\ \\
        \verb|Why not?|        \           & Why not?\ \\
        \verb|Pourquoi pas ?|  \           & Pourquoi pas ?\ \\
        \verb|``I say''|       \           & ``I say''\ \\
        \verb|<< Je dis >>|    \           & << Je dis >>\ \\
        \verb|He said: Yes|    \           & He said: Yes\ \\
        \verb|Il dit : non|    \           & Il dit : non\ \\
        \verb|$1\,234,567$|    \           & $1\,234,567$\ \\
        \verb|$f(x,\,y)$|      \           & $f(x,\,y)$\ \\
\hline
\end{tabular}
\normalsize
\end{table*}

\newpage
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ifx\itshape\undefined\else% avoid old frencht crash
\subsection{Test des guillemets dans un \mdseries\texttt{\backslash edef}}

Les guillemets peuvent \^{e}tre appel\'{e}s dans une d\'{e}finition de macro
telle que \verb|\edef| mais comme les guillemets ne sont pas expansibles
enti\`{e}rement il a donc fallu arriver \`{a} r\'{e}aliser une d\'{e}finition acceptable.

Ainsi \verb|\edef\testedef{<< essai >>}|
\edef\testedef{<< essai >>}
donnera la curieuse d\'{e}finition suivante : \\
\hbox{}\hfill\texttt{\meaning\testedef} ; \\
elle reste compl\`{e}tement expansible (dans certaines conditions)
ou pas du tout (comme ici appel\'{e}e en tt on obtiendra 
le r\'{e}sultat suivant : \texttt{\testedef}).
\fi

\subsection{{\mdseries\tt <{}} et {\mdseries\tt >{}} red\'{e}finis}

Mes utilisateurs sont terribles ! Ils veulent le beurre, l'argent du
beurre et aussi la fermi\`{e}re... S'ils codent 
\verb9\def\truc<#1|#2>{/#1 OU #2/}9
 ils veulent pouvoir obtenir
/Essai OU Erreur/ en saisissant \verb9\truc<Essai|Erreur>9. Faisons
l'essai r\'{e}el :
{\def\truc<#1|#2>{/#1 OU #2/} \truc<Essai|Erreur>}.

Encore plus fort : nous voulons avoir une notation de Backus-Naur 
c'est-\`{a}-dire des \verb|\rangle| et \verb|\langle|. Voici la 
d\'{e}finition que nous avons entr\'{e}e avant le \verb|\begin{document}| :
\begin{verbatim}
{\catcode`\<=\active\catcode`\>=\active%
\global\def<{\left\langle}\global\def>{\right\rangle}
}
\end{verbatim}

Pour tester l'efficacit\'{e} de ces macros il suffit alors de faire
par exemple :
\begin{verbatim}
<< $<assignement>$ >>
\end{verbatim}
\`{a} condition que l'option \verb|\frenchguillemets| soit
active (en maths).

Essayons cela : 
% en fait il faut reactiver cela maintenant :
{%
 \gdef\myinf{\left\langle}%
 \gdef\mysup{\right\rangle}%
<< $\frenchguillemets% on a \nofrenchguillemets avec AmSTeX
   <assignement>$ >>.
}%
% Remettre ici pour frenchle
\global\let\myinf\inferieura% A no-op def
\global\let\mysup\superieura% for a temporary action

\subsection{\mdseries\texttt{\textbackslash special}}
L'inclusion d'une commande \verb|\special| est ici test\'{e}e :\\
{%%%%%%%%%%%% attention : commentaires impossible dans cette partie.
 \catcode`\%=12
 \texttt{\backslash special}\verb|{ps:|{\tt %%%
                                     }\verb| Texte bidon {`<<manuel:C;!?>>'}}|
 \special{ps:%%% 
                 Texte bidon {`<<manuel:C;!?>>'}}
}

\subsection{{\mdseries\texttt{\textbackslash refmark}} dans un tableau}

O\`{u} l'on reparle encore de \verb|\refmark|...

La note \ref{bas} est r\'{e}f\'{e}renc\'{e}e depuis le tableau ci-dessous, tout comme
les notes du tableau lui-m\^{e}me.

  \begin{table}[htbp]
    \begin{center}
      \begin{tabular}{|c|l|}
        \hline
        Lettre & Utilisation\\
        \hline
        {\tt h} & petit blabla gentil et anodin \refmark{bas}\\
        {\tt l} & ici reblabla assez moyen\refmark{bas}$^,$\refmark{refnote}\\
        {\tt L} & autre grand grand grand blabla 
                  \footnote{La note du tableau << refmark >>.\label{refnote}}\\
        \hline
      \end{tabular}
      \caption{Le titre du tableau.}
  \end{center}
\end{table}

En dehors du tableau on peut faire appel\footnote{La note de page.\label{bas}}
\`{a} une note qui est, par contre, r\'{e}f\'{e}renc\'{e}e dans le tableau. Tout cela
est r\'{e}alis\'{e} gr\^{a}ce \`{a} l'ordre \verb|\refmark| introduit par l'extension
\FP.

\subsection{{\mdseries\texttt{\textbackslash nombre}} en argument}

Voici un test simple permettant de valider \verb|\nombre| lorsqu'il
est en argument d'une macro-instruction :

\begin{verbatim}
\noindent
1\,234 un nombre simple !\\
$*$\\
\nombre{1 234} un nombre simple !\\
\nombre{1 234,5} avec une d\'{e}cimale.\\
\texttt{\nombre{1 234,56} avec fonte tt.}\\
\emph{\nombre{1 234,567} en mode emphas\'{e}.}\\
\nombre{1 234,567 8} avec encore une d\'{e}cimale.
\end{verbatim}

Il faut noter que l'ordre \verb|\nombre| est toujours compos\'{e} en mode
math\'{e}matique ce qui force l'utilisation des fontes math\'{e}matiques. 
Tout changement de fonte doit donc \^{e}tre pr\'{e}cis\'{e} de fa\c{c}on ad hoc.
Par ailleurs, la composition n'est garantie que si l'option
\verb|\nofiles| n'a pas \'{e}t\'{e} indiqu\'{e}e en d\'{e}but de document.
Voici ce que ce test donne :

\noindent
1\,234 un nombre simple !\\
$*$\\
\nombre{1 234} un nombre simple !\\
\nombre{1 234,5} avec une d\'{e}cimale.\\
\texttt{\nombre{1 234,56} avec fonte tt.}\\
\emph{\nombre{1 234,567} en mode emphas\'{e}.}\\
\nombre{1 234,567 8} avec encore une d\'{e}cimale.

\ifx\documentclass\undefined % Still Plain! so no \DeclareFontFamily
\else%
\subsection{{\mdseries\texttt{\textbackslash label}} en mode math}

Il s'agit ici de tester la commande \verb|\label| dans un environnement
\verb|equation| :

\begin{verbatim}
V\'{e}rifions le num\'{e}ro de l'\'{e}quation \ref{labelequation} ci-dessous :
\begin{equation}\label{labelequation}
V_{Lm}=\frac{L}{t_p}
\end{equation}
\end{verbatim}

Voici le r\'{e}sultat du test :

V\'{e}rifions le num\'{e}ro de l'\'{e}quation \ref{labelequation} ci-dessous :
\begin{equation}\label{labelequation}
V_{Lm}=\frac{L}{t_p}
\end{equation}
\fi

\csname TexteComplementaire\endcsname

\subsection{Bibliographie}
Voyons maintenant la bibliographie.
Dans \cite{`<<manuel:Gaulle;!?>>'} on trouvera...
\nocite{`<<merci:Ronan;!?>>'} 
Par contre  
\cite[pp.1--3, X \& consorts]{<<blabla>>} 
est beaucoup plus fourni en exemples et commentaires... Mais dans 
\cite[p. 25 \S~13 {{\it et seq.}}]{`<<torture:Gaulle;!?>>'} 
toutes ces informations
sont plus d\'{e}taill\'{e}es.

Ce qui suit n'est pas un exemple de belle bibliographie, juste une
v\'{e}rification de bon fonctionnement.

\bibliographystyle{plain}

\begin{thebibliography}{Knuth 99}

\section*{Bibliographie dans le document}

\bibitem[Knuth 99]{<<blabla>>} Le \TeX book ou la  <<  bible >> 
         des gourous \TeX
\bibitem{`<<manuel:Gaulle;!?>>'} B. {\sc Gaulle}, {\em 
         Le r\'{e}sultat d'une << {\em dure} >> journ\'{e}e de travail !}
\bibitem{`<<merci:Ronan;!?>>'} R. {\sc Keryell}, {\em 
         Le gentil normalien qui m'a beaucoup aid\'{e} gr\^{a}ce \`{a} sa th\`{e}se...}
\bibitem{`<<torture:Gaulle;!?>>'} B. {\sc Gaulle}, {\em 
         Notice d'utilisation du style french}, 1991-1999.
\bibitem{`<<tortureFP:Gaulle;!?>>'} B. {\sc Gaulle}, {\em 
         Notice d'utilisation de l'extension \FP\ pour \LaTeX}, 2000-20xx.
\end{thebibliography}

\ifx\documentclass\undefined % Still Plain! so skip
\else%
\section*{\phantom{\normalsize[Knuth 99]}Bibliographie en dehors du document}

Avec certaines extensions de bibliographie il peut s'av\'{e}rer utile
de prot\'{e}ger les caract\`{e}res actifs \`{a} l'int\'{e}rieur m\^{e}me de la base
de donn\'{e}es bibliographique.

\bibliography{testbib}
\fi%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\listoffigures
\listoftables
\glossary{Fa\c{c}on cordon bleu}
\glossaires
\section*{Glossaire des mots techniques}
\printglossary[\jobname.glo]

\noindent -- magnification

\noindent -- caract\`{e}res sp\'{e}ciaux : \NL1

{\huge%\frenchmacros n'est pas utile ici
\begin{tabular}{|c|c|}
\hline
Pour imprimer ceci & Saisir cela\\ \hline
\at                & \verb|\at|\\ \hline
\texttt{\vert}     & \verb|\texttt{\vert}|\\ \hline
\tilde             & \verb|\tilde|\\ \hline
\texttt{\backslash}& \verb|\texttt{\backslash}|\\ \hline
\chap              & \verb|\chap|\\ \hline
\degre             & \verb|\degre| \\ \hline
\degres            & \verb|\degres| \\ \hline
\normalsize
1\ier{} \'{e}tage      & \verb|1\ier{} \'{e}tage| \\ \hline
\normalsize
(2\ieme\!)         & \verb|(2\ieme\!)| \\ \hline
\primo             & \verb|\primo|\\ \hline
\secundo)          & \verb|\secundo)|\\ 
\hline
\end{tabular}
} \NL1

On notera que le caract\`{e}re \verb|\degre| n'est pas le signe typographique
usuellement utilis\'{e} pour exprimer 
des degr\'{e}s mais que \verb|\degres| est
plus conforme \`{a} la tradition. On remarque bien les diff\'{e}rences entre
\verb|\primo| et \verb|\secundo)| 
(la forme parenth\'{e}s\'{e}e n'est pas valable
en {\em belle} typographie fran\c{c}aise).
\primo... \secundo... \tertio... \quarto...
\primo)... \secundo)... \tertio)... \quarto)...

\section*{Glossaire argotique}
Le pied

\printindex

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\part{Ce qui ne marche pas (bien)...}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\chapter{Quelques questions \`{a} \'{e}tudier}

Cette partie ne comporte que des << anomalies >> que l'auteur esp\`{e}re
r\'{e}soudre d'ici quelque temps, 
gr\^{a}ce \`{a} votre aide... peut \^{e}tre ? 

En fait il ne reste vraiment
pas grand chose \`{a} r\`{e}gler mais ce sont probablement des
vieux probl\`{e}mes sacr\'{e}ment compliqu\'{e}s.

\section{Le << 2 points >>}
Le << 2 points >> a une f\^{a}cheuse tendance 
\`{a} rester en bas de page lorsqu'il est
suivi d'un {\tt verbatim}. Il serait souhaitable d'en trouver la raison.

\section{Les guillemets}

Le probl\`{e}me avec \verb|quotation| page \pageref{quotation}.

%Et la perte d'informations
%dans le cas de  \verb|\noeveryparguillemets| lorsque l'on d\'{e}marre
%une citation dans un paragraphe d\'{e}j\`{a} commenc\'{e}.
%
%Vraiment tr\`{e}s {\em fragile} ce \verb|\noeveryparguillemets| ! (

Voir le cas des notes
de bas de page ou en marge qui produis(ai ?)ent des d\'{e}sastres
avec \verb|\noeveryparguillemets|.

\section{Le cas des extensions mal \'{e}crites ...}

... ne se r\'{e}sout souvent que par la modification de l'extension en question.
Cela a \'{e}t\'{e} le cas de nombreuses extensions depuis le d\'{e}but de \FP\ 
et j'ai bien peur que cela continue
\emph{\'{e}ternellement} (et \`{a} propos : qui me succ\`{e}dera ?). 

Certains cas sont insolubles, par exemple : 
l'extension \verb|here.sty| 
red\'{e}finissait << au vol >> 
l'ordre \LaTeX{} \verb|\table| au lieu
de modifier l'existant ; cela posait un r\'{e}el probl\`{e}me \`{a} \FP\ 
qui se base sur la modification d'une commande \verb|\table|
existante. Heureusement ce style p\'{e}rim\'{e} peut \^{e}tre remplac\'{e}
avantageusement par \verb|float|.

\chapter{Am\'{e}liorations \`{a} envisager}

\section{Index et bibliographie}
Deux th\`{e}mes qui n'ont que tr\`{e}s peu \'{e}t\'{e} abord\'{e}s.

\section{Abr\'{e}viations}
Il est f\^{a}cheux d'avoir \`{a} conna\^{\i}tre quelles sont les mots
abr\'{e}geables pour pouvoir demander leur abr\'{e}viation ; autant les saisir
correctement d\`{e}s le d\'{e}but...

Faut-il arr\^{e}ter la composition \LaTeX{} quand une abr\'{e}viation 
n'est pas trouv\'{e}e ? 

Faut-il offrir la possibilit\'{e} de lister toutes les abr\'{e}viations ?

\annexes
\hsize=18cm

\chapter{Copyright}
\Mylisting{copyrigh.tex}

\chapter{Le fichier \mdseries{\tt language.dat}}
\Mylisting{language.dat}

\chapter{Le fichier \mdseries{\tt frabbrev.tex}}
\Mylisting{frabbrev.tex}

% retire pour mettre french.cmd 98/06
%\chapter{Le fichier \mdseries{\tt french.dmy}}
%My\listing{french.dmy}

\chapter{Le fichier \mdseries{\tt french.cmd}}
\Mylisting{french.cmd}

\chapter{Le fichier \mdseries{\tt french.chk}}
\Mylisting{french.chk}

\chapter{Un style english (\mdseries{\tt fenglish})}
\Mylisting{fenglish_doc}

\chapter{Le code de l'extension \FP}

\Mylisting{french_doc}

\newpage
\hsize=15cm
\abbreviations\noenglishdoublequotes
\tableofcontents
\noabbreviations\englishdoublequotes% remove options set for toc.

\english %=\relax if english text (see \lastlinein)
\endinput
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
