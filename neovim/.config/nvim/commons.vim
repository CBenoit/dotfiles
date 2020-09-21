" fonts
set guifont=Fira\ Code

" leader keys
let g:mapleader = "\<space>"
let g:maplocalleader = 'à'

syntax on

"set inccommand=nosplit " TODO: check issue https://github.com/neovim/neovim/issues/12919

" Completion
set omnifunc=syntaxcomplete#Complete
autocmd Filetype rust setlocal omnifunc=v:lua.vim.lsp.omnifunc
autocmd Filetype cpp setlocal omnifunc=v:lua.vim.lsp.omnifunc
autocmd Filetype c setlocal omnifunc=v:lua.vim.lsp.omnifunc
set completeopt-=preview

" Highlight yanked area
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=300}
augroup END

" Show some hidden characters (:help 'listchars')
set list

