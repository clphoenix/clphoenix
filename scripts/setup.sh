#!/bin/bash

git config --local core.hooksPath scripts/

if [[ "$OSTYPE" == "darwin"* ]]; then
    brew install basictex entr imagemagick poppler
    sudo tlmgr update --self
    sudo tlmgr install textpos biblatex xecjk
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    sudo apt install texlive-full fontconfig
    fc-cache
    sudo mktexlsr
else
    echo "Unsupported operating system: $OSTYPE"
    exit 1
fi
