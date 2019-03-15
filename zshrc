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

# from http://www.math.cmu.edu/~gautam/sj/blog/20140625-zsh-expand-alias.html
typeset -a ealiases
ealiases=()

# usage: ealias [command]
function ealias()
{
    alias $1
    ealiases+=(${1%%\=*})
}

function expand-ealias()
{
    if [[ $LBUFFER =~ "(^|[;|&])\s*(${(j:|:)ealiases})\$" ]]; then
        zle _expand_alias
        zle expand-word
    fi
    zle magic-space
}

zle -N expand-ealias

# oh-my-zsh setup
if [[ -a $HOME/.oh-my-zsh ]]; then
    export ZSH=$HOME/.oh-my-zsh
    if [[ -a $HOME/.oh-my-zsh/custom/themes/powerlevel9k ]]; then
        ZSH_THEME="powerlevel9k/powerlevel9k"
        POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir background_jobs_joined vcs status)
        POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(battery time)
        POWERLEVEL9K_BATTERY_ICON=""
        POWERLEVEL9K_BACKGROUND_JOBS_ICON="⧖"
        POWERLEVEL9K_BATTERY_LEVEL_BACKGROUND=(88 94 100 106 70 34 28 22)
        POWERLEVEL9K_STATUS_OK=false
        POWERLEVEL9K_TIME_BACKGROUND="blue"
        POWERLEVEL9K_VCS_SHOW_SUBMODULE_DIRTY=false
        #POWERLEVEL9K_VCS_GIT_HOOKS=(vcs-detect-changes git-aheadbehind git-remotebranch git-tagname)
        POWERLEVEL9K_VCS_GIT_HOOKS=(vcs-detect-changes git-remotebranch git-tagname)
    else
        ZSH_THEME="agnoster"
    fi
    COMPLETION_WAITING_DOTS="true"
    # Uncomment the following line if you want to disable marking untracked files
    # under VCS as dirty. This makes repository status check for large repositories
    # much, much faster.
    DISABLE_UNTRACKED_FILES_DIRTY="true"
    HIST_STAMPS="yyyy-mm-dd"
    plugins=(autopep8 colored-man-pages colorize git gpg-agent pep8 pylint python ruby safer-paste ssh-agent taskwarrior vagrant)
    zstyle :omz:plugins:ssh-agent agent-forwarding on
    source $ZSH/oh-my-zsh.sh
else
    # cd with just a dir name
    setopt autocd
    # fancy globs
    setopt extendedglob
    
    # enable autocompletions
    zmodload zsh/complete
    zmodload zsh/computil
    zmodload zsh/complist
    zmodload zsh/compctl
    autoload -Uz compinit && compinit
    #zstyle :completion::complete:-command-:: tag-order local-directories -
    zstyle ':completion:*' menu select
    zstyle ':completion:*' insert-tab false
    setopt COMPLETE_ALIASES

    # prompt.. stuff?
    #autoload -U promptinit
    #promptinit
    autoload -U colors && colors
    #export PROMPT="%{$fg[magenta]%n%}%{$fg[blue]%}@%{$fg[cyan]%m%}%{$fg[white]%}%B>%b %{$reset_color%}"
    #export PROMPT="%{$fg[magenta]%n%}%{$fg[blue]%}@%{$fg[cyan]%m%}%{$fg[white]%}> %{$reset_color%}"
    export PROMPT='%n@%m> '

    # key bindings are fuctup fsr
    typeset -g -A key

    key[Home]="$terminfo[khome]"
    key[End]="$terminfo[kend]"
    key[Insert]="$terminfo[kich1]"
    key[Backspace]="$terminfo[kbs]"
    key[Delete]="$terminfo[kdch1]"
    key[Up]="$terminfo[kcuu1]"
    key[Down]="$terminfo[kcud1]"
    key[Left]="$terminfo[kcub1]"
    key[Right]="$terminfo[kcuf1]"
    key[PageUp]="$terminfo[kpp]"
    key[PageDown]="$terminfo[knp]"

    # setup key accordingly
    [[ -n "$key[Home]"      ]] && bindkey -- "$key[Home]"      beginning-of-line
    [[ -n "$key[End]"       ]] && bindkey -- "$key[End]"       end-of-line
    [[ -n "$key[Insert]"    ]] && bindkey -- "$key[Insert]"    overwrite-mode
    [[ -n "$key[Backspace]" ]] && bindkey -- "$key[Backspace]" backward-delete-char
    [[ -n "$key[Delete]"    ]] && bindkey -- "$key[Delete]"    delete-char
    [[ -n "$key[Up]"        ]] && bindkey -- "$key[Up]"        up-line-or-history
    [[ -n "$key[Down]"      ]] && bindkey -- "$key[Down]"      down-line-or-history
    [[ -n "$key[Left]"      ]] && bindkey -- "$key[Left]"      backward-char
    [[ -n "$key[Right]"     ]] && bindkey -- "$key[Right]"     forward-char

    bindkey "^R" history-incremental-pattern-search-backward
