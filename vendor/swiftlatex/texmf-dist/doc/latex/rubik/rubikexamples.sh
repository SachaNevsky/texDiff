
## rubikexamples.sh
## Rubik bundle v5.0, 2018
## run twice to get hyperref links correct

 pdflatex  --shell-escape  rubikexamples.tex
 pdflatex  --shell-escape  rubikexamples.tex

## echo "...checking error file" 
## grep ERROR  ./rubikstateERRORS.dat
