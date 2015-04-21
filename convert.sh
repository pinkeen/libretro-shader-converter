#!/usr/bin/env bash

function convert() {
  
    src="$1"
    rel="${1#$srcdir}"
    pth="${dstdir}${rel}"
    dst="${pth%$2}$3";
    
    mkdir -p "$(dirname $dst)"
    
    echo "Converting $src --> $dst" | tee -a $logfile
    cg2glsl "$src" "$dst" 2>&1 >> $logfile
    
    if [ $? -eq 0 ]; then
        echo -e "\tOK"
    else
        echo -e "\tFAIL"
        echo "$dst" >> $failfile
    fi
}

srcdir="cg/"
dstdir="glsl/"

logfile="convert.log"
failfile="${dstdir}/failed.log"

cd cg 
git pull
echo `git log --pretty=format:"[%cd] %h %s" -1` > "../${dstdir}/REV"
cd ..

echo '' > $logfile
echo '' > $failfile

find "$srcdir" -iname '*.cg' | while read src ; do
  convert "$src" cg glsl
done

find "$srcdir" -iname '*.cgp' | while read src ; do
  convert "$src" cgp glslp
done
