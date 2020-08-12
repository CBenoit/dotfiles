export VISUAL="TERM=xterm-256color emacs -nw"
export EDITOR="TERM=xterm-256color emacs -nw"
export TERMINAL="alacritty"

# cargo
export CARGO_HOME=~/.cargo

# path
export PATH=$PATH:$CARGO_HOME/bin
export PATH=$PATH:/snap/bin
export PATH=$PATH:~/.local/bin

# workstation
# export IS_WORKSTATION=1

# wallpapers path
if (( ${IS_WORKSTATION} )) ; then
    export WALLPAPERS_DIRECTORY=/home/$USER/Pictures/wallpapers/
else
    export WALLPAPERS_DIRECTORY=/data/media/images/wallpapers/
fi
