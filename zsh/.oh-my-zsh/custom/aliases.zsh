alias grep='grep --color=tty -d skip -n'
alias cp="cp -i"    # confirm before overwriting something
alias fixpacman='sudo rm -f /var/lib/pacman/db.lck && sudo pacman-mirrors -g && sudo pacman-key --refresh'
alias df='df -h'    # human-readable sizes
alias free='free -m'    # show sizes in MB
alias latexmk='latexmk -lualatex'
alias fd='fd --follow --hidden'
alias kak='tmux new-session kak'
alias emacs='TERM=xterm-256color emacs --no-window-system'
alias nvim='TERM=xterm-256color nvim'
alias edit='nvim'
alias e='edit'
alias scrotclip='scrot -s /tmp/tmpscrot.png && xclip -selection c -t image/png /tmp/tmpscrot.png'
alias ssh='TERM=xterm-256color ssh' # for truecolor see: https://github.com/syl20bnr/spacemacs/wiki/Terminal
alias sf='subfilter --time-before 20000 --time-after 40000 --post-replace-pattern "\n" --post-replace-with " "'

if (( $+commands[exa] )) ; then
	alias ls='exa --group-directories-first --time-style=iso --color=auto -F --git'
else
	alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
fi

if (( $+commands[bat] )) ; then
	alias cat='bat'
fi

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

