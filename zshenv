func add_to_path() {
    if [[ -a "$1" ]]; then
        export PATH="$1":$PATH
    fi
}

add_to_path $HOME/bin
add_to_path $HOME/bin/atlassian
add_to_path $HOME/go/bin
add_to_path $HOME/.cabal/bin
add_to_path $HOME/.cargo/bin
add_to_path $HOME/.local/bin
add_to_path $HOME/.rbenv/bin
add_to_path /usr/local/rbenv/bin
add_to_path $HOME/.gem/ruby/2.3.0/bin
# apply serpents to apple
add_to_path $HOME/Library/Python/2.7/bin
add_to_path $HOME/Library/Python/3.5/bin
add_to_path $HOME/Library/Python/3.6/bin
add_to_path /opt/puppetlabs/bin

export EDITOR="vim"
