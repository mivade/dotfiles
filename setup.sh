#!/usr/bin/env bash
# Setup links and other basic common functionality for a new
# environment.

HERE=$HOME/dotfiles

echo "Setting up git submodules..."
git submodule init
git submodule update

echo "Creating needed directories..."
mkdir -p $HOME/bin

echo "Linking bash files..."
ln -sf $HERE/.bashrc $HOME
ln -sf $HERE/.bash_aliases $HOME

echo "Building and installing .nanorc..."
cd nanorc; make install; cd -
ln -sf $HERE/.nanorc $HOME/.nanorc

echo "Linking .screenrc..."
ln -sf $HERE/.screenrc $HOME

echo "Setting up emacs..."
ln -sf $HERE/.emacs $HOME
ln -sf $HERE/.emacs.d $HOME

echo "Linking others..."
ln -sf $HERE/.cookiecutterrc $HOME
ln -sf $HERE/.latexmkrc $HOME
ln -sf $HERE/.gitconfig $HOME
