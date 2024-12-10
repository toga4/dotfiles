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
	brew bundle --no-lock --file Brewfile

install:
	grep -qF "source ~/.zshrc.custom" ~/.zshrc || echo '[[ -f ~/.zshrc.custom ]] && source ~/.zshrc.custom' >> ~/.zshrc
	test -f ~/.zshrc.custom || ln -s $(PWD)/.zshrc ~/.zshrc.custom
	mkdir -p ~/zsh
	test -d ~/zsh/functions || ln -s $(PWD)/zsh-functions ~/zsh/functions
	test -d ~/bin || ln -s $(PWD)/bin ~/bin
	test -f ~/.gitconfig || ln -s $(PWD)/.gitconfig ~/.gitconfig
	test -f ~/.tmux.conf || ln -s $(PWD)/.tmux.conf ~/.tmux.conf
	test -f ~/.tmux.conf.osx || ln -s $(PWD)/.tmux.conf.osx ~/.tmux.conf.osx
	mkdir -p ~/.vim/{undo,tmp,colors}
	curl -s https://raw.githubusercontent.com/junegunn/seoul256.vim/master/colors/seoul256.vim -o ~/.vim/colors/seoul256.vim
	test -f ~/.vim/colors/anderson.vim || ln -s $(PWD)/.vim/colors/anderson.vim ~/.vim/colors/anderson.vim
	test -f ~/.vimrc || ln -s $(PWD)/.vimrc ~/.vimrc
	test -f ~/.alacritty.toml || ln -s $(PWD)/.alacritty.toml ~/.alacritty.toml

clean:
	rm -f ~/.zshrc.custom
	rm -f ~/zsh/functions
	rm -f ~/bin
	rm -f ~/.gitconfig
	rm -f ~/.tmux.conf
	rm -f ~/.tmux.conf.osx
	rm -f ~/.vim/colors/anderson.vim
	rm -f ~/.vim/colors/seoul256.vim
	rm -f ~/.vimrc
	rm -f ~/.alacritty.yml
