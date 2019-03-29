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
add-highlighter global/ number-lines -relative -hlcursor
add-highlighter global/ show-matching
add-highlighter global/ wrap -word -indent -marker ↳
add-highlighter global/ show-whitespaces -lf ' '
add-highlighter global/ regex (\+|-|\*|&|=|\\|\?|%|\|-|!|\||->|\.|,|<|>|:|\^|/|~) 0:operator
add-highlighter global/ regex (\(|\)|\[|\]|\{|\}|\;|') 0:delimiters
add-highlighter global/ regex '([  ]+)\n' 1:TrailingSpace

# editorconfig auto load
hook global BufOpenFile .* editorconfig-load
hook global BufNewFile .* editorconfig-load

