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

alias gsha='git rev-parse HEAD' # last commit hash

if [[ -v FINDER ]]; then
	# TODO: preview commits using git show ${HASH}

	alias gshow='HASH=$(git log --pretty=oneline | $FINDER) && git show $(echo $HASH | cut -d" " -f1)'
	alias gstat='HASH=$(git log --pretty=oneline | $FINDER) && git show --stat $(echo $HASH | cut -d" " -f1)'
	alias ge='FILES=$(git status --porcelain=v1 | $FINDER -m) && e $(echo $FILES | cut -d" " -f3)'
	alias grebase='HASH=$(git log --pretty=oneline | head -n 50 | $FINDER) && git rebase -i --autosquash $(echo ${HASH} | cut -d" " -f1)~1'
	alias greset='HASH=$(git log --pretty=oneline | head -n 50 | $FINDER) && git reset --soft $(echo ${HASH} | cut -d" " -f1)~1'
	alias gfixup='HASH=$(git log --pretty=oneline | head -n 100 | $FINDER) && HASH=$(echo ${HASH} | cut -d" " -f1) && git commit --fixup ${HASH} && GIT_SEQUENCE_EDITOR=: git rebase -i --autosquash ${HASH}~1'
	alias gadd='FILES=$(git status --porcelain=v1 | $FINDER -m) && git add --all $(echo $FILES | cut -d" " -f3)'
	alias glog='HASH=$(git log --pretty=oneline | head -n 100 | $FINDER) && echo ${HASH} | cut -d" " -f1 | tr -d "\n" | xclip -i -sel p -f | xclip -i -sel c -f'

	ggrep() {( set -e
		SELECTED_COMMIT=$(git log --pretty=oneline | $FINDER)
		SELECTED_COMMIT_HASH=$(echo "${SELECTED_COMMIT}" | cut -d" " -f1)
		RESULT=$($FINDER -c "git grep -i -n --no-color --column -e '{}' ${SELECTED_COMMIT_HASH}" -d":" --preview 'git_bat_preview.sh {1} {2} {3}')
		HASH=$(echo ${RESULT} | cut -d":" -f1)
		FILE=$(echo ${RESULT} | cut -d":" -f2)
		LINE=$(echo ${RESULT} | cut -d":" -f3)
		COLUMN=$(echo ${RESULT} | cut -d":" -f4)
		HASH_SHORT=$(echo ${HASH} | cut -c-8)
		git show "${HASH}:${FILE}" | nvim -M -c "file git://${HASH_SHORT}:${FILE}" -c "${LINE}" -c "normal! ${COLUMN}|" -c "set nomodified" -c "filetype detect" -
	)}

	# TODO: gdiff with https://git-scm.com/docs/git-range-diff
	# TODO: glog to copy commit hash using `xsel`
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

