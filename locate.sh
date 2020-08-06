#!/bin/bash

function confirm() {
  while true; do
    read answer </dev/tty
    case $answer in
      [yY]) return 0;;
      [nN]) return 1;;
      *) echo "Please type 'y' or 'n'"
         confirm
         return;;
    esac
  done
}

function replace_link() {
  local referer=$1
  local link=$2

  echo "'$link' already exists."
  echo "Want to replace?(y/n)"
  confirm
  if [ $? -eq 0 ]; then
    mv $HOME/$link $HOME/$link.backup
    ln -s $cPath/$referer $HOME/$link
    if [ $? -eq 0 ]; then
      rm -f $HOME/$link.backup
      echo "[Replaced]: $link"
    else
      mv $HOME/$link.backup $HOME/$link
      echo "[Failed]"
    fi
  else
    echo "[Ignored]: $link"
  fi
  echo
}

function create_link() {
  local name=$1

  ln -s $cPath/$name $HOME/$name
  if [ $? -eq 0 ]; then
    echo "[Created]: $name"
  else
    echo "[Failed]"
  fi
  echo
}

function place_dotfiles() {
  echo "*** Placing Dotfiles ***"
  echo
  cPath=$PWD
  cat $DOT_FILES | while read file; do
    if [ $file = ".vimperator" -a "`echo ${OSTYPE} | grep "msys"`" != "" ]; then
      if [ -e $HOME/vimperator ]; then
        replace_link $file "vimperator"
      else
        create_link $file
        mv $HOME/.vimperator $HOME/vimperator
      fi
      continue
    fi

    if [ -e $HOME/$file ]; then
      replace_link $file $file
    else
      create_link $file
    fi
  done
}

function main() {
  case "${OSTYPE}" in
    msys*)
      DOT_FILES=windows.dotfiles;;
    darwin*)
      DOT_FILES=mac.dotfiles;;
    linux*)
      DOT_FILES=linux.dotfiles;;
  esac

  place_dotfiles
}

main
