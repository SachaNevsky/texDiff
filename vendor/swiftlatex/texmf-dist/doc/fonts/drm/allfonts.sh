#!/bin/bash
# +AMDG

for file in `ls drm*[0-9]*.mf`; do
	echo "Compiling $file...";
	mf -halt-on-error "\mode=localfont; input $file" &> /dev/null;
	if [[ $? == 0 ]]; then
		echo "$file successfully compiled!";
	else
		echo "FAIL:  $file failed to compile!"
		exit 1;
	fi
done
echo "Massive winnage!"