fi

lazy_source sdk $HOME/.sdkman/bin/sdkman-init.sh
lazy_source cargo $HOME/.cargo/env

# do the vte thing to make tilix work more good
source_this /etc/profile.d/vte.sh

# command line jack enhancements
if cmd_exists 'jack_connect'; then
    source_this ~/dotfiles/zsh-jack-completion/zsh_jack_completion.sh
    alias jackcon="jack_connect"
    alias jackdis="jack_disconnect"
fi

if cmd_exists 'whois'; then
    alias asnlookup="whois -h whois.cymru.com \" -v $1\""
fi

if cmd_exists 'exercism'; then
    alias es='exercism submit'
fi

# reminders
if cmd_exists 'task'; then
    alias tac="task active"
    # burnout charts
    alias tbw="task burndown.weekly"
    alias tbd="task burndown.daily"
    alias ta="task add"
    alias tap="task add +personal"
    alias tas="task add start:now"
    alias taw="task add +work"
    alias taps="task add +personal start:now"
    alias taws="task add +work start:now"
    alias tc="task calendar"
    alias tcy="task calendar $(date +%Y)"
    # barf Current Status to terminal
    task active
fi

# load autojump
if [[ -f /usr/share/autojump/autojump.sh ]]; then
    . /usr/share/autojump/autojump.sh
elif [[ -f /usr/local/share/autojump/autojump.zsh ]]; then
    . /usr/local/share/autojump/autojump.zsh
fi

# vimwiki aliases
VIMWIKI_PATH="$HOME/vimwiki"
if [[ -a $VIMWIKI_PATH ]]; then
    alias wiki="vim -c VimwikiIndex"
    alias note="vim -c VimwikiMakeDiaryNote"
    alias diary="vim -c VimwikiMakeDiaryNote"
    alias notes="vim -c VimwikiDiaryIndex"

    alias blog="vim -c 'let g:vimwiki_list = [wiki_2, wiki_1]' -c VimwikiIndex"
    alias post="vim -c 'let g:vimwiki_list = [wiki_2, wiki_1]' -c VimwikiMakeDiaryNote"
    alias posts="vim -c 'let g:vimwiki_list = [wiki_2, wiki_1]' -c VimwikiDiaryIndex"
fi

if cmd_exists 'ncdu'; then
    alias ncdu='ncdu -e --color dark'
fi

# oontz oontz
if cmd_exists 'mpv'; then
    alias agonist='mpv -playlist http://www.triplag.com/webradio/darkpsy/triplag-darkpsy-playlist.pls'
    alias antagonist='mpv -playlist http://www.triplag.com/webradio/chilltrip/triplag-chilltrip-playlist.pls'
fi

# fix for a sorta-bug on os x
if [[ -a '/usr/local/sbin/mtr' ]]; then
    alias mtr='PATH=/usr/local/sbin:$PATH sudo mtr --displaymode 2 -netz'
