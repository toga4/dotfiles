#!/bin/bash

CURRENTDIR=$(cd $(dirname $0); pwd)

DOT_FILES=( .zshrc .zshrc.tmux .tmux.conf .tmux.conf.osx .tmux.conf.others .gitconfig .vimrc )

for file in ${DOT_FILES[@]}
do
    ln -sf $CURRENTDIR/$file $HOME/$file
done

case ${OSTYPE} in
  cygwin*|msys*)
    ln -sf $HOME/.dotfiles/.gitconfig.win $HOME/.gitconfig.os
    ;;
  darwin*)
    ln -sf $CURRENTDIR/Brewfile $HOME/Brewfile
    ;;
esac

mkdir -p $HOME/.vim/undo $HOME/.vim/tmp

