#!/bin/bash

export PYTHONIOENCODING='utf-8'
eval "$(thefuck --alias)"

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Default modifiers for less.
export LESS=-RiFXS

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# enable programmable completion features (just in case
# it's not already enabled in /etc/bash.bashrc or /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# # Init bash completion from local if ever needed?
# if [ -f /usr/local/etc/bash_completion ]; then
#     . /usr/local/etc/bash_completion
# elif [ -f /etc/bash_completion ]; then
#     . /etc/bash_completion
# fi

# Load possible bash plugins from the ~/.bash_plugins/ dir
if [ -d $HOME/.bash_plugins ]; then

    for f in $HOME/.bash_plugins/*
    do
        source $f
    done

fi

# Set the correct locale
export LANG=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8

# Add the ~/bin/ and ~/.local/bin dir to $PATH
export PATH=$PATH:$HOME/bin:$HOME/.local/bin

# Use a big command history
export HISTSIZE=54321
export HISTFILESIZE=90001

# Set the default editor to vscode if available
if hash code 2>/dev/null; then
    printf "setting code as default editor\n"
    export EDITOR=code
    export VISUAL=code
else
    printf "setting vim as default editor\n"
    export EDITOR=vim
    export VISUAL=vim
fi

# Don't put duplicate lines or lines starting with space in the history
export HISTCONTROL=ignoreboth

export PROMPT_COMMAND='history -a'

# Append to the history file, don't overwrite it
shopt -s histappend

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Disable the bell
set bell-style none

# Linux specific settings
if [[ $OSTYPE == linux* ]]; then
    # Disable the Ctrl+S freeze binding
    stty -ixon
    export TERM=xterm-256color
fi

# OS X specific settings
if [[ $OSTYPE == darwin* ]]; then
    export CLICOLOR=1
fi

export NODE_ENV='development'

# # Windows
# export ANDROID_HOME=C\:\\Users\\djjw\\AppData\\Local\\Android\\Sdk
# export ANDROID_NDK=C\:\\Users\\djjw\\AppData\\Local\\Android\\Ndk

# export PATH="/opt/android-studio/bin:$PATH"

# Git prompt
if [ -s /usr/lib/git-core/git-sh-prompt ]; then
    source /usr/lib/git-core/git-sh-prompt
fi

if [ -s ~/.git-prompt.sh ]; then
    source ~/.git-prompt.sh
fi

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_STATESEPARATOR=" "
GIT_PS1_DESCRIBE_STYLE='branch'

PS1="\
\[$(tput setaf 1)\]\$?\
\[$(tput setaf 5)\]-\
\[$(tput setaf 4)\]\A\
\[$(tput setaf 5)\]-\
\[$(tput bold)\]\[$(tput setaf 4)\]\w\
\[$(tput sgr0)\]\
\[$(tput setaf 5)\]\
\$(__git_ps1)\
\[$(tput setaf 4)\]\[$(tput bold)\]\$ \
\[$(tput sgr0)\]\
"

# export PATH="$HOME/.rbenv/bin:$PATH"
# eval "$(rbenv init -)"
# export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

# export PATH="$(python3 -m site --user-base)/bin:$PATH"

# Windows Subsystem for Linux specific initialisation:
# if cat /proc/sys/kernel/osrelease | grep -q Microsoft; then
#     echo "WSL identified, running WSL specific commands."
#     export DISPLAY=localhost:0.0
# fi

# eval $( dircolors -b ~/.LS_COLORS )

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

#  Nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
