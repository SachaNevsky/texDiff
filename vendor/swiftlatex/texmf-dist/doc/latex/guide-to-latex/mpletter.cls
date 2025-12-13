% MPLETTER.CLS as taken out of gtl-letters.tex 4th edition
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mpletter}
\RequirePackage{ifthen}
\newboolean{@german}
\setboolean{@german}{false}
\DeclareOption{german}{\setboolean{@german}{true}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{letter}}
\ProcessOptions
\LoadClass[a4paper]{letter}
\newcommand{\englishnames}{%
 \newcommand{\yrefname}{\textsl{Your Ref.}}
 \newcommand{\ymailname}{\textsl{Your letter from}}
 \newcommand{\myrefname}{\textsl{Our Ref.}}
 \newcommand{\subjectname}{\textsl{Subject}}
 \newcommand{\telephonename}{Telephone}
 \newcommand{\stationname}{Train Station}
 \newcommand{\germanname}{GERMANY}
 \newcommand{\telcode}{[49]-5556-401}
 \newcommand{\postcode}{D--37191}
}

\newcommand{\germannames}{%
%. . . . . . . . . . . . . . . . . . . . .
 \newcommand{\telcode}{(05556) 401}
 \newcommand{\postcode}{37191}
}

\ifthenelse{\boolean{@german}}
  {\RequirePackage{german}\germannames}{\englishnames}
\newcommand{\@yref}{}     \newcommand{\@ymail}{}
\newcommand{\@myref}{}    \newcommand{\@subject}{}
\newcommand{\@internet}{}

\newcommand{\yref}[1]{\renewcommand{\@yref}{\yrefname: #1}}
\newcommand{\ymail}[1]{\renewcommand{\@ymail}{\ymailname: #1}}
\newcommand{\myref}[1]{\renewcommand{\@myref}{\myrefname: #1}}
\newcommand{\subject}[1]{\renewcommand{\@subject}
                           {\subjectname: #1}}
\newcommand{\internet}[1]{\renewcommand{\@internet}{#1}}
\newcommand{\INTERNET}{@linmpi.mpg.de}
\setlength{\textheight}{215mm}  \setlength{\textwidth}{160mm}
\setlength{\oddsidemargin}{0pt} \setlength{\evensidemargin}{0pt}
\setlength{\topmargin}{-20pt}   \setlength{\headheight}{12pt}
\setlength{\headsep}{35pt}
\DeclareFixedFont{\xviisf}{OT1}{cmss}{m}{n}{17}
\DeclareFixedFont{\xsf}{OT1}{cmss}{m}{n}{10}
\DeclareFixedFont{\viiisf}{OT1}{cmss}{m}{n}{8}
\newlength{\leftfield}    \setlength{\leftfield}{117mm}
\newlength{\rightfield}   \setlength{\rightfield}{43mm}
\newsavebox{\FIRM}       \newsavebox{\firmaddress}
\newsavebox{\firm}       \newsavebox{\firmreturn}

\sbox{\FIRM}
  {\parbox[t]{\leftfield}
       {\xviisf MAX--PLANCK--INSTITUT F\"UR AERONOMIE}}

\sbox{\firm}
  {\xsf MAX--PLANCK--INSTITUT F\"UR AERONOMIE}

\sbox{\firmreturn}
  {\viiisf\underline{MPI f\"ur Aeronomie,
                     \postcode{} Katlenburg--Lindau}}

\sbox{\firmaddress}
  {\parbox[t]{\rightfield}{\viiisf\baselineskip10pt
    Max--Planck--Stra{\ss}e 2\\
    \postcode{} Katlenburg--Lindau\\\germanname}}
\newsavebox{\firmhead}   \newsavebox{\firmfoot}

\sbox{\firmhead}
  {\parbox{\textwidth}{\usebox{\FIRM}\raisebox{6pt}
     {\usebox{\firmaddress}}\\[3pt] \rule{\textwidth}{1pt}}}

\sbox{\firmfoot}
  {\parbox{\textwidth}{\rule{\textwidth}{0.6pt}\\[5pt]
     \viiisf\setlength{\baselineskip}{12pt}%
    \begin{tabular}[t]{@{}ll}
       \underline{\telephonename}  & \telcode-1\\
       \underline{Telefax}         & \telcode-240\\
       \underline{Telex}           & 9\,65\,527 aerli
    \end{tabular}\hfill
    \begin{tabular}[t]{l}
       \underline{Bank}\\
       Kreis--Sparkasse Northeim\\
       41\,104\,449 (BLZ 262\,500\,01)
    \end{tabular}\hfill
    \begin{tabular}[t]{l@{}}
       \underline{\stationname}\\
       Northeim\\
       (Han.)
    \end{tabular} }}
\renewcommand{\ps@firstpage}
  {\setlength{\headheight}{41pt}\setlength{\headsep}{25pt}%
   \renewcommand{\@oddhead}{\usebox{\firmhead}}%
   \renewcommand{\@oddfoot}{\raisebox{-20pt}[0pt]
                             {\usebox{\firmfoot}}}%
   \renewcommand{\@evenhead}{}\renewcommand{\@evenfoot}{}}
\renewcommand{\ps@headings}
   {\setlength{\headheight}{41pt}%
    \renewcommand{\@oddhead}
       {\parbox{\textwidth}{\usebox{\firm}\\[5pt]
          \slshape \headtoname{} \toname\hfill\@date\hfill
                                     \pagename{} \thepage\\
          \rule[3pt]{\textwidth}{1pt}}}
    \renewcommand{\@oddfoot}{}
    \renewcommand{\@evenhead}{\@oddhead}
    \renewcommand{\@evenfoot}{\@oddfoot}}
\providecommand{\@evenhead}{}\providecommand{\@oddhead}{}
\providecommand{\@evenfoot}{}\providecommand{\@oddfoot}{}
\pagestyle{headings}
\renewcommand{\opening}[1]{\thispagestyle{firstpage}%
  \parbox[t]{\leftfield}
     {\usebox{\firmreturn}\\
      \parbox[b][3.5cm][c]{\leftfield}{\toname\\\toaddress}}%
  \parbox[t]{\rightfield}
     {\fromname
      \ifthenelse{\equal{\telephonenum}{}}
         {}{\\ Tel.: \telcode-\telephonenum}
      \ifthenelse{\equal{\@internet}{}}
         {}{\\{\viiisf Email: \@internet\INTERNET}}
      \\[5mm] \@date}
  \par
  \rule{\textwidth}{0.6pt}
  \makebox[\leftfield][l]
     {\ifthenelse{\equal{\@yref}{}}
        {\@ymail}{\@yref\hfill\@ymail\hfill}}
  \@myref\par
  \ifthenelse{\equal{\@subject}{}}
     {}{\@subject\par}
  \vspace{2\parskip} #1 \par\nobreak}
