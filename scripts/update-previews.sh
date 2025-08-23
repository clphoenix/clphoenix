#!/bin/bash

cp .build/*.pdf ./

# Using pdftoppm (from poppler-utils) + ImageMagick
pdftoppm -png -r 600 bio.pdf .build/bio_tmp
for page in .build/bio_tmp-*.png; do
    if [[ -f "$page" ]]; then
        base=$(basename "$page" .png)
        magick "$page" -colorspace sRGB -alpha opaque -resize 50% "${base/bio_tmp/bio}.png"
    fi
done
rm .build/bio_tmp-*.png
