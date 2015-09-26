#!/usr/bin/env bash
# Setup links and other basic common functionality for a new
# environment.

mkdir -p $HOME/bin

cd nanorc; make install; cd -
ln -sf $HOME/dotfiles/nanorc.nanorc $HOME/.nanorc

ln -sf $HOME/dotfiles/bash_aliases $HOME/.bash_aliases

ln -sf $HOME/dotfiles/emacs $HOME/.emacs
ln -sf $HOME/dotfiles/emacs.d $HOME/.emacs.d

ln -sf $HOME/dotfiles/offlineimap/offlineimaprc $HOME/.offlineimaprc

ln -sf $HOME/dotfiles/ssh_config $HOME/.ssh/config

ln -sf $HOME/dotfiles/cookiecutterrc $HOME/.cookiecutterrc
