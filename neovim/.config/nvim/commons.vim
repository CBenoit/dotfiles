" fonts
set guifont=Fira\ Code

" leader keys
let g:mapleader = "\<space>"
let g:maplocalleader = 'à'

syntax on

"set inccommand=nosplit " TODO: check issue https://github.com/neovim/neovim/issues/12919

" LSP
autocmd Filetype rust setlocal omnifunc=v:lua.vim.lsp.omnifunc
autocmd Filetype cpp setlocal omnifunc=v:lua.vim.lsp.omnifunc
autocmd Filetype c setlocal omnifunc=v:lua.vim.lsp.omnifunc

