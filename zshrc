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
    plugins=(git ruby pep8 pylint python colorize)
    source $ZSH/oh-my-zsh.sh
fi

func add_to_path() {
    if [[ -a "$1" ]]; then
        export PATH="$1":$PATH
    fi
}

func source_this() {
    if [[ -a "$1" ]]; then
        source $1
    fi
}

add_to_path $HOME/bin
add_to_path $HOME/.cabal/bin
add_to_path $HOME/.local/bin
add_to_path $HOME/.gem/ruby/2.3.0/bin 
source_this /usr/local/bin/aws_zsh_completer.sh

export EDITOR="vim"

setopt APPEND_HISTORY          # append rather than overwrite history file.
HISTSIZE=1200                  # lines of history to maintain memory
SAVEHIST=1000                  # lines of history to maintain in history file.
setopt HIST_EXPIRE_DUPS_FIRST  # allow dups, but expire old ones when I hit HISTSIZE
setopt EXTENDED_HISTORY        # save timestamp and runtime information
