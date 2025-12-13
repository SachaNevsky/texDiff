% 
% This class file is used to typeset the examples of the LaTeX Graphics
% Companion. It works without changes if you happen to use dvips as a
% printer driver. Otherwise you might need to update it as outlined
% below. 
% 
% Basic class is article

\LoadClass{article}

% We use Times and Helvetica for \rmfamily and \sffamily
% 
\renewcommand\rmdefault{ptm}
\renewcommand\sfdefault{phv}
\renewcommand\bfdefault{b}

% That is default anyway
% 
\setlength\paperheight {11in}
\setlength\paperwidth  {8.5in}

% [FMi: why do you need this Sebastian? ]
% 
\special{papersize=8.5in,11in}

\RequirePackage[T1]{fontenc}

% We wanted to use PS when producing LaTeX pictures but it should be
% possible to comment this line out without any changes to the result
% 
\RequirePackage{pspicture}



\newcommand\gobblepreamble[2][]{}
\newcommand\ResetPreambleCommands{\let\usepackage\gobblepreamble}
\let\ReadyForTheFray\relax



%FMi the below is plain wrong :-)
%\makeatletter
\newdimen\fullwidth
\setlength\textwidth{29pc}
\addtolength\textwidth{-2pt} % to guard against rounding errors when
                             % calculating the EPS bounding box.
\setlength\fullwidth{35.5pc}


% [FMi why this? ]

\let\bf\bfseries
\let\tt\ttfamily
\let\it\itshape
\let\sf\sffamily
\let\rm\mdseries

\endinput

