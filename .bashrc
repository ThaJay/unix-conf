# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
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

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

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

# Set the correct locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Add the ~/bin/ dir to $PATH
export PATH=$PATH:$HOME/bin

# Make the prompt blue, bold and display the current path
export PS1="\[$(tput setaf 1)\]\$?\[$(tput setaf 4)\]\[$(tput setaf 5)\]-\[$(tput setaf 4)\]\A\[$(tput setaf 5)\]-\[$(tput setaf 4)\]\[$(tput bold)\]\w\[$(tput setaf 6)\] \$ \[$(tput sgr0)\]"

# Use a big command history
export HISTSIZE=1000
export HISTFILESIZE=2000

# Set the default editor to sublime-text
export EDITOR=subl
export VISUAL=subl

# Don't put duplicate lines or lines starting with space in the history
export HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

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

# Global aliases
alias l='ls -lAFh'
alias c='cd'
alias c.='cd ..'
alias c-='cd -'
alias c~='cd ~'
alias v='vim .'
alias vi='vim'
alias vip='vim -p'
alias vs='vi -S Session.vim'
alias j='jobs'
alias f='fg'
alias t='tmux'
alias tmc='tmux loadb -'
alias tmp='tmux saveb -'
alias s='screen'
alias rm='rm -i'
alias ip='ipython --pprint'
alias gg='git grep -i'
alias nodebin='echo -e "Setting up nodebin with path:\n$(npm bin)"; export PATH=$(npm bin):$PATH'
alias gitprompt=". $HOME/bin/gitprompt"
alias ro='sudo su -'
alias ptp='ptipython --vi'
alias clrswp='find . -name "*.swp" -delete'
alias prjson='python -m json.tool'
alias itp='ssh itp_dj@dev1.intoparty.com'
alias ssh-add='eval $(ssh-agent) && ssh-add'
alias gstat='git status'
alias wip="git commit -a -m 'wip' && git push"

actenv() {
    cur_working_dir=$(pwd)
    activate_path=env/bin/activate

    while [ ! -f $activate_path ]; do
        if [ "$(pwd)" == '/' ]; then
            echo No virtualenv found
            cd $cur_working_dir
            return
        fi
        cd ..
    done

    source $activate_path
    cd $cur_wording_dir
}

addpath() {
    export PATH=$PATH:$*
}

# Default modifiers for less.
#
# -R display color controll characters
# -i case insensitive search
# -F disable paging if the result fits on the screen
# -X disable termcap init/deinit, keeps the less output on the screen after exit.
# -S crop lines longer than the screen instead of wrapping them
export LESS=-RiFXS

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

export NODE_ENV='development'
export ANDROID_HOME=/opt/android-sdk-linux
export JAVA_HOME="$HOME/opt/jdk1.8.0_102/"
export PATH="$HOME/opt/jdk1.8.0_102/bin:$HOME/opt/android-sdk-linux/tools:$HOME/opt/android-sdk-linux/platform-tools:$PATH"
