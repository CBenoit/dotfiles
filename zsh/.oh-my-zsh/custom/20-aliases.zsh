alias grep='grep --color=tty -d skip -n'
alias cp="cp -i"    # confirm before overwriting something
alias fixpacman='sudo rm -f /var/lib/pacman/db.lck && sudo pacman-mirrors -g && sudo pacman-key --refresh'
alias df='df -h'    # human-readable sizes
alias free='free -m'    # show sizes in MB
alias latexmk='latexmk -lualatex'
alias fd='fd --follow --hidden'
alias kak='tmux new-session kak'
alias emacs='emacs --no-window-system'
alias nvim='nvim'
alias edit='nvim'
alias e='edit'
alias scrotclip='scrot -s /tmp/tmpscrot.png && xclip -selection c -t image/png /tmp/tmpscrot.png'
alias ssh='TERM=xterm-256color ssh' # for truecolor see: https://github.com/syl20bnr/spacemacs/wiki/Terminal
alias sf='subfilter --time-before 20000 --time-after 40000 --post-replace-pattern "\n" --post-replace-with " "'
alias mount='sudo mount -o umask=000'
alias umount='sudo umount'

# if available, use `trash-cli` instead of `rm`
if (( $+commands[trash] )); then
	alias rm=trash
fi

if (( $+commands[exa] )); then
	alias ls='exa --group-directories-first --time-style=iso --color=auto -F --git'
else
	alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
fi

if (( $+commands[bat] )); then
	alias cat='bat'
fi

# git

if [[ -v FINDER ]]; then
	alias gshow='git show $(git log --pretty=oneline | $FINDER | cut -d" " -f1)'
	alias gstat='git show --stat $(git log --pretty=oneline | $FINDER | cut -d" " -f1)'
fi

gen_compile_commands() {
	if cd $1; then
		cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ..
		success=$?
		cd ..
		if [ "$success" = 0 ]; then
			rm ./compile_commands.json
			ln -s $1/compile_commands.json

			# add some files to local exclude
			if [[ ! $(env cat .git/info/exclude | grep "\(\.clangd\|compile_commands.json\)") ]]; then
				printf "\n# by gen_compile_commands\n.clangd\ncompile_commands.json\n" >> .git/info/exclude
				echo "|== gen_compile_commands ==| Added '.clangd' and 'compile_commands.json' to .git/info/exclude"
			fi
		fi
	fi
}

