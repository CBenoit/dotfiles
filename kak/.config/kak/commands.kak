define-command -override -docstring \
"cd to project root using specific files or folders as root markers (CMakeLists.txt, Cargo.toml and .git)" \
cd-project-root %{
	evaluate-commands %sh{
		for i in 1 2 3 4 5 6; do
			if [[ $(env ls -la | grep -E "(CMakeLists\.txt)|(Cargo\.toml)|(\.git)$") ]]; then
				echo "cd $(pwd)"
				break
			else
				cd ..
			fi
		done
	}
}

# From https://github.com/andreyorst/dotfiles/blob/master/.config/kak/commands.kak
define-command -override -docstring \
"select a word under cursor, or add cursor on next occurrence of current selection" \
select-or-add-cursor %{ execute-keys -save-regs '' %sh{
	if [ $(expr $(printf "%s\n" $kak_selection | wc -m) - 1) -eq 1 ]; then
		printf "%s\n" "<a-i>w*"
	else
		printf "%s\n" "*<s-n>"
	fi
}}

