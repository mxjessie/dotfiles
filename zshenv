func add_to_path() {
    if [[ -a "$1" ]]; then
        export PATH="$1":$PATH
    fi
}

add_to_path $HOME/bin
add_to_path $HOME/.cabal/bin
add_to_path $HOME/.local/bin
add_to_path $HOME/.rvm/bin

export EDITOR="vim"
