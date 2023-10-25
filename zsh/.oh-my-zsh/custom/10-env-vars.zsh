# terminal
export TERMINAL="wezterm"
export TERM="xterm-256color"
# export TERM="xterm-24bit" # see: https://github.com/syl20bnr/spacemacs/wiki/Terminal

# editor
export EDITOR="hx"
export VISUAL="$EDITOR"
export HELIX_RUNTIME="$HOME/git/helix/runtime"

# pager
export MANPAGER="sh -c 'col -bx | bat --plain --language man'"

# fzf
export FZF_DEFAULT_COMMAND="fd --hidden --exclude .git --exclude node_modules"

# cargo
export CARGO_HOME=~/.cargo

# Rust
export RUST_BACKTRACE=1

# wasmtime
export WASMTIME_HOME="$HOME/.wasmtime"

# path
export PATH="$PATH:$CARGO_HOME/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$WASMTIME_HOME/bin"
export PATH="$PATH:$HOME/.dotnet/tools"

# XDG Base Directory specification
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

# CLI fuzzy finder
if (( $+commands[sk] )); then
    # https://github.com/lotabout/skim
    export FINDER='sk'
else if (( $+commands[fzf] ))
    # https://github.com/junegunn/fzf
    export FINDER='fzf'
fi

# wallpapers path
export WALLPAPERS_DIRECTORY=$HOME/Pictures/wallpapers/

# .NET SDK / Runtime
export DOTNET_ROOT="$HOME/bin/dotnet-sdk"

