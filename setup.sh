#!/bin/bash

DOT_FILES=( .vim .vimrc .vimperatorrc .vimperator .gitconfig .zshrc )

function confirm {
  while true;
  do
    read answer
    case $answer in
      [yY]) return 0;;
      [nN]) return 1;;
      *) echo "Please type 'y' or 'n'"
         confirm
         return;;
    esac
  done
}

function replace_link {
  local referer=$1
  local link=$2

  echo "'$link' already exists."
  echo "Want to replace?(y/n)"
  confirm
  if [ $? -eq 0 ]; then
    rm -f $HOME/$link
    ln -s $cPath/$referer $HOME/$link
    echo "[Replaced]: $link"
  else
    echo "[Ignored]: $link"
  fi
  echo
}

function create_link {
  local name=$1

  echo $cPath/$name $HOME/$name
  ln -s $cPath/$name $HOME/$name
  echo "[Created]: $name"
  echo
}

function place_dotfiles {
  echo "*** Creating Symbolic Link ***"
  echo
  cPath=$PWD
  for file in ${DOT_FILES[@]}
  do
    if [ $file = ".vimperator" -a "`echo ${OSTYPE} | grep "msys"`" != "" ]; then
      if [ -a $HOME/vimperator ]; then
        replace_link $file "vimperator"
      else
        create_link $file
        mv $HOME/.vimperator $HOME/vimperator
      fi
      continue
    fi

    if [ -a $HOME/$file ]; then
      replace_link $file $file
    else
      create_link $file
    fi
  done
}

function install_pacman_pkg {
  echo "*** Install Pacman Packages ***"
  echo
  echo "* Update Pacman System"
  echo
  pacman -Syu
  echo "* Install vim, git, zsh, ruby"
  echo
  pacman -S vim git zsh ruby
}

function install_brew_pkg {
  echo "*** Install Homebrew Packages ***"
  echo
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew install coreutils
}

function modify_msys_batfile {
  ruby -e "
    text = ''
    msysPath = /i(3|6)86/ =~ \`uname -a\`.to_s ? 'C:/msys32/' : 'C:/msys64/'
    open(msysPath + 'msys2_shell.bat') do |f|
      text = f.read
      text.gsub!('rem set MSYS=winsymlinks:nativestrict', 'set MSYS=winsymlinks:nativestrict')
    end

    open(msysPath + 'msys2_shell.bat', 'w') do |f|
      f.write(text)
    end
  "
  export MSYS=winsymlinks:nativestrict
}

function install_zsh_plugins {
  # zsh-autosuggestions
  git clone git://github.com/tarruda/zsh-autosuggestions $HOME/.zsh-autosuggestions
}

function setup_windows {
  echo "windows"
  install_pacman_pkg
  modify_msys_batfile
  place_dotfiles
  install_zsh_plugins
}

function setup_mac {
  echo "mac"
  install_brew_pkg
  place_dotfiles
  install_zsh_plugins
}

function setup_linux {
  echo "linux"
  install_pacman_pkg
  place_dotfiles
  install_zsh_plugins
}

function main {
  case "${OSTYPE}" in
    msys*)
      setup_windows;;
    darwin*)
      setup_mac;;
    linux*)
      setup_linux;;
  esac
}

main

