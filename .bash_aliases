alias ls='ls -F -h --color=always -v --author --time-style=long-iso -C'
alias ll='ls -alF'
alias la='ls -A'
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
alias ro='sudo su -'
alias ptp='ptipython --vi'
alias clrswp='find . -name "*.swp" -delete'
alias prjson='python -m json.tool'

alias nodebin='echo -e "Setting up nodebin with path:\n$(npm bin)"; export PATH=$(npm bin):$PATH'
alias startservices='sudo su -c "service mysql restart; service redis-server restart;"'
alias docker-up='docker-compose up -d && docker-compose logs -ft'
alias itp='ssh itp_dj@dev1.intoparty.com'
alias ssh-crm='ssh itp_dj@142.93.142.72'
alias ssh-add='eval $(ssh-agent) && ssh-add'

alias logcat-native='adb logcat ReactNative:V ReactNativeJS:V AndroidRuntime:V *:S'
alias restart-adb='adb kill-server&&adb devices'
alias adb-reverse='adb reverse tcp:8081 tcp:8081'
alias rn-devmenu='adb shell input keyevent 82'

alias npmi='npm i --save'
alias npmid='npm i --save-dev'

alias dump-translations='docker/manage.sh json_dump_app_translations > strings.json'
alias django-test='docker/manage.sh test --parallel 4'
alias django-testk='docker/manage.sh test --parallel 4 --keepdb'
alias django-testfk='docker/manage.sh test --parallel 4 --failfast --keepdb'

alias wip='gitwip'
alias commit-random='git commit -m "$(curl -s http://whatthecommit.com/index.txt)"'
alias gl='git log --graph --decorate --pretty=oneline --abbrev-commit'

gitignore() {
    echo "$1" >> .gitignore
}

alias pip='pip3'
alias python='python3'

# test-python ()
# {
#     ./docker/manage.sh test --parallel 4 $(echo "$*" | sed 's/\//./g' | sed 's/\.py//g' | sed 's/\.$//')
# }

# alias test-pythonk='test-python --keepdb'

gitwip () {
    echo "adding .";
    git add .;
    echo "making commit with message: wip $1";
    git commit -a -m "wip $1";
    echo "pushing commit";
    git push;
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
# we now register our handler to provide completion hints for the "gitpull" command
complete -F _gitpull_complete delete-remote-branch
