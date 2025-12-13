
makebase
========

This is the README.md file for the makebase LaTeX package.

Summary
-------

This package typesets a \LaTeX{} counter such as page in an arbitrary base (default 16). It does not change font or typeface.

The package extends the functionality of the existing hex \LaTeX{}2.09 package and provides documentation. However, the author is not a mathematician, and suggestions for rewriting the code are welcomed.

Warning: this is alpha software and may contain bugs. Please report problems to the author.


Normal installation
-------------------

This package is distributed as a .tds.zip file. TDS is the TeX Directory Structure, the standard layout for a modern TeX installation.

  *  Install it on a TDS-compliant personal system (laptop, desktop, workstation, table, smartphone, PDA, etc) by unzipping it straight into your personal TeX directory (folder). This will put all the files into the right places, so you can start using them immediately.

  *  If you haven't yet created a personal TeX directory, see below for details of what one is, and how to create it.

  *  On a shared (multiuser) system like a server, unzip it into the $TEXMFLOCAL directory instead (see below), and run your TeX directory-indexing program (eg texhash, mktexlsr, Update FNDB, etc) so that everyone can use it.

  *  If you are using an old non-TDS-compliant system, see below under Manual Installation.

### Your personal TeX directory ###

This is a directory (folder) on single-user systems where you should put all your local (manual) modifications, updates, and additions such as new or updated classes, packages, and fonts that are NOT handled automatically by the TeX Live update manager (tlmgr). The name and location are fixed:

<dl>
  <dt>Apple Mac OS X</dt>
  <dd>~/Library/texmf</dd>
  <dt>Unix and GNU/Linux</dt>
  <dd>~/texmf</dd>
  <dt>MS-Windows 95/XP</dt>
  <dd>C:\texmf</dd>
  <dt>MS-Windows 2007 and above</dt>
  <dd>Computer\System\YOURNAME\texmf</dd>
</dl>

Create that folder now if it does not already exist. Put (or unzip) all additions to your system that are not handled by tlmgr into this drectory, following EXACTLY the subdirectory structure that is used in your main TeX distribution. This is what enables LaTeX to find stuff automatically.

> #### If you are a Windows user running MiKTeX ####
> 
> When you create the folder, you must add it to MiKTeX's list of supported folders. Run the MiKTeX Maintenance/Settings program, select the Roots tab, and add the folder. You only have to do this once.
> 
> Each time you add or remove software in your personal TeX folder, you MUST also click on the Update FNDB button in the General tab.
> 

Unix (Mac and GNU/Linux) users do not need to (indeed, should not) run their filename database indexer (mktexlsr or texhash) for files put in your personal TeX directory.

### Installation on shared systems ###

On multi-user systems (Unix-based), identify the shared local directory tree with the command

    kpsewhich -expand-var '$TEXMFLOCAL'

This will give you the location of the shared texmf directory into which you must install these files.

Do not forget to run the texhash or mktexlsr (filename indexer) program after installation, otherwise the files will not be found by LaTeX and nothing will work!


Manual installation (non-TDS systems)
-------------------------------------

To install this software manually, unzip the zip file into a temporary directory and move the makebase.sty file from the tex/latex/makebase directory to a location (directory/folder) where LaTeX will find it on your system. This referred to in some documentation as "the TEXINPUTS directory", although it may be called something else on your system.

IT IS YOUR RESPONSIBILITY TO KNOW WHERE THIS LOCATION IS. See the question in the TeX FAQ at http://www.tex.ac.uk/cgi-bin/texfaq2html?label=inst-wlcf for more information. If you do not know, or cannot find it, or do not have access to it, your TeX system may be out of date need replacing.

### Last resort ###

In an emergency, and as a last resort on unmanageable systems, it is possible simply to put the makebase.sty file in your current working directory (the same folder as your .tex file[s]).

While this may work, it is not supported, and may lead to other resources (packages, fonts, etc) not being found.


Usage
-----

Make this the first line of your LaTeX document:

    \usepackage[options]{makebase}

Read the documentation for the options available. The documentation is distributed as a PDF document in the zip file. You can also regenerate it by typesetting the makebase.dtx file with LaTeX (and BiBTeX and makeindex) in the normal way.


Bugs and TODO
-------------

No outstanding reported bugs at the time of this version.


Copyright
---------

The following statement is included in the source code:

     Extracted from makebase.xml
     makebase.sty is copyright © 2016 by Peter Flynn <peter@silmaril.ie>
    
     This work may be distributed and/or modified under the
     conditions of the LaTeX Project Public License, either
     version 1.3 of this license or (at your option) any later
     version. The latest version of this license is in:
    
         http://www.latex-project.org/lppl.txt
    
     and version 1.3 or later is part of all distributions of
     LaTeX version 2005/12/01 or later.
    
     This work has the LPPL maintenance status `maintained'.
     
     The current maintainer of this work is Peter Flynn <peter@silmaril.ie>
    
     This work consists of the files makebase.dtx and makebase.ins,
     the derived file makebase.sty, and any ancillary files listed
     in the MANIFEST.
    

