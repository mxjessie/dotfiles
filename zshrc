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

func cmd_exists() {
    # i feel like there might be a better way to do this
    if `which "$1" > /dev/null`; then
        return 0
    else
        return 1
    fi
}

source_this /usr/local/bin/aws_zsh_completer.sh
source_this $HOME/Library/Python/3.6/bin/aws_zsh_completer.sh
source_this $HOME/.sdkman/bin/sdkman-init.sh
source_this $HOME/.zshrc-work

# command line jack enhancements
if cmd_exists 'jack_connect'; then
    source_this ~/dotfiles/zsh-jack-completion/zsh_jack_completion.sh
    alias jc="jack_connect"
    alias jd="jack_disconnect"
fi

# rbenv pls
if cmd_exists 'rbenv'; then eval "$(rbenv init -)"; fi

# git % github = hub https://hub.github.com
if cmd_exists 'hub'; then alias git=hub; fi

# whoa dude
if cmd_exists 'lolcat'; then alias lsd="ls -hal | lolcat"; fi

# if gpg exists, start an agent or load existing agent settings
if cmd_exists 'gpg-agent'; then
    [ -f ~/.gpg-agent-info ] && source ~/.gpg-agent-info
    if [ -S "${GPG_AGENT_INFO%%:*}" ]; then
        export GPG_AGENT_INFO
    else
        eval $( gpg-agent --daemon --write-env-file ~/.gpg-agent-info )
    fi
fi

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
