#! /usr/bin/env bash

# TODO: rewrite me in python

files=( .bash_profile .bashrc .gitconfig .ideavimrc .inputrc .tmux.conf .vimrc )

for file in "${files[@]}"; do
  d="$(diff $file "$HOME/$file")"
  if [[ "$d" ]]; then
    echo "changes in $file ($(pwd) -> $HOME)"
    echo "$d"
    altered=true
  fi
done

if [[ ! "$altered" ]]; then
  echo "up to date"
fi
