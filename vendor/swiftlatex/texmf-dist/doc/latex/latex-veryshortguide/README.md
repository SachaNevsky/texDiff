
#vsg

This is the README.md file for the vsg LaTeX class.

##Summary

This is a document class derived from the original Very Short Guide to LaTeX, a 4pp folder designed as an aide-mémoire for people who have just done a course in LaTeX and need something by them on their desk the next day to refresh their memories. It is __not__ intended as a substitute for full documentation.

This class is designed for this document only, but adds parameterisation to allow reformatting tweaks for different paper sizes (A4 and Legal) to allow it to be printed two-sided as a 4pp folder.

Please do not complain that there is no math here. It won't fit. Someone else can do a math leaflet. IANAM.


##Normal installation

This class is distributed from CTAN in a zip file which allows it to be installed automatically by the TeX Live update manager _tlmgr_ and similar automated installers. If you are using automated package installation, no further action is required.


##TDS installation

This class is also available as a `.tds.zip` file. TDS is the TeX Directory Structure, the standard layout for a modern TeX installation. This enables the class to be unzipped directly into your Personal TeX Directory (see below for what this is and how to create one on your system).

  *  Install it on any TDS-compliant personal system (laptop, desktop, workstation, table, smartphone, PDA, etc) by unzipping it straight into your Personal TeX Directory (folder). This will put all the files into the right places, so you can start using them immediately.

  *  If you haven't yet created a personal TeX directory, see below for details of what one is, and how to create it.

  *  On a shared (multiuser) system like a server, unzip it into the $TEXMFLOCAL directory instead (see below), and run your TeX directory-indexing program (eg _texhash__mktexlsr_, etc) so that everyone can use it.

  *  If you are using an old non-TDS-compliant system, see below under Manual Installation.

###Your Personal TeX Directory

This is a directory (folder) on single-user systems where you should put all your local manual modifications (updates, and additions such as new or updated classes, packages, and fonts) that are __not__ handled automatically by the TeX Live update manager (_tlmgr_). The name and location are fixed:

<dl>
  <dt>Apple Mac OS X</dt>
  <dd>`~/Library/texmf`</dd>
  <dt>Unix and GNU/Linux</dt>
  <dd>`~/texmf`</dd>
  <dt>MS-Windows 95/XP</dt>
  <dd>`C:\texmf`</dd>
  <dt>MS-Windows 2007 and above</dt>
  <dd>`Computer\System\YOURNAME\texmf`</dd>
</dl>

Create that folder now if it does not already exist. Put (or unzip) all additions to your system that are not handled by _tlmgr_ into this directory, following __exactly__ the subdirectory structure that is used in your main TeX distribution (unzipping a TDS file does this for you). This is what enables LaTeX to find stuff automatically.

> #### If you are a Windows user running _MiKTeX_ ####
> 
> When you create the folder, you must add it to _MiKTeX_'s list of supported folders. Run the _MiKTeX Maintenance/Settings_ program, select the `Roots` tab, and add the folder. You only have to do this once.
> 
> Each time you add or remove software in your personal TeX folder, you __must__ also click on the `Update FNDB` button in the `General` tab.
> 

Unix (Mac and GNU/Linux) users do not need to (indeed, should not) run their filename database indexer (_mktexlsr_ or _texhash_) for files put in your personal TeX directory.


##Installation on shared systems

On multi-user systems (Unix-based), identify the shared local directory tree with the command

    kpsewhich -expand-var
          '$TEXMFLOCAL'

This will give you the location of the shared `texmf` directory into which you must install these files.

Do not forget to run the _texhash_ or _mktexlsr_ (filename indexer) program after installation, otherwise the files will not be found by LaTeX and nothing will work!


##Manual installation (non-TDS systems)

To install this software manually, unzip the zip file into a temporary directory and move the `vsg.cls` file from the `tex/latex/veryshortguide` directory to a location (directory/folder) where LaTeX will find it on your system. This is referred to in some documentation as “the TEXINPUTS directory”, although it may be called something else on your system.

__It is your responsibility to know where this location is.__ See the question in the TeX FAQ at http://www.tex.ac.uk/cgi-bin/texfaq2html?label=inst-wlcf for more information. If you do not know, or cannot find it, or do not have access to it, your TeX system may be out of date and need replacing.


##Last resort

In an emergency, or as a last resort on unmanageable systems, it is possible simply to put the `vsg.cls` file in your current working directory (the same folder as your `.tex` file[s]).

While this may work, it is not supported, and may lead to other resources (packages, fonts, etc) not being found.


##Usage

Make this the first line of your LaTeX document:

    \documentclass[options]{vsg}

Read the documentation for the options available. The documentation is distributed as a PDF document in the zip file. You can also regenerate it by typesetting the `vsg.dtx` file with LaTeX (and BibTeX/_biber_ and _makeindex_) in the normal way.


##Bugs and TODO

No outstanding reported bugs at the time of this version.


##Copyright

The following statement is included in the source code:

     Transformed from vsg.xml by ClassPack db2dtx.xsl
     version 16.00 (Makefile with XeLaTeX) on Friday 12 August 2016 at 10:42:12
     vsg.cls is copyright © 2009-2016 by Peter Flynn <peter@silmaril.ie>
    
     This work may be distributed and/or modified under the
     conditions of the LaTeX Project Public License, either
     version 1.3 of this license or (at your option) any later
     version. The latest version of this license is in:
    
         http://www.latex-project.org/lppl.txt
    
     and version 1.3 or later is part of all distributions of
     LaTeX version 2005/12/01 or later.
    
     This work has the LPPL maintenance status `maintained'.
     
     The current maintainer of this work is Peter Flynn <peter@silmaril.ie>
    
     This work consists of the files vsg.dtx and vsg.ins,
     the derived file vsg.cls, and any ancillary files listed
     in the MANIFEST.
    

