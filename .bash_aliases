# Bash Aliases and callable functions

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

add-to-path () {
    export PATH=$PATH:$*
}

show-branch-by-date () {
    for k in `git branch | perl -pe s/^..//`; do echo -e `git show --pretty=format:"%Cgreen%ci %Cblue%cr%Creset" $k -- | head -n 1`\\t$k; done | sort -r
}

show-remote-branch-by-date () {
    for k in `git branch -r | perl -pe 's/^..(.*?)( ->.*)?$/\1/'`; do echo -e `git show --pretty=format:"%Cgreen%ci %Cblue%cr%Creset" $k -- | head -n 1`\\t$k; done | sort -r
}

delete-remote-branch () {
    echo "deleting remote branch $1 $2"
    git push -d $1 $2
    echo "deleting local branch $2"
    git branch -d $2
}

# our handler that returns choices by populating Bash array COMPREPLY
# (filtered by the currently entered word ($2) via compgen builtin)
_gitpull_complete() {
    branches=$(git branch -l | cut -c3-)
    COMPREPLY=($(compgen -W "$branches" -- "$2"))
}

gitignore() {
    echo "$1" >> .gitignore
}

gitwip () {
    echo "adding .";
    git add .;

    echo "making commit with message: wip $1";
    git commit -a -m "wip $1";

    echo "pushing commit";
    git push;
}

name-tab () {
    echo -en "\033]0;$1\a"
}

complete -F _gitpull_complete delete-remote-branch

# test-python ()
# {
#     ./docker/manage.sh test --parallel 4 $(echo "$*" | sed 's/\//./g' | sed 's/\.py//g' | sed 's/\.$//')
# }
#
# alias test-pythonk='test-python --keepdb'

# alias pip='pip3'
# alias python='python3'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Linux specific settings
if [[ $OSTYPE == linux* ]]; then
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

# alias ls='ls -F -h -v -C --color=always --author --time-style=long-iso --group-directories-first'
alias ls='ls -F -h -v -C --color=always'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -lAFh'
alias c='cd'
alias c.='cd ..'
alias c..='cd ..'
alias c-='cd -'
alias c~='cd ~'
alias t='tmux'
alias tmc='tmux loadb -'
alias tmp='tmux saveb -'
alias rm='rm -i'
alias gf='git fetch'
alias gs='git status'
alias gp='git push'
alias gg='git grep -i'
alias ro='sudo su -'
alias v='vim .'
alias npmi='npm i'
# alias vi='vim'
# alias vip='vim -p'
# alias vs='vi -S Session.vim'
# alias j='jobs'
# alias f='fg'
# alias s='screen'
# alias ip='ipython --pprint'
# alias ptp='ptipython --vi'
# alias clrswp='find . -name "*.swp" -delete'
# alias prjson='python -m json.tool'

alias nodebin='echo -e "Setting up nodebin with path:\n$(npm bin)"; export PATH=$(npm bin):$PATH'
alias startservices='sudo su -c "service mysql restart; service redis-server restart;"'
alias docker-up='docker-compose up -d && docker-compose logs -ft'
alias ssh-add='eval $(ssh-agent) && ssh-add'
# alias itp='ssh itp_dj@dev1.intoparty.com'
# alias ssh-crm='ssh itp_dj@142.93.142.72'

alias logcat-native='adb logcat ReactNative:V ReactNativeJS:V AndroidRuntime:V *:S'
alias restart-adb='adb kill-server&&adb devices'
alias adb-reverse='adb reverse tcp:8081 tcp:8081'
alias rn-devmenu='adb shell input keyevent 82'

alias yad="yarn add"
alias yadD="yarn add -D"
# alias npmi='npm i --save'
# alias npmid='npm i --save-dev'

# alias dump-translations='docker/manage.sh json_dump_app_translations > strings.json'
# alias django-test='docker/manage.sh test --parallel 4'
# alias django-testk='docker/manage.sh test --parallel 4 --keepdb'
# alias django-testfk='docker/manage.sh test --parallel 4 --failfast --keepdb'

alias wip='gitwip'
alias commit-random='git commit -m "$(curl -s http://whatthecommit.com/index.txt)"'
alias gl='git log --graph --decorate --pretty=oneline --abbrev-commit'
alias gamend="git add . && git commit --amend --no-edit && git push -f"

alias nt="name-tab"
alias indocker="docker-compose exec"

alias n14="nvm use 14"
alias n14dev="n14 && yarn dev"
alias greset="git fetch && git reset --hard origin/\$(_current_branch_name)"

alias nukenode="rm -rf ./node_modules && npm i"
alias nukepods="cd ios && pod deintegrate && rm -rf Podfile.lock && pod install && cd .."
alias resetpackages="nukenode && nukepods"
alias test-prod="npm run build && npx serve -s build"
