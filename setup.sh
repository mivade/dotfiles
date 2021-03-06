#!/usr/bin/env bash
# Setup links and other basic common functionality for a new
# environment.

set -e

HERE=$HOME/dotfiles

echo "Setting up git submodules..."
git submodule init
git submodule update

if [[ `uname` == "Darwin" ]]; then
    echo "Configuring gitk..."
    ln -sf $HERE/.gitk $HOME
fi

echo "Creating needed directories..."
mkdir -p $HOME/bin

echo "Linking bash files..."
ln -sf $HERE/.bashrc $HOME
ln -sf $HERE/.bash_aliases $HOME

echo "Linking .screenrc..."
ln -sf $HERE/.screenrc $HOME

echo "Setting up editors..."
cd nanorc; ./install.sh; cd -
ln -sf $HERE/.nanorc $HOME/.nanorc
ln -sf $HERE/.emacs $HOME
ln -sf $HERE/.emacs.d $HOME
ln -sf $HERE/.vimrc $HOME

echo "Linking others..."
ln -sf $HERE/.cookiecutterrc $HOME
ln -sf $HERE/.latexmkrc $HOME
ln -sf $HERE/.gitconfig $HOME
ln -sf $HERE/.tmux.conf $HOME
