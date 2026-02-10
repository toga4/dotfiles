SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
MAKEFLAGS += --warn-undefined-variables
.DEFAULT_GOAL := help

.PHONY: $(shell egrep -o ^[a-zA-Z_-]+: $(MAKEFILE_LIST) | sed 's/://')

help:
	@echo 'Usage: make [target]'
	@echo 'Targets:'
	@egrep -o '^[a-zA-Z_-]+:' $(MAKEFILE_LIST) | perl -pe 's/^(.+):/    \1/'

bundle:
	brew bundle --file Brewfile

install:
	# zsh
	([[ -f ~/.zshrc ]] && grep -qF "source ~/.zshrc.custom" ~/.zshrc) || echo '[[ -f ~/.zshrc.custom ]] && source ~/.zshrc.custom' >> ~/.zshrc
	test -f ~/.zshrc.custom || ln -s $(PWD)/.zshrc ~/.zshrc.custom
	mkdir -p ~/zsh
	test -d ~/zsh/functions || ln -s $(PWD)/zsh-functions ~/zsh/functions
	# vim
	test -d ~/bin || ln -s $(PWD)/bin ~/bin
	mkdir -p ~/.vim/{undo,tmp,colors}
	curl -s https://raw.githubusercontent.com/junegunn/seoul256.vim/master/colors/seoul256.vim -o ~/.vim/colors/seoul256.vim
	test -f ~/.vim/colors/anderson.vim || ln -s $(PWD)/.vim/colors/anderson.vim ~/.vim/colors/anderson.vim
	test -f ~/.vimrc || ln -s $(PWD)/.vimrc ~/.vimrc
	# XDG_CONFIG_DIR
	mkdir -p ~/.config/git
	test -f ~/.config/git/config || ln -s $(PWD)/.config/git/config ~/.config/git/config
	mkdir -p ~/.config/tmux
	test -f ~/.config/tmux/tmux.conf || ln -s $(PWD)/.config/tmux/tmux.conf ~/.config/tmux/tmux.conf
	mkdir -p ~/.config/ghostty
	test -f ~/.config/ghostty/config || ln -s $(PWD)/.config/ghostty/config ~/.config/ghostty/config

clean:
	rm -f ~/.zshrc.custom
	rm -f ~/zsh/functions
	rm -f ~/bin
	rm -f ~/.vim/colors/anderson.vim
	rm -f ~/.vim/colors/seoul256.vim
	rm -f ~/.vimrc
	rm -f ~/.config/git/config
	rm -f ~/.config/tmux/tmux.config
	rm -f ~/.config/ghostty/config
