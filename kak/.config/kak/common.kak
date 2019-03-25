add-highlighter global/ number-lines -relative

# To use the System Clipboard (https://github.com/mawww/kakoune/wiki/Registers---Clipboard)
hook global NormalKey y|d|c %{ nop %sh{
  printf %s "$kak_main_reg_dquote" | xclip --i
}}
map global user P '!xclip -o<ret>' -docstring 'paste before from system clipboard'
map global user p '<a-!>xclip -o<ret>' -docstring 'paste after from system clipboard'

# Avoid the escape key (https://github.com/mawww/kakoune/wiki/Avoid-the-escape-key)
hook global InsertChar , %{ try %{
  exec -draft hH <a-k>,,<ret> d
  exec <esc>
}}

# Use <tab> to select next completion candidate
# (https://github.com/mawww/kakoune/issues/1327#issuecomment-294771918)
hook global InsertCompletionShow .* %{ map window insert <tab> <c-n>; map window insert <backtab> <c-p> }
hook global InsertCompletionHide .* %{ unmap window insert <tab> <c-n>; unmap window insert <backtab> <c-p> }

# Tabstop and indentwidth
set-option global tabstop 4
set-option global indentwidth 4

