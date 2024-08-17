#!/usr/bin/env zsh

[[ $(pacman -Qs kepubify-bin) ]] || paru -S --aur --noconfirm kepubify-bin

for BOOK in $(
  curl --silent https://dieterplex.github.io/rust-ebookshelf/ |
    grep -e '[^"]*.epub' --only-matching
  )
do

  # URI=$(echo $BOOK | jq --raw-input --raw-output '@uri')
  curl --silent \
    "https://dieterplex.github.io/rust-ebookshelf/$BOOK" \
    > "$BOOK"

  # kepubify \
  #   --inplace "$BOOK" \
  #   --css 'code { font-family: Cascadia Code; }' \
  #   > /dev/null
  #
  # cp "$BOOK.kepub.epub" /run/media/$USER/KOBOeReader
  # rm "$BOOK"

done


# curl --silent https://dieterplex.github.io/rust-ebookshelf/ | grep -e '[^<td>][^<]*<a'
#curl --silent https://dieterplex.github.io/rust-ebookshelf/ | grep -e 'epub' | sed 's/<tr><td>[0-9]*<\/td><td>//'
#curl --silent https://dieterplex.github.io/rust-ebookshelf/ | hxnormalize -x | hxselect -c 'tbody tr td:nth-child(2):nth-child(2)' -s '\n'

