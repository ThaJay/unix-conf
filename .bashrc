#!/bin/bash

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

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Add RVM to PATH
if [ -d $HOME/.rvm/bin ]; then
    export PATH="$PATH:$HOME/.rvm/bin"
fi

# Init bash completion
if [ -f /usr/local/etc/bash_completion ]; then
    . /usr/local/etc/bash_completion
elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# Load possible bash plugins from the ~/.bash_plugins/ dir
if [ -d $HOME/.bash_plugins ]; then

    for f in $HOME/.bash_plugins/*
    do
        source $f
    done

fi

# Set the correct locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Add the ~/bin/ dir to $PATH
export PATH=$PATH:$HOME/bin

# Use a big command history
export HISTSIZE=1000
export HISTFILESIZE=2000

# Set the default editor to sublime-text if available
if hash subl 2>/dev/null; then
    printf "setting subl as default editor\n"
    export EDITOR=subl
    export VISUAL=subl
else
    printf "setting vim as default editor\n"
    export EDITOR=vim
    export VISUAL=vim
fi

# Don't put duplicate lines or lines starting with space in the history
export HISTCONTROL=ignoreboth

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

    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'

    # Simulate OSX's pbcopy and pbpaste on linux using xsel
    alias pbcopy='xsel --clipboard --input'
    alias pbpaste='xsel --clipboard --output'
    alias list-kernels='dpkg --list | grep linux-image'
    alias remove-unused-kernels="\
        dpkg -l 'linux-*' |\
        sed '/^ii/!d;/'"$(uname -r | sed\
        "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d'\
        | xargs sudo apt-get -y purge"

fi

# OS X specific settings
if [[ $OSTYPE == darwin* ]]; then
    export CLICOLOR=1
fi

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

export NODE_ENV='development'
export ANDROID_HOME=/opt/android-sdk-linux
export PATH="$HOME/opt/jdk1.8.0_102/bin:$HOME/opt/android-sdk-linux/tools:$HOME/opt/android-sdk-linux/platform-tools:$PATH"

export ANDROID_SDK=/opt/android-sdk-linux
export ANDROID_NDK=/media/dj/Shared/android-ndk-r10e


# Git
source '/usr/lib/git-core/git-sh-prompt'

_has_commits() {
    if git rev-parse --verify HEAD > /dev/null 2>&1; then
        return 0
    else
        return 1
    fi
}

_current_branch_name() {
    if _has_commits ; then
        git rev-parse --short --abbrev-ref HEAD
    else
        echo "master"
    fi
}

# Add some handy custom commands
last-commit-hash() { # Shows the hash of the previous commit for the given file
    git log -1 --skip=1 --format="%H" -- "$1"
}

diff-last-commit() {
    # Shows the changes from the last commit
    # If a file is supplied, it will check the changes from the last
    # commit on that particular file. If multiple files are supplied it
    # will do this for every file.
    if [[ $@ ]]
    then
        for file in $@
        do
            git diff $(last-commit-hash $file) HEAD -- $file
        done
    else
        git diff HEAD^ HEAD
    fi
}

# alias gamend="git add --all && git commit --amend"
alias gamend="git commit -a --amend && git push -f"
alias freset="git fetch && git reset --hard origin/\$(_current_branch_name)"

# Make the prompt blue, bold, display the current path and the current branch
export PS1="\
\[$(tput setaf 1)\]\$?\
\[$(tput setaf 5)\]-\
\[$(tput setaf 4)\]\A\
\[$(tput setaf 5)\]-\
\[$(tput setaf 4)\]\[$(tput bold)\]\w\
\[$(tput sgr0)\]\[$(tput setaf 5)\]\$(__git_ps1)\
\[$(tput setaf 4)\]\[$(tput bold)\] \$ \
\[$(tput sgr0)\]\
"

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"


# Android studio & sdk installed through umake
export PATH="$HOME/.local/share/umake/android/android-studio/bin/:$PATH"
export PATH="$HOME/.local/share/umake/android/android-sdk/tools/:$PATH"
export PATH="$HOME/.local/share/umake/android/android-sdk/platform-tools/:$PATH"
ANDROID_HOME=$HOME/.local/share/umake/android/android-sdk

# Windows Subsystem for Linux specific initialisation:
if cat /proc/sys/kernel/osrelease | grep -q Microsoft; then
    echo "WSL identified, running WSL specific commands."
    export DISPLAY=localhost:0.0
    export JAVA_HOME="$HOME/opt/jdk1.8.0_102/"
else
    echo "WSL not found"
    export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64/jre/"
fi
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
