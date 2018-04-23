#!/usr/bin/bash

# put these files into place
cd $HOME
ln -sb dotfiles/.screenrc .
ln -sb dotfiles/.bash_profile .
ln -sb dotfiles/.bashrc .
ln -sb dotfiles/.bashrc_custom .
ln -sf dotfiles/.vimrc .
ln -sf dotfiles/.gitconfig .
ln -sf dotfiles/.colordiffrc .
ln -sf dotfiles/.zshrc .
ln -sf dotfiles/.zshenv .
ln -sf setup/gitcheck.sh
touch .zsh_eternal_history
