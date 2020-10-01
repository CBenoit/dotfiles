""" Autoinstall

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
endif

""" Init

call plug#begin(stdpath('data').'/plugged')

" Defaults everyone can agree on
Plug 'tpope/vim-sensible'

" TODO: should I consider a move to a curated bepo config?
" A vim plugin that remaps and adds loads of vim keymaps for Bépo keyboard
"Plug 'sheoak/vim-bepoptimist'

"" Colorschemes
" Retro groove color scheme for Vim
Plug 'morhetz/gruvbox'
" High Contrast & Vivid Color Scheme based on Monokai Pro
Plug 'sainnhe/sonokai'
" A dark Vim/Neovim color scheme inspired by Atom's One Dark syntax theme.
Plug 'joshdick/onedark.vim'

"" Languages
" Quickstart configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'
" Extensions to built-in LSP, for example, providing type inlay hints
Plug 'bcortier-devolutions/lsp_extensions.nvim' " FIXME: this is my fork removing an annoying mapping
" Autocompletion framework for built-in LSP
Plug 'nvim-lua/completion-nvim'
" Diagnostic navigation and settings for built-in LSP
Plug 'nvim-lua/diagnostic-nvim'

"" Git
" A Vim plugin which shows git diff markers in the sign column and stages/previews/undoes hunks and partial hunks.
Plug 'airblade/vim-gitgutter'
" A Git wrapper so awesome, it should be illegal 
Plug 'tpope/vim-fugitive'

"" Search
" fzf integration 
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"" Motion / Edition
" Targeted linewise motions and edits
Plug 'yangmillstheory/vim-snipe'
" Jump to any location specified by two characters.
Plug 'justinmk/vim-sneak'
" Vim motions on speed!
Plug 'easymotion/vim-easymotion'
" Quoting/parenthesizing made simple
Plug 'tpope/vim-surround'
" Enable repeating supported plugin maps with "."
Plug 'tpope/vim-repeat'
" Vim plugin, insert or delete brackets, parenthesis, quotes in pair
Plug 'jiangmiao/auto-pairs'
" Multiple cursors plugin for vim/neovim
"Plug 'mg979/vim-visual-multi'
" Comment stuff out
Plug 'tpope/vim-commentary'
" TODO: find a plugin that add more useful text-objects as mentioned
" in subversive README.
" Vim plugin providing operator motions to quickly replace text
"Plug 'svermeulen/vim-subversive'
" Plugin that adds a 'cut' operation separate from 'delete'
"Plug 'svermeulen/vim-cutlass'
" TODO: I'm not yet sure about whether I want this plugin or not, I need to
" first consider cutlass
" Vim plugin that maintains a yank history to cycle between when pasting
"Plug 'svermeulen/vim-yoink'
" unimpaired.vim: Pairs of handy bracket mappings
"Plug 'tpope/vim-unimpaired'

"" Misc
" Vim plugin that shows keybindings in popup
Plug 'liuchengxu/vim-which-key'

"" Games
" A nvim plugin designed to make you better at Vim Movements.
Plug 'ThePrimeagen/vim-be-good'

"" Browser integration
" Embed Neovim in your browser.
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

" Initialize plugin system
call plug#end()

""" Configuration

"" theming

colorscheme sonokai

"" nvim-lspconfig + completion-nvim + diagnostic-nvim

lua << EOF

-- nvim_lsp object
local nvim_lsp = require'nvim_lsp'

-- function to attach completion and diagnostics
-- when setting up lsp
local on_attach = function(client)
    require'completion'.on_attach(client)
    require'diagnostic'.on_attach(client)
end

-- Setup some LSP configs
nvim_lsp.rust_analyzer.setup({ on_attach=on_attach })
nvim_lsp.clangd.setup({ on_attach=on_attach })

EOF

"" completion-vim

let g:completion_enable_auto_popup = 0
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy', 'all']
let g:completion_matching_ignore_case = 1

"" diagnostic-nvim

let g:diagnostic_enable_virtual_text = 1
"let g:diagnostic_insert_delay = 1

"" lsp_extensions

" Enable type inlay hints
autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost * lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment" }

"" which-key

set timeoutlen=500

nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey 'à'<CR>

let g:which_key_map = { '<Space>': { 'name': 'more movements' } }
call which_key#register('<Space>', "g:which_key_map")

let g:which_key_map_local = {}
call which_key#register('à', "g:which_key_map_local")

"" vim-snipe

let g:snipe_jump_tokens = 'auie,ctsnmpovdlyx.qghbjzkf'

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
map <leader><leader>X  <Plug>(snipe-F-x)
map <leader><leader>l  <Plug>(snipe-f-l)
map <leader><leader>L  <Plug>(snipe-F-l)
map <leader><leader>i  <Plug>(snipe-f-i)
map <leader><leader>I  <Plug>(snipe-F-i)
map <leader><leader>a  <Plug>(snipe-f-a)
map <leader><leader>A  <Plug>(snipe-F-a)

"" vim-easymotion

let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
let g:EasyMotion_keys = 'auie,ctsnmpovdlyx.qghbjzkf'
let g:EasyMotion_do_shade = 0

map  <leader><leader>t <Plug>(easymotion-j)
map  <leader><leader>s <Plug>(easymotion-k)
nmap \                 <Plug>(easymotion-overwin-f2)

"" firenvim

let g:firenvim_config = { 
  \ 'globalSettings': {
    \ 'alt': 'all',
  \ },
  \ 'localSettings': {
    \ '.*': {
      \ 'cmdline': 'neovim',
      \ 'priority': 0,
      \ 'selector': 'textarea',
      \ 'takeover': 'never',
    \ },
  \ }
\ }

"" surround

let g:surround_no_mappings = 1

nmap dk <Plug>Dsurround
nmap hk <Plug>Csurround
nmap hK <Plug>CSurround
nmap k  <Plug>Ysurround
nmap K  <Plug>YSurround
xmap k  <Plug>VSurround
xmap K  <Plug>VgSurround
nmap kk <Plug>Yssurround
nmap KK <Plug>YSsurround

"" vim-sneak support

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

"" fugitive

" TODO: bépo friendliness in status menu

