" fonts
set guifont=Fira\ Code

" leader keys
let g:mapleader      = "\<space>"
let g:maplocalleader = 'à'

syntax on

"set inccommand=nosplit " TODO: check issue https://github.com/neovim/neovim/issues/12919

set spelllang=en,fr,cjk

" Completion
set completeopt-=preview
set omnifunc=syntaxcomplete#Complete
autocmd Filetype rust setlocal omnifunc=v:lua.vim.lsp.omnifunc
autocmd Filetype cpp setlocal omnifunc=v:lua.vim.lsp.omnifunc
autocmd Filetype c setlocal omnifunc=v:lua.vim.lsp.omnifunc

" Highlight yanked area
augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=100}
augroup END

" Show some hidden characters (:help 'listchars')
set list

