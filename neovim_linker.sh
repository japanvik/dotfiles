#!/bin/sh
mkdir -p ~/.config/nvim
ln -sf ~/dotfiles/init.vim ~/.config/nvim
ln -sf ~/dotfiles/tern-project ~/.tern-project
#
mkdir -p ~/.local/share/nvim/site/
ln -sf ~/dotfiles/.vim/colors ~/.local/share/nvim/site/
ln -sf ~/dotfiles/.vim/snips ~/.local/share/nvim/site/
ln -sf ~/dotfiles/.vim/autoload ~/.local/share/nvim/site/

