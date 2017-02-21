func add_to_path() {
    if [[ -a "$1" ]]; then
        export PATH="$1":$PATH
    fi
}

add_to_path $HOME/bin
add_to_path $HOME/.cabal/bin
add_to_path $HOME/.local/bin
add_to_path $HOME/.rvm/bin
add_to_path $HOME/.gem/ruby/2.3.0/bin
# apply serpents to apple
add_to_path $HOME/Library/Python/2.7/bin
add_to_path $HOME/Library/Python/3.5/bin
add_to_path $HOME/Library/Python/3.6/bin

export EDITOR="vim"
