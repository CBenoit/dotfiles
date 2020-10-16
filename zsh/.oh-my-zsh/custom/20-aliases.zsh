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

if (( $+commands[procs] )) ; then
	alias ps='procs'
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

## git

# last commit hash
alias gsha='git rev-parse HEAD'

# quick local branches clean up
alias gcleanbranches='BRANCHS=$(git branch | env grep -v "\( \(master\|dev\|main\|develop\)\|\*.*\)$") && echo "$BRANCHS" | xargs git branch -D'

if [[ -v FINDER ]]; then
	alias gshow='HASH=$(git_browse_logs.sh) && git show "$HASH"'
	alias gstat='HASH=$(git_browse_logs.sh) && git show --stat "$HASH"'
	alias ge='FILES=$(git_browse_status.sh) && e "$FILES"'
	alias grebase='HASH=$(git_browse_logs.sh) && git rebase -i --autosquash "$HASH"~1'
	alias greset='HASH=$(git_browse_logs.sh) && git reset --soft "$HASH"~1'
	alias gfixup='HASH=$(git_browse_logs.sh) && git commit --fixup "$HASH" && GIT_SEQUENCE_EDITOR=: git rebase -i --autosquash "$HASH"~1'
	alias gadd='FILES=$(git_browse_status.sh) && git add --all "$FILES"'
	alias glog='git_browse_logs.sh | tr -d "\n" | xclip -i -sel p -f | xclip -i -sel c -f'
	# git diff a89424ddbebb55b01fb8425544323b2f4d70fea7~1..b9110f3281776d9fc74e9d4db53f95da1cef22ac
	# git diff --stat a89424ddbebb55b01fb8425544323b2f4d70fea7~1..b9110f3281776d9fc74e9d4db53f95da1cef22ac

	ggrep() {( set -e
		SELECTED_COMMIT_HASH=$(git_browse_logs.sh)
		export SKIM_DEFAULT_OPTIONS='--color=current_bg:24'
		export FZF_DEFAULT_OPTS='--color=bg+:24'
		RESULT=$("$FINDER" -c "git grep -i -n --no-color --column -e '{}' $SELECTED_COMMIT_HASH" -d":" --preview 'git_bat_preview.sh {1} {2} {3}')
		HASH=$(echo "$RESULT" | cut -d":" -f1)
		FILE=$(echo "$RESULT" | cut -d":" -f2)
		LINE=$(echo "$RESULT" | cut -d":" -f3)
		COLUMN=$(echo "$RESULT" | cut -d":" -f4)
		HASH_SHORT=$(echo "$HASH" | cut -c-8)
		git show "${HASH}:${FILE}" | nvim -M -c "file git://${HASH_SHORT}:${FILE}" -c "$LINE" -c "normal! $COLUMN|" -c "set nomodified" -c "filetype detect" -
	)}
fi

