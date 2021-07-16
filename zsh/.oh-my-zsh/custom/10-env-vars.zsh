# terminal
export TERMINAL="alacritty"
export TERM="xterm-24bit" # see: https://github.com/syl20bnr/spacemacs/wiki/Terminal

# editor
export VISUAL="nvim"
export EDITOR="nvim"

# pager
export MANPAGER="nvim -c 'set ft=man' -"

# fzf
export FZF_DEFAULT_COMMAND="fd --hidden --exclude .git --exclude node_modules"

# cargo
export CARGO_HOME=~/.cargo
export CARGO_INCREMENTAL=1

# wasmtime
export WASMTIME_HOME="$HOME/.wasmtime"

# path
export PATH="$PATH:$CARGO_HOME/bin"
export PATH="$PATH:/snap/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$WASMTIME_HOME/bin"
export PATH="$PATH:$HOME/Dev/flutter/bin"

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

# workstation
export IS_WORKSTATION=1

# wallpapers path
if [[ -v IS_WORKSTATION ]]; then
    export WALLPAPERS_DIRECTORY=/home/$USER/Pictures/wallpapers/
else
    export WALLPAPERS_DIRECTORY=/data/media/images/wallpapers/
fi
