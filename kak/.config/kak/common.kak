# To use the System Clipboard (https://github.com/mawww/kakoune/wiki/Registers---Clipboard)
hook global NormalKey y|d|c %{ nop %sh{
	printf %s "$kak_main_reg_dquote" | xsel --input --clipboard
}}

# Avoid the escape key (https://github.com/mawww/kakoune/wiki/Avoid-the-escape-key)
hook global InsertChar , %{ try %{
	exec -draft hH <a-k>,,<ret> d
	exec <esc>
}}

# Use <tab> to select next completion candidate
# (https://github.com/mawww/kakoune/issues/1327#issuecomment-294771918)
hook global InsertCompletionShow .* %{
	map window insert <tab> <c-n>
	map window insert <s-tab> <c-p>
}
hook global InsertCompletionHide .* %{
	unmap window insert <tab> <c-n>
	unmap window insert <s-tab> <c-p>
}

# Options
set-option global tabstop 4
set-option global indentwidth 0
set-option global scrolloff 3,0

# Custom faces
set-face global TrailingSpace default,red
set-face global delimiters rgb:f0d080,default

# Highlighters
hook global WinCreate .* %{
	add-highlighter window/numbers     number-lines -relative -hlcursor
	add-highlighter window/matching    show-matching
	add-highlighter window/wrap        wrap -word -indent -marker ↳
	add-highlighter window/whitespaces show-whitespaces -lf ' '
	add-highlighter window/operators   regex (\+|-|\*|&|=|\\|\?|%|\|-|!|\||->|\.|,|<|>|:|\^|/|~) 0:operator
	add-highlighter window/delimiters  regex (\(|\)|\[|\]|\{|\}|\;|') 0:delimiters
	add-highlighter window/trailing    regex '([  ]+)\n' 1:TrailingSpace
}

# editorconfig auto load
hook global BufOpenFile .* editorconfig-load
hook global BufNewFile .* editorconfig-load

# cd to project root on new window
hook global WinCreate .* %{
	cd-project-root
}

# git stuff
hook global BufWritePost .* %{
	git update-diff
}
hook global BufReload .* %{
	git update-diff
}
hook global WinCreate .* %{
	git show-diff
}

# set ncurse assistant to a cat!
set-option global ui_options ncurses_assistant=cat

# to keep default monokai highlighting while using the gruvbox-dark-soft colors for the rest
# inspired by https://github.com/andreyorst/base16-gruvbox.kak/blob/master/colors/base16-gruvbox-dark-soft.kak
evaluate-commands %sh{
	bg0="rgb:282828"
	bg0_hard="rgb:1d2021"
	bg0_soft="rgb:32302f"
	bg1="rgb:3c3836"
	bg2="rgb:504945"
	bg3="rgb:665c54"
	fg0="rgb:fbf1c7"
	fg0_hard="rgb:f9f5d7"
	fg0_soft="rgb:f2e5bc"
	fg1="rgb:ebdbb2"
	fg2="rgb:d5c4a1"
	fg3="rgb:bdae93"
	fg4="rgb:a89984"
	b_red="rgb:fb4934"
	b_green="rgb:b8bb26"
	b_blue="rgb:83a598"
	yellow_monokai="rgb:e7d756"

	echo "
		face global Default            ${fg0},${bg0_soft}
		face global PrimarySelection   default,${bg2}+g
		face global SecondarySelection default,${bg1}+g
		face global PrimaryCursor      ${bg0},${fg0}+fg
		face global SecondaryCursor    ${bg0},${fg3}+fg
		face global PrimaryCursorEol   ${bg0},${fg2}+fg
		face global SecondaryCursorEol ${bg0},${fg4}+fg
		face global LineNumbers        ${bg3}
		face global LineNumberCursor   ${fg3}
		face global LineNumbersWrapped ${bg0_soft}
		face global MenuForeground     ${fg1},${bg3}+b
		face global MenuBackground     default,${bg2}
		face global MenuInfo           ${b_blue}
		face global Information        ${bg0},${fg4}
		face global Error              ${b_red},default+b
		face global StatusLine         ${fg1},${bg1}
		face global StatusLineMode     ${fg1}
		face global StatusLineInfo     ${fg3}
		face global StatusLineValue    ${b_red}
		face global StatusCursor       ${bg0},${fg0}
		face global Prompt             default
		face global MatchingChar       default,${bg3}
		face global BufferPadding      ${bg0_soft},${bg0_soft}
		face global Whitespace         ${bg2}+f

		face global title     ${b_green}+b
		face global bold      ${fg0}+b
		face global italic    ${fg1}
		face global mono      ${fg2}
		face global block     default
		face global link      ${b_blue}
		face global bullet    ${b_red}
		face global list      default

		face global string ${yellow_monokai}
	"
}

