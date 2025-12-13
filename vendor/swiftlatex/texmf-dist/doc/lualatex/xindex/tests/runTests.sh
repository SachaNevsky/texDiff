#!/bin/sh
echo "buch"
xindex buch > /dev/null
lualatex buch > /dev/null

echo "demo"
lualatex demo > /dev/null
xindex -l de demo > /dev/null
lualatex demo > /dev/null

echo "demo2"
xindex demo2 > /dev/null

echo "demo3"
lualatex demo3 > /dev/null
xindex -l de demo3 > /dev/null
lualatex demo3 > /dev/null

echo "demo-hyperref"
xindex demo-hyperref > /dev/null
lualatex demo-hyperref > /dev/null

echo "HADW"
xindex -l de -c HAdW-eKO HADW > /dev/null
lualatex HADW > /dev/null

echo "Umlaute"
xindex -l de Umlaute  > /dev/null
lualatex Umlaute > /dev/null

echo "Umlaute2"
xindex -l de -c DIN2 Umlaute2 > /dev/null
lualatex Umlaute2 > /dev/null

rm -fr *.aux *.log *.ilg *.out