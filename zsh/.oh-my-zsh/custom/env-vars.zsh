# terminal
export TERMINAL="alacritty"
export TERM="xterm-24bit" # see: https://github.com/syl20bnr/spacemacs/wiki/Terminal

# editor
export VISUAL="nvim"
export EDITOR="nvim"

# fzf
export FZF_DEFAULT_COMMAND="fd --hidden"

# cargo
export CARGO_HOME=~/.cargo

# path
export PATH=$PATH:$CARGO_HOME/bin
export PATH=$PATH:/snap/bin
export PATH=$PATH:~/.local/bin

# workstation
#export IS_WORKSTATION=1

# wallpapers path
if (( ${IS_WORKSTATION} )) ; then
    export WALLPAPERS_DIRECTORY=/home/$USER/Pictures/wallpapers/
else
    export WALLPAPERS_DIRECTORY=/data/media/images/wallpapers/
fi
