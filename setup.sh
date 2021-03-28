#!/bin/bash

CURRENTDIR=$(cd $(dirname $0); pwd)

DOT_FILES=(
  bin
  .zshrc
  .tmux.conf
  .tmux.conf.osx
  .gitconfig
  .vimrc
  .vim/colors/anderson.vim
)

# Vim
mkdir -p $HOME/.vim/{undo,tmp,colors}

# create symbolic links
for file in ${DOT_FILES[@]}
do
    ln -sfh $CURRENTDIR/$file $HOME/$file
done

case ${OSTYPE} in
  darwin*)
    # for MacOSX
    ln -sf $CURRENTDIR/Brewfile $HOME/Brewfile
    ;;
esac

