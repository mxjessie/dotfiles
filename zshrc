if [[ -a $HOME/.oh-my-zsh ]]; then
    export ZSH=$HOME/.oh-my-zsh
    #ZSH_THEME="robbyrussell"
    ZSH_THEME="agnoster"
    COMPLETION_WAITING_DOTS="true"
    # Uncomment the following line if you want to disable marking untracked files
    # under VCS as dirty. This makes repository status check for large repositories
    # much, much faster.
    # DISABLE_UNTRACKED_FILES_DIRTY="true"
    HIST_STAMPS="yyyy-mm-dd"
    plugins=(git ruby pep8 pylint python colorize vagrant)
    source $ZSH/oh-my-zsh.sh
fi

func source_this() {
    if [[ -a "$1" ]]; then
        source $1
    fi
}

source_this $HOME/Library/Python/3.6/bin/aws_zsh_completer.sh
source_this $HOME/.sdkman/bin/sdkman-init.sh

# command line jack enhancements
if `which jack_connect > /dev/null`; then
    source_this ~/dotfiles/zsh-jack-completion/zsh_jack_completion.sh
    alias jc="jack_connect"
    alias jd="jack_disconnect"
fi

# rbenv pls
if `which rbenv > /dev/null`; then
    eval "$(rbenv init -)"
fi

# whoa dude
if `which lolcat > /dev/null`; then
    alias lsd="ls -hal | lolcat"
fi

# append rather than overwrite history file.
setopt APPEND_HISTORY
# lines of history to maintain in memory
HISTSIZE=1200                  
# lines of history to maintain in histfile
SAVEHIST=1000
# allow dups, but expire old dups first
setopt HIST_EXPIRE_DUPS_FIRST
# save timestamp & runtime info
setopt EXTENDED_HISTORY
