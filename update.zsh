#!/usr/bin/env zsh

[[ $(pacman -Qs html-xml-utils) ]] || sudo pacman -S --noconfirm html-xml-utils
[[ $(pacman -Qs kepubify-bin) ]] || paru -S --aur --noconfirm kepubify-bin

URL='https://dieterplex.github.io/rust-ebookshelf/'
KOBO="/run/media/$USER/KOBOeReader"

HTML=$(curl --silent $URL | hxnormalize -x -l 256)
BOOKS=$(
  echo $HTML |
    hxselect -s '\n' -c 'tbody tr td:nth-child(2)' |
    sed 's/ <.*//')
# LINKS=$(
#   echo $HTML |
#     hxselect -s '\n' -c 'tbody tr td:nth-child(3)' | 
#     sed 's/[^"]*"//' | sed 's/.epub.*//')

echo $BOOKS | while read -r BOOK; do

  LINK=$(echo $BOOK | jq --raw-input --raw-output '@uri')
  curl --silent "$URL$LINK.epub" > "$BOOK.epub"

  kepubify \
    --inplace "$BOOK.epub" \
    --css 'code { font-family: Cascadia Code; }' \
    > /dev/null
  rm "$BOOK.epub"
  
  [[ -d $KOBO ]] && cp "$BOOK.kepub.epub" $KOBO 

done

