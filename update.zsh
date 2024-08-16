#!/usr/bin/env zsh

[[ $(pacman -Qs kepubify-bin) ]] || paru -S --aur --noconfirm kepubify-bin

for BOOK in \
  'Asynchronous Programming in Rust' \
  'Async programming in Rust with async-std' \
  'Command Line Applications in Rust' \
  'Comprehensive Rust 🦀' \
  'CXX-Qt Documentation' \
  'CXX Documentation' \
  'FLTK-rs Book.epub' \
  'Learning Rust With Entirely Too Many Linked Lists' \
  'mdBook Documentation' \
  'Rust and WebAssembly' \
  'Rust API Guidelines' \
  'Rust By Example' \
  'Rust Compiler Development Guide' \
  'Rust Cookbook' \
  'Rust Design Patterns' \
  'The Cargo Book' \
  'The Embedded Rust Book' \
  'The Little Book of Rust Macros' \
  'The Rustdoc Book' \
  'The Rust Edition Guide' \
  'The Rust on ESP Book' \
  'The Rustonomicon' \
  'The Rust Performance Book' \
  'The Rust Programming Language' \
  'The Rust Reference'
do

  URI=$(echo $BOOK | jq --raw-input --raw-output '@uri')
  curl --silent \
    "https://dieterplex.github.io/rust-ebookshelf/$URI.epub" \
    > "$BOOK.epub"

  kepubify \
    --inplace "$BOOK.epub" \
    --css 'code { font-family: Cascadia Code; }' \
    > /dev/null

  cp "$BOOK.kepub.epub" /run/media/$USER/KOBOeReader
  rm "$BOOK.epub"

done

