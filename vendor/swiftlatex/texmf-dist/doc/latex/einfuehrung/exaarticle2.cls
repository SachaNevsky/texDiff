% $Id: exaarticle2.cls 602 2011-11-28 07:11:34Z herbert $
%%
%% Example class for use with the book examples.
%%
%% Copyright (C) 2009 Herbert Voss
%%
%% It may be distributed and/or modified under the conditions
%% of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%%
%% See http://www.latex-project.org/lppl.txt for details.
%%
%
\RequirePackage{DEoptions}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}
%\RequirePackage{dtklogos}
\let\StartShownPreambleCommands\relax
\let\StopShownPreambleCommands\relax
\endinput

