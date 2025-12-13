%
% $Id: exapd.cls 631 2012-01-21 18:35:47Z herbert $
%
%%
%% The LaTeX Companion, 2ed
%%
%% Example ``powerdot like'' class for use with the book examples.
%%
%% Copyright (C) 2009 Niedernair/Voss
%%
%% It may be distributed and/or modified under the conditions
%% of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%%
%% See http://www.latex-project.org/lppl.txt for details.
%%
%
\RequirePackage{DEoptions}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{powerdot}}
\ProcessOptions\relax
\LoadClass{powerdot}
\RequirePackage[T1]{fontenc}
\input{exa-fontconfig}



% ignore second documentclass command for display in book:

\renewcommand\documentclass[2][]{}

\endinput 

