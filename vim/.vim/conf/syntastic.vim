set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Checkers configuration
" ——————————————————————

" >> Python
" Use Python 3 interpreter to check code.
let g:syntastic_python_python_exec = '/usr/bin/python3'

