alias ll='ls -alF'
alias la='ls -A'
# alias l='ls -CF'
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
alias gstat='git status'
alias wip="git commit -a -m 'wip' && git push"
alias gamend="git add --all && git commit --amend"
alias freset="git fetch && git reset --hard origin/new-visitor-list"

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
