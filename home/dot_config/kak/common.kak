# To use the System Clipboard (https://github.com/mawww/kakoune/wiki/Registers---Clipboard)
# TODO: maybe change behaviour
hook global NormalKey y|d|c %{ nop %sh{
    printf %s "$kak_main_reg_dquote" | xsel --input --clipboard
}}

# Avoid the escape key (https://github.com/mawww/kakoune/wiki/Avoid-the-escape-key)
hook global InsertChar c %{ try %{
    exec -draft hH <a-k>,c<ret> d
    exec <esc>
}}

# Indentation (see smarttab.kak plugin configuration in plugins.kak)
set-option global tabstop 4
set-option global indentwidth 4 # 0 for "\t" instead of spaces (however I use smarttab.kak to handle this instead)

# Keep 3 lines and 3 columns visible around cursor when scrolling
set-option global scrolloff 3,3

# Custom faces
set-face global TrailingSpace default,red
set-face global delimiters rgb:f0d080,default
set-face global Important default,default+bu

# Global highlighters
add-highlighter global/numbers     number-lines -relative -hlcursor
add-highlighter global/matching    show-matching
add-highlighter global/wrap        wrap -word -indent -marker '↳'
add-highlighter global/whitespaces show-whitespaces -tab '>' -nbsp '⍽' -spc ' ' -lf ' '
add-highlighter global/operators   regex (\+|-|\*|&|=|\\|\?|%|\|-|!|\||->|\.|,|<|>|:|\^|/|~) 0:operator
add-highlighter global/delimiters  regex "[\(\)\[\]\{\}]" 0:delimiters
add-highlighter global/trailing    regex '([  ]+)$' 1:TrailingSpace
add-highlighter global/todo        regex "(?i)((TODO)|(FIXME)|(BUG)|(PERF)|(NOTE)|(SAFETY)):" 1:Important

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

# display the status bar on top
set-option global ui_options ncurses_status_on_top=true

colorscheme one-darker

# try to auto load editorconfig file
try %{
    editorconfig-load .editorconfig
}

