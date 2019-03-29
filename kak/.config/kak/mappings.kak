#=============#
# normal mode #
#=============#

map global normal <a-t> C   -docstring "expand a new cursor below"
map global normal <c-t> 20j -docstring "move 20 down"
map global normal <c-s> 20k -docstring "move 20 up"

map global normal \'    ': comment-line<ret>'         -docstring "comment/uncomment selection"
map global normal <c-w> ': select-or-add-cursor<ret>' -docstring "select word under cursor or add new cursor"
map global normal <a-'> ': comment-block<ret>'        -docstring "comment/uncomment selection (block)"

#===========#
# user mode #
#===========#

map global user w ': w<ret>'                            -docstring "save buffer"
map global user q ': q<ret>'                            -docstring "quit"
map global user , ga                                    -docstring "last buffer"
map global user f ': e '                                -docstring "open file"
map global user b ': b '                                -docstring "change buffer"
map global user d ': db<ret>'                           -docstring "delete current buffer"
map global user t '%s^ +<ret><a-@>'                     -docstring "convert leading spaces to tabs"
map global user T '%s^\t+<ret>@'                        -docstring "convert leading tabs to spaces"
map global user P '!xsel --output --clipboard<ret>'     -docstring 'paste before from system clipboard'
map global user p '<a-!>xsel --output --clipboard<ret>' -docstring 'paste after from system clipboard'
map global user O '|xsel --output --clipboard<ret>'     -docstring 'replace selection with system clipboard'

#====================#
# bépo compatibility #
#====================#
# Remap ankward bindings
# ----------------------

map global normal t j -docstring "move down"
map global goto   t j -docstring "buffer bottom"
map global view   t j -docstring "scroll down"
map global normal T J -docstring "extend down"
map global normal j t -docstring "select to next character"
map global goto   j t -docstring "window top"
map global view   j t -docstring "cursor on top"
map global normal J T -docstring "extend to next character"

map global normal s k -docstring "move up"
map global goto   s k -docstring "buffer top"
map global view   s k -docstring "scroll up"
map global normal S K -docstring "extend up"
map global normal k s -docstring "select regex matches in selected text"
map global normal K S -docstring "split selected text on regex matches"

map global normal r l         -docstring "move right"
map global normal <a-r> <a-l> -docstring "select to line end"
map global goto   r l         -docstring "line end"
map global view   r l         -docstring "scroll right"
map global normal R L         -docstring "extend right"
map global normal <a-R> <a-L> -docstring "extend to line end"
map global normal o r         -docstring "replace with character"
map global normal O R         -docstring "replace selected text with paired yanked text"
map global normal <a-O> <a-R> -docstring "replace selected text with all yanked texts"
map global normal l o         -docstring "insert on new line below"
map global normal <a-l> <a-o> -docstring "add a new empty line below"
map global normal <c-l> <c-o> -docstring "jump backward in jump list"
map global normal L O         -docstring "insert on new line above"
map global normal <a-L> <a-O> -docstring "add a new empty line above"

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

map global normal + (             -docstring "rotate selections"
map global normal <minus> )       -docstring "rotate selections backward"
map global normal <a-+> <a-(>     -docstring "rotate selections content"
map global normal <a-minus> <a-)> -docstring "rotate selections content backward"

map global normal à <a-`>   -docstring "swap case"
map global normal À '<a-;>' -docstring "flip the selections' direction"