fi

# i guess golang-1.8 from debian's repos doesn't get put into $PATH by default
if [[ -a '/usr/lib/go-1.8/bin' ]]; then
    export PATH="$PATH:/usr/lib/go-1.8/bin"
fi

if [[ -a "$HOME/.nvm" ]]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
fi

# set a GOPATH please
if cmd_exists 'go'; then
    export GOPATH="$HOME/.go"
    export PATH=$PATH:"$GOPATH/bin"
fi

# load rbenv .. don't lazyload it, though
if cmd_exists 'rbenv'; then
    eval "$(command rbenv init -)"
fi

# load pyenv. apparently i never set this up
if cmd_exists 'pyenv'; then
    # YouCompleteMe has started complaining about this, so..
    export PYTHON_CONFIGURE_OPTS="--enable-framework"
    eval "$(command pyenv init -)"
fi

# ssh fixes for custom termcaps
if [[ $TERM == 'screen-256color-italic' ]]; then
    alias ssh="TERM=screen-256color ssh"
fi

if [[ $TERM == 'tmux-256color' ]]; then
    alias ssh="TERM=screen-256color ssh"
fi

if [[ $TERM == 'xterm-256color-italic' ]]; then
    alias ssh="TERM=xterm-256color ssh"
fi


if cmd_exists 'vagrant'; then
    alias vagrant-reload='
    for i in $(vagrant global-status | grep virtualbox | awk "{ print $1 }"); do vagrant reload $i; done'
fi

if cmd_exists 'git'; then
    alias gst='git status'
    alias gco='git checkout'
    alias git-sanitize='
    git config --local user.name "Jessie";
    git config --local user.email "mxjessie@users.noreply.github.com"'
    # git % github = hub https://hub.github.com
    if cmd_exists 'hub'; then
        alias git=hub
        alias gpr='git pull-request'
        alias gpup='git push -u'
    fi
    alias git-delete-squashed='
    git checkout -q master && git for-each-ref refs/heads/ "--format=%(refname:short)" | while read branch; do mergeBase=$(git merge-base master $branch) && [[ $(git cherry master $(git commit-tree $(git rev-parse $branch^{tree}) -p $mergeBase -m _)) == "-"* ]] && git branch -D $branch; done'
fi

# rust tweaks. i dunno if these can go anywhere else
if cmd_exists 'cargo'; then
    # this frells up alacritty builds, unfortunately
    #export CARGO_INCREMENTAL=1
    if cmd_exists 'sccache'; then
        export RUSTC_WRAPPER=sccache
    fi
fi

# hey we're on a mac
if cmd_exists 'osascript'; then
    alias stfu='osascript -e "set Volume 0"'
fi

if cmd_exists 'update-repos'; then
    export GIT_REPOS="$GIT_REPOS $HOME/bin $HOME/dotfiles $HOME/dotfiles/* $HOME/Code/* $HOME/Code/personal/*"
fi

# whoa dude
if cmd_exists 'lolcat'; then alias lsd="ls -hal | lolcat -t"; fi

# old tmux muscle memory
if cmd_exists 'tmux'; then alias atmux='tmux -2u attach'; fi

# i usually know what my name is
DEFAULT_USER='jessie'
# lines of history to maintain in memory
export HISTSIZE=1200

# lines of history to maintain in histfile
export SAVEHIST=100000

export HISTFILE="$HOME/.zsh_history"
# append rather than overwrite history file.
setopt APPEND_HISTORY
# allow dups, but expire old dups first
setopt HIST_EXPIRE_DUPS_FIRST
# save timestamp & runtime info
setopt EXTENDED_HISTORY
setopt inc_append_history
setopt share_history
# please don,t beeb beeb because i,m sleep ....
setopt NO_BEEP

# ealias stuff
bindkey ' ' expand-ealias
bindkey '^ ' magic-space
bindkey -M isearch " " magic-space

# doing hte busyness
source_this $HOME/.zshrc-work
