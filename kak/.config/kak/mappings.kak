#=============#
# normal mode #
#=============#

map global normal <a-t> C     -docstring "expand a new cursor below"
map global normal <a-s> <a-C> -docstring "expand a new cursor above"

map global normal \'    ': comment-line<ret>'         -docstring "comment/uncomment selection"
map global normal <c-w> ': select-or-add-cursor<ret>' -docstring "select word under cursor or add new cursor"
map global normal <a-'> ': comment-block<ret>'        -docstring "comment/uncomment selection (block)"

map global normal , ': eval -- %sh{printf %s "${kak_main_reg_colon}"}<ret>' -docstring 'repeat the last normal-mode command'

# space is my leader key
map global normal <space> , -docstring 'leader'
map global normal <backspace> <space> -docstring 'remove all sels except main'
map global normal <a-backspace> <a-space> -docstring 'remove main sel'

#===========#
# user mode #
#===========#

map global user q ': q<ret>'  -docstring "quit"
map global user Q ': q!<ret>' -docstring "force quit"
map global user . ': e ' -docstring "open file"
map global user « ': b ' -docstring "change buffer"

## help

declare-user-mode help
map global user h ": enter-user-mode help<ret>" -docstring "+help"

# TODO: see how more "exploration" keymaps could be implemented
# let g:which_key_map.h = {
#   \ 'name': '+help',
#   \ 'k': [':call PromptMappingForKey()', "mappings for key"],
# \ }
# function! PromptMappingForKey()
#   let l:key = nr2char(getchar())
#   execute "map" l:key
# endfunction
# noremap <silent> <leader>hh <cmd>Helptags<CR>
# noremap <silent> <leader>hr <cmd>registers<CR>
# noremap <silent> <leader>hm <cmd>marks<CR>
# noremap <silent> <leader>hj <cmd>jumps<CR>

## project

declare-user-mode project
map global user p ": enter-user-mode project<ret>" -docstring "+project"

map global project . ': e ' -docstring "open file"
# TODO: CD from a path list (projects) "pp"
# TODO: add a path to project list "pa"
# TODO: remove a path to project list "pr"

## file

declare-user-mode file
map global user f ": enter-user-mode file<ret>" -docstring "+file"

map global file . ': e ' -docstring "open file"
# TODO: nnoremap <silent> <leader>fp <cmd>Files ~/.config/nvim<CR>

## spell

declare-user-mode spell
map global user s ": enter-user-mode spell<ret>" -docstring "+spell"

## buffers

declare-user-mode buffers
map global user b ": enter-user-mode buffers<ret>" -docstring "+buffers"

map global buffers . ': b ' -docstring "change buffer"
map global buffers s ': write<ret>' -docstring "save buffer"
map global buffers S ': write-all<ret>' -docstring "save all buffers"
map global buffers d ': delete-buffer<ret>' -docstring "delete buffer"
map global buffers l 'ga' -docstring "go to last buffer"
map global buffers n ': buffer-next<ret>' -docstring "go to next buffer"
map global buffers p ': buffer-previous<ret>' -docstring "go to previous buffer"
# TODO: nnoremap <silent> <leader>bg <cmd>BCommits<CR>

## code

declare-user-mode code
map global user c ": enter-user-mode code<ret>" -docstring "+code"

## git

declare-user-mode git
map global user g ": enter-user-mode g<ret>" -docstring "+git"

map global user <a-t> '%s^ +<ret><a-@><space>'              -docstring "convert leading spaces to tabs"
map global user <a-T> '%s^\t+<ret>@<space>'                 -docstring "convert leading tabs to spaces"
map global user P     '!xsel --output --clipboard<ret>'     -docstring 'paste before from system clipboard'
map global user p     '<a-!>xsel --output --clipboard<ret>' -docstring 'paste after from system clipboard'
map global user L     '|xsel --output --clipboard<ret>'     -docstring 'replace selection with system clipboard'

#====================#
# bépo compatibility #
#====================#
# Remap ankward bindings
# ----------------------

# TODO: audit old mappings

map global normal « < -docstring "indent right"
map global normal » > -docstring "indent left"

map global normal t j -docstring "move down"
map global goto   t j -docstring "buffer bottom"
map global view   t j -docstring "scroll down"
map global normal T J -docstring "extend down"
map global normal j t -docstring "select to next character"
map global goto   j t -docstring "window top"
map global view   j t -docstring "cursor on top"
map global normal J T -docstring "extend to next character"

map global normal s k         -docstring "move up"
map global goto   s k         -docstring "buffer top"
map global view   s k         -docstring "scroll up"
map global normal S K         -docstring "extend up"
map global normal k s         -docstring "select regex matches in selected text"
map global normal K S         -docstring "split selected text on regex matches"
map global normal <a-k> <a-s> -docstring "split the current selections on line boundaries"
map global normal <a-b> <a-k> -docstring "keep matching"
map global normal <a-B> <a-K> -docstring "keep not matching"

map global normal r l         -docstring "move right"
map global normal <a-r> <a-l> -docstring "select to line end"
map global goto   r l         -docstring "line end"
map global view   r l         -docstring "scroll right"
map global normal R L         -docstring "extend right"
map global normal <a-R> <a-L> -docstring "extend to line end"
map global normal l r         -docstring "replace with character"
map global normal L R         -docstring "replace selected text with paired yanked text"
map global normal <a-L> <a-R> -docstring "replace selected text with all yanked texts"

map global normal c h         -docstring "move left"
map global normal <a-c> <a-h> -docstring "select to line begin"
map global goto   c h         -docstring "line begin"
map global view   c h         -docstring "scroll left"
map global normal C H         -docstring "extend left"
map global normal <a-C> <a-H> -docstring "extend to line begin"
map global normal h c         -docstring "cut selected text"
map global normal <a-h> <a-c> -docstring "cut selected text without yanking"
map global goto   h c         -docstring "window center"
map global normal H C         -docstring "expand a new cursor below"
map global normal <a-H> <a-C> -docstring "expand a new cursor above"

map global normal + (             -docstring "rotate selections"
map global normal <minus> )       -docstring "rotate selections backward"
map global normal <a-+> <a-(>     -docstring "rotate selections content"
map global normal <a-minus> <a-)> -docstring "rotate selections content backward"

map global normal à ;       -docstring "reduce selections to their cursor"
# map global normal à <a-`>   -docstring "swap case"
map global normal À '<a-;>' -docstring "flip the selections' direction"

