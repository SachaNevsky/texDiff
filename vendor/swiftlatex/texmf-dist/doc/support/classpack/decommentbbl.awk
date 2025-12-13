# decommentbbl.awk
#
# This awk(1) script catenates consecutive lines of a BiBTeX-produced
# .bbl file which end in a comment character (removing the comment
# character in the process) because the default % comment character
# gets misinterpreted by the ltxdoc package when building class or
# package files.
#
# Copyright © 2008-2012 Silmaril Consultants 
# Available under the terms of the LaTeX Project Public License
# as part of the classpack development package
# Peter Flynn <peter@silmaril.ie> 2010-10-14
#
######################################################################
#
# Read every line of the file into an array

{
    line[NR]=$0;
} 

######################################################################
#
# At the end, go through the array; if a line ends with a % sign,
# catenate it to the buffer, omitting the percent sign itself;
# otherwise, output the buffer and zero it for further use.

END {
    for(i=1;i<=NR;++i) {
	if(substr(line[i],length(line[i]))=="%") {
	    buffer=buffer substr(line[i],1,length(line[i])-1);
	} else {
	    print buffer line[i];buffer="";
	}
    }
}

