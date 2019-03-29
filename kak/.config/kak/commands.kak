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
