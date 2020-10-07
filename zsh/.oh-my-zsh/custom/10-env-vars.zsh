# terminal
export TERMINAL="alacritty"
export TERM="xterm-24bit" # see: https://github.com/syl20bnr/spacemacs/wiki/Terminal

# editor
export VISUAL="nvim"
export EDITOR="nvim"

# pager
export MANPAGER="nvim -c 'set ft=man' -"

# fzf
export FZF_DEFAULT_COMMAND="fd --hidden"

# cargo
export CARGO_HOME=~/.cargo

# path
export PATH=$PATH:$CARGO_HOME/bin
export PATH=$PATH:/snap/bin
export PATH=$PATH:~/.local/bin

# XDG Base Directory specification

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

# CLI fuzzy finder

if (( $+commands[sk] )); then
    # https://github.com/lotabout/skim
    FINDER='sk'
else if (( $+commands[fzf] ))
    # https://github.com/junegunn/fzf
    FINDER='fzf'
fi

# workstation
export IS_WORKSTATION=1

# wallpapers path
if [[ -v IS_WORKSTATION ]]; then
    export WALLPAPERS_DIRECTORY=/home/$USER/Pictures/wallpapers/
else
    export WALLPAPERS_DIRECTORY=/data/media/images/wallpapers/
fi