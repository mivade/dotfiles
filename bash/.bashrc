# -*- shell-script -*-

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  elif [ -f /etc/bash_completion.d ]; then
    . /etc/bash_completion.d
  fi
fi

# Better terminal color support
export TERM=xterm-256color

# -----------------------------------------------------------------------------
# OS-SPECIFIC CONFIGURATION
# -----------------------------------------------------------------------------

if [[ "$OSTYPE" == "darwin"* ]]; then
    # Ensure /usr/local/bin is in the path
    export PATH=$PATH:/usr/local/bin

    # Enable color support with ls
    export CLICOLOR=1
    export LSCOLORS=ExFxBxDxCxegedabagacad

    # Enable bash completion for common things. Assumes homebrew is installed.
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
        for completion in "git-completion.bash gcc"; do
            source $(brew --prefix)/etc/bash_completion.d/$completion
        done
    fi

    # Assume emacs is installed in /Applications to not use the super old
    # system version
    alias emacs=/Applications/Emacs.app/Contents/MacOS/Emacs
fi

# -----------------------------------------------------------------------------
# SSH
# -----------------------------------------------------------------------------

# Start ssh-agent if necessary
# https://unix.stackexchange.com/a/217223
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval `ssh-agent`
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
# uncomment below to auto-add keys to ssh-agent
# ssh-add -l > /dev/null || ssh-add

# -----------------------------------------------------------------------------
# UTILITIES
# -----------------------------------------------------------------------------

function gitignore() {
    if [ -z $1 ]; then
	ls $HOME/dotfiles/gitignore
    else
	cat $HOME/dotfiles/gitignore/$1.gitignore
    fi
}

# -----------------------------------------------------------------------------
# CONDA
# -----------------------------------------------------------------------------

export MINICONDA_HOME="$HOME/miniconda3"

# Macros for switching between conda and system Python
alias condafy="conda activate base"
alias cbase="conda activate base"
alias noconda="conda deactivate"

# Activate a conda environment named the same as the current directory
function conact() {
    conda activate $(basename $(pwd))
}

# Create a conda environment for the current directory.
# Use `environment.yaml` if it exists, otherwise create an empty environment.
function cenv() {
    if [ -f environment.yaml ]; then
	conda env create --file=environment.yaml -n $(basename $(pwd))
    else
	conda create -yn $(basename $(pwd))
    fi
}

# Remove current directory's conda environment
function rmcenv() {
    conda remove -n $(basename $(pwd)) --all
}

# Enable conda
# FIXME: don't panic if this fails
. $MINICONDA_HOME/etc/profile.d/conda.sh

# -----------------------------------------------------------------------------
# PATH
# -----------------------------------------------------------------------------

export PATH="$HOME/bin:$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
export NODE_PATH=$NODE_PATH:$HOME/.local/lib/node_modules

# -----------------------------------------------------------------------------
# ALIASES
# -----------------------------------------------------------------------------

alias tmux="$MINICONDA_HOME/envs/tmux/bin/tmux"
alias tmuxp="$MINICONDA_HOME/envs/tmux/bin/tmuxp"

