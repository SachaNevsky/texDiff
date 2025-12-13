#/bin/bash
# +AMDG

rm *.pfb *.pfa *.afm;
for file in `ls drm*[0-9]*.mf`; do
	mftrace --formats="pfa,pfb,afm" $file;
	./fontconvert.sh ${file%%.*}.pfa;
done;
echo "Verifying conversion of all fonts...";
if [[ `ls drm*[0-9]*.mf | wc -l` == `ls *.pfb | wc -l` ]]; then
	echo "All fonts converted; `ls drm*[0-9]*.mf | wc -l` ";
	echo "Metafonts present, `ls *.pfb | wc -l` Type 1 fonts ";
	echo "present.";
else
	echo "Missed some: `ls drm*[0-9]*.mf | wc -l` Metafont ";
	echo "fonts present, only `ls *.pfb | wc -l` converted.";
	echo "Missing font(s):";
	rm onefile; rm twofile;
	for file in `ls drm*[0-9]*.mf`; do
		echo ${file%%.*} >> onefile;
	done;
	for file in `ls *.pfb`; do
		echo ${file%%.*} >> twofile;
	done;
	echo "\t`diff --suppress-common-lines onefile twofile`";
fi
