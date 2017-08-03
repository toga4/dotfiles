#!/bin/bash

DOT_FILES=( .zshrc .zshrc.tmux .tmux.conf .tmux.conf.osx .tmux.conf.others .vimrc )

for file in ${DOT_FILES[@]}
do
    ln -s $HOME/.dotfiles/$file $HOME/$file
done

mkdir -p $HOME/.vim/undo $HOME/.vim/tmp
