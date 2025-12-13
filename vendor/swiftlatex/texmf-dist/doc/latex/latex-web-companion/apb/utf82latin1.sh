#!/bin/sh
# xt.sh       Script to run file through J. Clark's XT XSL processor
# Author:     M.Goossens / IT
# Last mod:   Jan 16 1999

Name=`basename $0`
Usage="Usage: $Name UTF8-file Latin1-file"

if [ $# -lt 2 ]; then          # too few parameters
     echo $Usage >&2           # display error message
     exit 1                    # abort
fi

DIR=/afs/cern.ch/project/tex/java/michel
CLASSPATH=$DIR:$CLASSPATH

echo "The CLASSPATH is set to:"
echo $CLASSPATH
echo " "

export CLASSPATH

java utf8tolatin1 $1 $2

