" enable syntax highlighting
syntax on

" enable loading plugin and ident for specific file types
filetype plugin indent on

" shows effects of some commands incrementally
set inccommand=nospliT

" languages to spell check
set spelllang=en,fr,cjk

" show some hidden characters (:help 'listchars')
set list

" have a fixed column for the diagnostics to appear in
" this removes the jitter when warnings/errors flow in
set signcolumn=yes

" fonts
set guifont=Fira\ Code

" set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300

" LSP highlighting
autocmd CursorHold  * lua vim.lsp.buf.document_highlight()
autocmd CursorHoldI * lua vim.lsp.buf.document_highlight()
autocmd CursorMoved * lua vim.lsp.buf.clear_references()

" leader keys
let g:mapleader      = "\<space>"
let g:maplocalleader = 'à'

" completion
set completeopt=menuone,noinsert,noselect
set shortmess+=c

" highlight yanked area
augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=100}
augroup END

