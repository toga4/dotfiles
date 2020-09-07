#!/bin/bash

CURRENTDIR=$(cd $(dirname $0); pwd)

DOT_FILES=(
  bin
  .zshrc
  .zshrc.alias
  .zshrc.completion
  .zshrc.functions
  .zshrc.options
  .zshrc.prompt
  .zshrc.tmux
  .tmux.conf
  .tmux.conf.osx
  .tmux.conf.others
  .gitconfig
  .vimrc
  .vim/colors/anderson.vim
)

# create symbolic links
for file in ${DOT_FILES[@]}
do
    ln -sf $CURRENTDIR/$file $HOME/$file
done

case ${OSTYPE} in
  cygwin*|msys*)
    # for Windows
    ln -sf $HOME/.dotfiles/.gitconfig.win $HOME/.gitconfig.os
    ;;
  darwin*)
    # for MacOSX
    ln -sf $CURRENTDIR/Brewfile $HOME/Brewfile
    ;;
esac

# Vim
mkdir -p $HOME/.vim/undo $HOME/.vim/tmp

