#!/bin/sh
# makelatex.sh Generate latex from xml and xsl 
# Author:     M.Goossens / IT
# Last mod:   Jan 24 1999

DIR=/afs/cern.ch/project/tex/java
#old CLASSPATH=$DIR/xt.jar:$DIR/xp.jar:$DIR/sax.jar:$CLASSPATH
CLASSPATH=$DIR/xtnew/xt.jar:$DIR/xp.jar:$DIR/xtnew/sax.jar:$CLASSPATH
export CLASSPATH
java com.jclark.xsl.sax.Driver minilatexexa.xml minilatex.xsl \
               | sed  -e 's/&gt;/>/g'\
                      -e 's/&lt;/</g'\
                      -e 's/&amp;/\&/g' > a.tex
utf82latin1.sh a.tex minilatexexa.tex
