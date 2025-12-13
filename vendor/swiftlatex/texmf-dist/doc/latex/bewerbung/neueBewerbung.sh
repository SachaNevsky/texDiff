%% zusätzliche
%% Farbdefinitionen:
#!/bin/bash
mkdir -v $1
cp -v bewerbung.tex $1/bewerbung-$1.tex
cp -v config.inc $1
cd $1
ln -sv ../Anhang ./Anhang
ln -sv ../Foto.jpg ./Foto.jpg
ln -sv ../Foto.pdf ./Foto.pdf
ln -sv ../anschrift.csv ./anschrift.csv
cd ..
