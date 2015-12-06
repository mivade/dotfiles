#!/usr/bin/env bash
# Setup links and other basic common functionality for a new
# environment.

HERE=$HOME/dotfiles

echo "Creating needed directories..."
mkdir -p $HOME/bin

echo "Linking bash files..."
ln -sf $HERE/bashrc $HOME/.bashrc
ln -sf $HERE/bash_aliases $HOME/.bash_aliases

echo "Building and installing nanorc..."
cd nanorc; make install; cd -
ln -sf $HERE/nanorc.nanorc $HOME/.nanorc

echo "Linking .screenrc..."
ln -sf $HERE/screenrc $HOME/.screenrc

echo "Setting up emacs..."
ln -sf $HERE/emacs $HOME/.emacs
ln -sf $HERE/emacs.d $HOME/.emacs.d

echo "Lining cookiecutter..."
ln -sf $HERE/cookiecutterrc $HOME/.cookiecutterrc
