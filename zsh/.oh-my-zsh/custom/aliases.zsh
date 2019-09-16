alias grep='grep --color=tty -d skip -n'
alias cp="cp -i"    # confirm before overwriting something
alias fixpacman='sudo rm -f /var/lib/pacman/db.lck && sudo pacman-mirrors -g && sudo pacman-key --refresh'
alias alarmit='cvlc --play-and-stop --play-and-exit --quiet /media/data/cloud/media/sounds/notif2.wav'
alias pscheduler='autocmd -i 300 "cvlc --play-and-stop --play-and-exit --quiet /media/data/cloud/media/sounds/notif2.wav"'
alias df='df -h'    # Human-readable sizes
alias free='free -m'    # Show sizes in MB
alias latexmk='latexmk -lualatex -interaction=batchmode -silent'
alias fd='fd --follow --hidden'
alias kak='tmux new-session kak'
alias authy="/usr/bin/electron --app /usr/lib/authy/app.asar"
alias dolphin='DESKTOP_SESSION=kde dolphin'
alias okular='DESKTOP_SESSION=kde okular'
alias scrotclip='scrot -s /tmp/tmpscrot.png && xclip -selection c -t image/png /tmp/tmpscrot.png'
alias virtualscn='intel-virtual-output && xrandr --output eDP1 --auto --output VIRTUAL1 --auto --right-of eDP1'

alias proxy='export http_proxy=http://proxy.utbm.fr:3128;export HTTPS_PROXY=$http_proxy;export HTTP_PROXY=$http_proxy;export FTP_PROXY=$http_proxy;export https_proxy=$http_proxy;export ftp_proxy=$http_proxy;export NO_PROXY="local-delivery,local-auth";export no_proxy=$NO_PROXY'
alias noproxy='unset http_proxy;unset HTTPS_PROXY;unset HTTP_PROXY;unset FTP_PROXY;unset https_proxy;unset ftp_proxy'

if (( $+commands[exa] )) ; then
	alias ls='exa --group-directories-first --time-style=iso --color=auto -F --git'
else
	alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
fi

if (( $+commands[bat] )) ; then
	alias cat='bat'
fi

function steam() {
	LD_PRELOAD='/usr/$LIB/libstdc++.so.6 /usr/$LIB/libgcc_s.so.1 /usr/$LIB/libxcb.so.1 /usr/$LIB/libgpg-error.so' /usr/bin/steam
}

markdown() {
	pandoc -s -f markdown -t man "$*" | man -l -
}
alias md="markdown"

# inspired from: https://github.com/cquery-project/cquery/wiki/Compilation-database
gen_compile_commands() {
	if cd $1; then
		cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ..
		success=$?
		cd ..
		if [ "$success" = 0 ]; then
			ln -s $1/compile_commands.json
		fi
	fi
}

