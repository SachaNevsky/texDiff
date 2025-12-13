#!/bin/bash

srcmain="exfserm"
srcsec="exfser"
trglist=(Problems Solutions)
trgsol=(n y)
secnum="01 02 03 aa"

if [ -z $1 ]
then
  echo "Usage:
  $0 number [version]
    number: number of sheet, 0 for combined document
    version: 0 for problems, 1 for solutions
  $0 filename
    filename: target file to be compiled"
  exit 1
fi

num="$1"
ver="$2"
nl=$'\n'
secokay=""
make=".pdf"

for v in "${trglist[@]}"
do
  if [[ $num =~ ^$v ]]
  then
    ver=$v
    num=${num#$v}
    if [[ $num =~ ^.*\.tex$ ]]; then make=".tex"; fi
    num=${num%%.*}
  fi
done

if [[ $num =~ ^[0-9]$ ]]; then num="0$num"; fi
if [[ $num == "00" ]]; then num=""; fi

if [[ -z $num ]]; then secokay="okay"; fi
for v in $secnum
do
  if [[ "$num" == "$v" ]]; then secokay="okay"; fi
done

if [[ -z $secokay ]]
then
  echo "error: unknown sheet"
  exit 1
fi

if [[ "$make" == ".pdf" ]]; then nl=""; fi

function docompile
{
  if [[ -z $num ]]
  then
    job="$srcmain"
    fwd="\\childdocforward{$srcmain}"
  else
    job="$srcsec$num"
    fwd="\\childdocforward[$srcmain]{$srcsec$num}"
  fi
  body="\\def\\jobname{$job}$optdef\\input{childdoc.def}$fwd"
  for pass in first main extra
  do
    par="";
    if [[ "$pass" == "first" ]]; then par="-draftmode"; fi
    drop="This is|entering extended mode|\\write18"
    drop="$drop|Preloading the plain mem file|mpost\.mp|plain\.mp"
    pdflatex -shell-escape -interaction=batchmode $par \
      -jobname "$trg" "$body" | grep -vE "$drop"
    if [[ "$pass" != "main" ]]; then continue; fi
    if ! (grep -E -q "may have changed|rerunfilecheck Warning" "$trg.log")
      then break; fi
  done
  grep -E "^! |Warning|Error|Undefined|Overfull|Underfull" "$trg.log"
}

function writesource
{
  if [[ -z $num ]]
  then
    fwd="\\childdocforward{$srcmain}"
  else
    fwd="\\childdocforwardprefix[$srcmain]{$target}{$srcsec}"
  fi
  body="$optdef\\input{childdoc.def}$nl$fwd"
  echo "$body" > $trg.tex
}

for i in "${!trglist[@]}"
do
  if [[ -z $ver || "$ver" == "${trglist[$i]}" || $ver = $i ]]
  then
    target="${trglist[$i]}"
    sol="${trgsol[$i]}"
    trg="$target$num"
    optdef="\\def\\draftver{n}$nl\\def\\printsol{$sol}$nl"
    if [[ "$make" == ".pdf" ]]; then docompile; else writesource; fi
  fi
done

echo
