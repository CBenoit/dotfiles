alias la='ls --group-directories-first --color=auto -F --almost-all'
alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias grep='grep --color=tty -d skip -n'
alias cp="cp -i"    # confirm before overwriting something
alias da='java -jar /media/data/cloud/dev/Java/diskanalyzer/target/diskanalyzer-0.0.1-SNAPSHOT-jar-with-dependencies.jar'
alias clion='~/LocalSoftwares/clion-2017.1.1/bin/clion.sh'
alias fixit='sudo rm -f /var/lib/pacman/db.lck && sudo pacman-mirrors -g && sudo pacman-key --refresh && yaourt -Syy'
alias alarmit='cvlc --play-and-stop --play-and-exit --quiet /media/data/cloud/media/sounds/notif2.wav'
alias pscheduler='autocmd -i 300 "cvlc --play-and-stop --play-and-exit --quiet /media/data/cloud/media/sounds/notif2.wav"'
alias df='df -h'    # Human-readable sizes
alias free='free -m'    # Show sizes in MB

# fix buggy opera buggy colors with black themes.
alias opera='env GTK2_RC_FILES=/usr/share/themes/Numix/gtk-2.0/gtkrc opera'

function steam() {
    LD_PRELOAD='/usr/$LIB/libstdc++.so.6 /usr/$LIB/libgcc_s.so.1 /usr/$LIB/libxcb.so.1 /usr/$LIB/libgpg-error.so' /usr/bin/steam
}

md() {
    pandoc -s -f markdown -t man "$*" | man -l -
}

alias proxy='export http_proxy=http://proxy.utbm.fr:3128;export HTTPS_PROXY=$http_proxy;export HTTP_PROXY=$http_proxy;export FTP_PROXY=$http_proxy;export https_proxy=$http_proxy;export ftp_proxy=$http_proxy;export NO_PROXY="local-delivery,local-auth";export no_proxy=$NO_PROXY'

alias noproxy='unset http_proxy;unset HTTPS_PROXY;unset HTTP_PROXY;unset FTP_PROXY;unset https_proxy;unset ftp_proxy'

alias dolphin='DESKTOP_SESSION=kde dolphin'
alias okular='DESKTOP_SESSION=kde okular'

alias scrotclip='scrot -s /tmp/tmpscrot.png && xclip -selection c -t image/png /tmp/tmpscrot.png'

alias ankisha='~/scripts/ankisha'
alias ankikan='~/scripts/ankikan'
alias virtualscn='intel-virtual-output && xrandr --output eDP1 --auto --output VIRTUAL1 --auto --right-of eDP1'

