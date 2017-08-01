#zmodload zsh/zprof

# usage: source_this [filename]
func source_this() {
    if [[ -a "$1" ]]; then
        #t=`gdate +'%s%N'`
        #echo -ne "\n\n\n$1: "
        source $1
        #echo "$((`gdate +'%s%N'` - $t)) ns"
    fi
}

# usage: cmd_exists [command]
func cmd_exists() {
    if `which "$1" &>> /dev/null`; then
        return 0
    else
        return 1
    fi
}

# usage: lazy_source [command] [file to source]
func lazy_source() {
    if [[ -a "$2" ]]; then
        alias $1="source $2; unalias $1; $1"
    fi
}

if [[ -a $HOME/.oh-my-zsh ]]; then
    export ZSH=$HOME/.oh-my-zsh
    ZSH_THEME="agnoster"
    COMPLETION_WAITING_DOTS="true"
    # Uncomment the following line if you want to disable marking untracked files
    # under VCS as dirty. This makes repository status check for large repositories
    # much, much faster.
    #DISABLE_UNTRACKED_FILES_DIRTY="true"
    HIST_STAMPS="yyyy-mm-dd"
    plugins=(autopep8 colored-man-pages colorize git github gpg-agent pep8 pylint python ruby safer-paste ssh-agent taskwarrior vagrant)
    zstyle :omz:plugins:ssh-agent agent-forwarding on
    source $ZSH/oh-my-zsh.sh
else
    zmodload zsh/complete
    zmodload zsh/computil
    zmodload zsh/complist
    zmodload zsh/compctl
    autoload -Uz compinit && compinit
fi

lazy_source sdk $HOME/.sdkman/bin/sdkman-init.sh
lazy_source cargo $HOME/.cargo/env
source_this /usr/local/bin/aws_zsh_completer.sh
source_this $HOME/Library/Python/3.6/bin/aws_zsh_completer.sh
source_this $HOME/.zshrc-work

# do the vte thing to make tilix work more good
source_this /etc/profile.d/vte.sh

# command line jack enhancements
if cmd_exists 'jack_connect'; then
    source_this ~/dotfiles/zsh-jack-completion/zsh_jack_completion.sh
    alias jc="jack_connect"
    alias jd="jack_disconnect"
fi

# not sure if this will drive me nuts or not but here goes
if cmd_exists 'task'; then
    task next
fi

# vimwiki aliases
VIMWIKI_PATH="$HOME/vimwiki"
if [[ -a $VIMWIKI_PATH ]]; then
    alias diary="vim $VIMWIKI_PATH/diary/`date +%Y-%m-%d`.wiki"
    alias diaryindex="vim $VIMWIKI_PATH/diary/diary.wiki"
    alias wiki="vim $VIMWIKI_PATH/index.wiki"
fi

# lazy-load rbenv pls
if cmd_exists 'rbenv'; then
    rbenv() {
        eval "$(command rbenv init -)"
        rbenv "$@"
    }
fi

if cmd_exists 'git'; then
    alias git-sanitize='
    git config --local user.name "Jessie";
    git config --local user.email "mxjessie@users.noreply.github.com"'
    # git % github = hub https://hub.github.com
    if cmd_exists 'hub'; then
        alias git=hub
        alias gpr='git pull-request'
    fi
fi

# whoa dude
if cmd_exists 'lolcat'; then alias lsd="ls -hal | lolcat -t"; fi

# old tmux muscle memory
if cmd_exists 'tmux'; then alias atmux='tmux -2u attach'; fi

# i usually know what my name is
DEFAULT_USER='jessie'
# append rather than overwrite history file.
setopt APPEND_HISTORY
# lines of history to maintain in memory
HISTSIZE=1200                  
# lines of history to maintain in histfile
SAVEHIST=100000
# allow dups, but expire old dups first
setopt HIST_EXPIRE_DUPS_FIRST
# save timestamp & runtime info
setopt EXTENDED_HISTORY
# please don,t beeb beeb because i,m sleep ....
setopt NO_BEEP
