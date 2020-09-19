""" Auto-install

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
endif

""" Init

call plug#begin(stdpath('data').'/plugged')

" Defaults everyone can agree on
Plug 'tpope/vim-sensible'
" Retro groove color scheme for Vim
Plug 'morhetz/gruvbox'
" A solid language pack for Vim.
Plug 'sheerun/vim-polyglot'
" Quickstart configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'
" Vim plugin that shows keybindings in popup
Plug 'liuchengxu/vim-which-key'
" A Vim plugin which shows git diff markers in the sign column and stages/previews/undoes hunks and partial hunks.
Plug 'airblade/vim-gitgutter'
" A Git wrapper so awesome, it should be illegal 
Plug 'tpope/vim-fugitive'
" fzf integration 
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Targeted linewise motions and edits
Plug 'yangmillstheory/vim-snipe'
" Jump to any location specified by two characters.
Plug 'justinmk/vim-sneak'
" Vim motions on speed!
Plug 'easymotion/vim-easymotion'
" Quoting/parenthesizing made simple
"Plug 'tpope/vim-surround'
" Enable repeating supported plugin maps with "."
"Plug 'tpope/vim-repeat'
" Vim plugin, insert or delete brackets, parens, quotes in pair
Plug 'jiangmiao/auto-pairs'
" Multiple cursors plugin for vim/neovim
"Plug 'mg979/vim-visual-multi'
" Comment stuff out
"Plug 'tpope/vim-commentary'
" Embed Neovim in your browser.
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
" A nvim plugin designed to make you better at Vim Movements.
Plug 'ThePrimeagen/vim-be-good'

" Initialize plugin system
call plug#end()

""" Configuration

"" nvim-lspconfig
lua << END
require'nvim_lsp'.rust_analyzer.setup{}
require'nvim_lsp'.clangd.setup{}
END

"" which-key
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey 'à'<CR>
set timeoutlen=500

"" gruvbox
colorscheme gruvbox

"" vim-snipe
let g:snipe_jump_tokens = 'auie,ctsnm'
map <leader><leader>f  <Plug>(snipe-f)
map <leader><leader>F  <Plug>(snipe-F)
map <leader><leader>j  <Plug>(snipe-t)
map <leader><leader>J  <Plug>(snipe-T)
map <leader><leader>é  <Plug>(snipe-w)
map <leader><leader>É  <Plug>(snipe-W)
map <leader><leader>w  <Plug>(snipe-w)
map <leader><leader>W  <Plug>(snipe-W)
map <leader><leader>e  <Plug>(snipe-e)
map <leader><leader>E  <Plug>(snipe-E)
map <leader><leader>b  <Plug>(snipe-b)
map <leader><leader>B  <Plug>(snipe-B)
map <leader><leader>ge <Plug>(snipe-ge)
map <leader><leader>gE <Plug>(snipe-gE)
map <leader><leader>]  <Plug>(snipe-f-xp)
map <leader><leader>[  <Plug>(snipe-F-xp)
map <leader><leader>x  <Plug>(snipe-f-x)
map <leader><leader>X  <Plug>(snipe-f-X)
map <leader><leader>r  <Plug>(snipe-f-r)
map <leader><leader>R  <Plug>(snipe-F-r)
map <leader><leader>i  <Plug>(snipe-f-i)
map <leader><leader>I  <Plug>(snipe-F-i)
map <leader><leader>a  <Plug>(snipe-f-a)
map <leader><leader>A  <Plug>(snipe-F-a)

"" vim-sneak
" 2-character Sneak
nmap è <Plug>Sneak_s
xmap è <Plug>Sneak_s
omap è <Plug>Sneak_s
nmap È <Plug>Sneak_S
xmap È <Plug>Sneak_S
omap È <Plug>Sneak_S
" 1-character enhanced 'f'
nmap f <Plug>Sneak_f
omap f <Plug>Sneak_f
xmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap F <Plug>Sneak_F
omap F <Plug>Sneak_F
" 1-character enhanced 't'
nmap j <Plug>Sneak_t
xmap j <Plug>Sneak_t
omap j <Plug>Sneak_t
nmap J <Plug>Sneak_T
xmap J <Plug>Sneak_T
omap J <Plug>Sneak_T
" repeat motion
map , <Plug>Sneak_;
map ; <Plug>Sneak_,

"" vim-easymotion
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
map <leader><leader>t <Plug>(easymotion-j)
map <leader><leader>s <Plug>(easymotion-k)
nmap \ <Plug>(easymotion-overwin-f2)

"" firenvim

let g:firenvim_config = { 
    \ 'globalSettings': {
        \ 'alt': 'all',
    \  },
    \ 'localSettings': {
        \ '.*': {
            \ 'cmdline': 'neovim',
            \ 'priority': 0,
            \ 'selector': 'textarea',
            \ 'takeover': 'never',
        \ },
    \ }
\ }

