#!/bin/bash

git config --local core.hooksPath scripts/

file=${1:-bio}
echo "Monitoring $file"

if [[ "$OSTYPE" == "darwin"* ]]; then
    ls -1 $file.tex *.cls | entr bash -c "./$file.tex && open $file.pdf"
else
    echo "Unsupported operating system: $OSTYPE"
    exit 1
fi
