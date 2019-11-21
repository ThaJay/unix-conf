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
alias nodebin='echo -e "Setting up nodebin with path:\n$(npm bin)"; export PATH=$(npm bin):$PATH'
alias ro='sudo su -'
alias ptp='ptipython --vi'
alias clrswp='find . -name "*.swp" -delete'
alias prjson='python -m json.tool'
alias itp='ssh itp_dj@dev1.intoparty.com'
alias ssh-add='eval $(ssh-agent) && ssh-add'
alias startservices='sudo su -c "service mysql start; service redis-server restart;"'
alias logcat-native='adb logcat ReactNative:V ReactNativeJS:V AndroidRuntime:V *:S'
alias restart-adb='adb kill-server&&adb devices'
alias wip='gitwip'
alias adb-reverse='adb reverse tcp:8081 tcp:8081'
alias rn-devmenu='adb shell input keyevent 82'
alias dump-translations='docker/manage.sh json_dump_app_translations > strings.json'
alias npmi='npm i --save'
alias npmid='npm i --save-dev'
alias django-test='docker/manage.sh test --parallel 4'
alias django-testk='docker/manage.sh test --parallel 4 --keepdb'
alias django-testfk='docker/manage.sh test --parallel 4 --failfast --keepdb'

# alias pip='pip3'
# alias python='python3'

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

addpath () {
    export PATH=$PATH:$*
}
