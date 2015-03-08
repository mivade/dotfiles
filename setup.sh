#!/usr/bin/env bash
# Setup links and other basic common functionality for a new
# environment.

mkdir -p $HOME/bin
ln -s /usr/bin/python3 $HOME/bin/python

cd nanorc; make install; cd -
ln -s $HOME/dotfiles/nanorc.nanorc $HOME/.nanorc

ln -s $HOME/dotfiles/bash_aliases $HOME/.bash_aliases
ln -s $HOME/dotfiles/emacs $HOME/.emacs
# TODO: make this overwrite if it exists
#ln -s $HOME/dotfiles/emacs.d $HOME/.emacs.d
ln -s $HOME/dotfiles/offlineimap/offlineimaprc $HOME/.offlineimaprc
ln -s $HOME/dotfiles/ssh_config $HOME/.ssh/config
