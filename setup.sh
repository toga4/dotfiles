#!/bin/bash

CURRENTDIR=$(cd $(dirname $0); pwd)

DOT_FILES=( .zshrc .zshrc.tmux .tmux.conf .tmux.conf.osx .tmux.conf.others .gitconfig .vimrc )

for file in ${DOT_FILES[@]}
do
    ln -s $CURRENTDIR/$file $HOME/$file
done

case ${OSTYPE} in
  cygwin*|msys*)
    ln -s $HOME/.dotfiles/.gitconfig.win $HOME/.gitconfig.os
    ;;
esac

mkdir -p $HOME/.vim/undo $HOME/.vim/tmp

