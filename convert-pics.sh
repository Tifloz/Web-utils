#!/usr/bin/env bash

for filename in "$1"/*png ; do
    name=${filename##*/}
    base=${name%.png}
    convert "$filename" -fill black -colorize 50% "$1"/tmp.png
    cwebp -q 80 -quiet "$1"/tmp.png -o "$1/$base-2x.webp"
    convert "$filename" -fill black -colorize 50% "$1/$base-2x.jpg"
    convert "$filename" -fill black -colorize 50% -resize 1920x400 "$1"/tmp.png
    cwebp -q 80 -quiet "$1"/tmp.png -o "$1/$base.webp"
    convert "$filename" -resize 1920x400 -fill black -colorize 50% "$1/$base.jpg"
    rm "$1"/tmp.png
done