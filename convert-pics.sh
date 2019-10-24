#!/usr/bin/env bash

# mobile : 1024px
# tablet : 1300px
# desktop : 1920px

# retina : 2x

SIZES[0]="1024"
SIZES[1]="1300"
SIZES[2]="1920"

for i in "${SIZES[@]}"; do
  if [ "$i" == "1024" ]; then
    mkdir """$1""/mobile"
    currentdir="""$1""/mobile"
  fi
  if [ "$i" == "1300" ]; then
    mkdir """$1""/tablet"
    currentdir="""$1""/tablet"
  fi
  if [ "$i" == "1920" ]; then
    mkdir """$1""/desktop"
    currentdir="""$1""/desktop"
  fi
  for filename in "$1"/*png; do
    name=${filename##*/}

    if [ "$name" != "tmp.png" ]; then
      base=${name%.png}
      convert -monitor "$filename" "$1"/tmp.png
      cwebp -q 80 -quiet "$1"/tmp.png -o "$currentdir/$base-2x.webp"
      convert -monitor "$filename" "$currentdir/$base-2x.jpg"
      convert -monitor "$filename" -resize ${i} "$1"/tmp.png
      cwebp -q 80 -quiet "$1"/tmp.png -o "$currentdir/$base.webp"
      convert -monitor "$filename" -resize ${i} "$currentdir/$base.jpg"
    fi
  done
done
rm "$1"/tmp.png
