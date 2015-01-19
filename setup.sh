#!/usr/bin/env bash
# Setup links and other basic common functionality for a new
# environment.

ln -s $HOME/dotfiles/emacs $HOME/.emacs
# TODO: make this overwrite if it exists
ln -s $HOME/dotfiles/emacs.d $HOME/.emacs.d
ln -s $HOME/dotfiles/offlineimap/offlineimaprc $HOME/.offlineimaprc
