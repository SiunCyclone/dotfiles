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
      echo "[Replaced] $link"
    else
      mv $HOME/$link.backup $HOME/$link
      echo "[Failed]"
    fi
  else
    echo "[Ignored] $link"
  fi
  echo
}

function create_link() {
  local name=$1

  ln -s $cPath/$name $HOME/$name
  if [ $? -eq 0 ]; then
    echo "[Created] $name"
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

function replace_file_to_hardlink() {
  local targetFile=$1

  echo "'$targetFile' already exists."
  echo "Can I DELETE it?(y/n)"
  confirm
  if [ $? -eq 0 ]; then
    mv "$VSCODE_PATH"/$targetFile "$VSCODE_PATH"/$targetFile.backup
    ln vscode/$targetFile "$VSCODE_PATH"/$targetFile
    if [ $? -eq 0 ]; then
      rm "$VSCODE_PATH"/$targetFile.backup
      echo "[Created] $targetFile"
    else
      mv "$VSCODE_PATH"/$targetFile.backup "$VSCODE_PATH"/$targetFile
      echo "[Failed]"
    fi
  else
    echo "[Ignored] $targetFile"
  fi
}

function create_hardlink() {
  local targetFile=$1

  ln vscode/$targetFile "$VSCODE_PATH"/$targetFile
  if [ $? -eq 0 ]; then
    echo "[Created] $targetFile"
  else
    echo "[Failed]"
  fi
}

function create_vscode_hardlink() {
  echo "*** Creating VSCode settings hard link ***"
  echo "VSCODE_PATH: $VSCODE_PATH"
  ls "$VSCODE_PATH"
  echo

  local targetFile=settings.json
  if [ -e "$VSCODE_PATH"/$targetFile ]; then
    replace_file_to_hardlink $targetFile
  else
    create_hardlink $targetFile
  fi

  targetFile=keybindings.json
  if [ -e "$VSCODE_PATH"/$targetFile ]; then
    replace_file_to_hardlink $targetFile
  else
    create_hardlink $targetFile
  fi
}

function main() {
  case "${OSTYPE}" in
    msys*)
      DOT_FILES=windows.dotfiles
      VSCODE_PATH=$HOME/AppData/Roaming/Code/User;;
    darwin*)
      DOT_FILES=mac.dotfiles
      VSCODE_PATH=$HOME/Library/Application\ Support/Code/User;;
    linux*)
      DOT_FILES=linux.dotfiles
      VSCODE_PATH=$HOME;;
  esac

  place_dotfiles
  create_vscode_hardlink
}

main
