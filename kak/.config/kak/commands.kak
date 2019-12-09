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

# From https://github.com/andreyorst/dotfiles/blob/master/.config/kak/commands.kak
define-command -docstring "if <condition> <expression> [else [if <condition>] <expression>]: if statement that accepts shell-valid condition string" \
if -params 2.. %{ evaluate-commands %sh{
    while [ true ]; do
        condition="[ $1 ]"
        if [ -n "$3" ] && [ "$3" != "else" ]; then
            printf "%s\n" "fail %{if: unknown operator '$3'}"
        elif [ $# -eq 3 ]; then
            printf "%s\n" "fail %{if: wrong argument count}"
        elif eval $condition; then
            [ -n "${2##*&*}" ] && arg="$2" || arg="$(printf '%s' "$2" | sed 's/&/&&/g')"
            printf "%s\n" "evaluate-commands %& $arg &"
        elif [ $# -eq 4 ]; then
            [ -n "${4##*&*}" ] && arg="$4" || arg="$(printf '%s' "$4" | sed 's/&/&&/g')"
            printf "%s\n" "evaluate-commands %& $arg &"
        elif [ $# -gt 4 ]; then
            if [ "$4" = "if" ]; then
                shift 4
                continue
            else
                printf "%s\n" "fail %{if: wrong argument count}"
            fi
        fi
        exit
    done
}}

