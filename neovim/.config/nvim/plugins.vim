"" Autoinstall

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
" A solid language pack for Vim.
Plug 'sheerun/vim-polyglot'
" Quickstart configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'
" Extensions to built-in LSP, for example, providing type inlay hints
Plug 'nvim-lua/lsp_extensions.nvim'
" Autocompletion framework for built-in LSP
Plug 'nvim-lua/completion-nvim'
" Markdown Preview for (Neo)vim
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

"" Git
" A Vim plugin which shows git diff markers in the sign column and stages/previews/undoes hunks and partial hunks.
Plug 'airblade/vim-gitgutter'
" A Git wrapper so awesome, it should be illegal 
Plug 'tpope/vim-fugitive'

"" Search
" fzf integration 
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" make nvim LSP client use FZF
Plug 'ojroques/nvim-lspfuzzy'

"" Motion / Edition
" Plugin to help you stop repeating the basic movement keys
Plug 'takac/vim-hardtime'
" Linewise motions and edits
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
" Comment stuff out
Plug 'tpope/vim-commentary'
" Use CTRL+A/X to create increasing sequence of numbers or letters via visual mode
Plug 'triglav/vim-visual-increment'
" Expand things like {foo,bar}, {1..10} and $HOME inline with a single command
Plug 'Olical/vim-expand'
" Vim plugin that maintains a yank history to cycle between when pasting
Plug 'svermeulen/vim-yoink'

" TODO: plugins to consider:
" TODO: find a plugin adding more useful text-objects as mentioned in subversive README.
" Vim plugin providing operator motions to quickly replace text
"Plug 'svermeulen/vim-subversive'
" unimpaired.vim: Pairs of handy bracket mappings
"Plug 'tpope/vim-unimpaired'

"" Misc
" Vim plugin that shows keybindings in popup
Plug 'liuchengxu/vim-which-key'

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
local nvim_lsp = require'lspconfig'

-- function to attach completion and diagnostics
-- when setting up lsp
local on_attach = function(client)
  -- all `on_attach`s goes here
  require'completion'.on_attach(client)
end

-- Setup some LSP configs
local servers = { "clangd", "rust_analyzer" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup({ on_attach=on_attach })
end

EOF

"" nvim-lspfuzzy

lua require('lspfuzzy').setup {}

"" completion-vim

let g:completion_enable_auto_popup = 0
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy', 'all']
let g:completion_matching_ignore_case = 1

"" lsp_extensions

" Enable type inlay hints
autocmd InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *.rs :lua require'lsp_extensions'.inlay_hints{ prefix = ' » ', highlight = "NonText", enabled = {"ChainingHint"} }

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

"" vim-easymotion

let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
let g:EasyMotion_keys = 'auie,ctsnmpovdlyx.qghbjzkf'
let g:EasyMotion_do_shade = 0

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

"" vim-hardtime

let g:hardtime_default_on = 1
let g:hardtime_timeout = 800
let g:list_of_normal_keys = ["c", "t", "s", "r"] " bépo
let g:list_of_visual_keys = ["c", "t", "s", "r"]
let g:list_of_insert_keys = []
let g:list_of_disabled_keys = []

"" yoink

let g:yoinkSyncNumberedRegisters = 1
let g:yoinkSavePersistently = 1
let g:yoinkSyncSystemClipboardOnFocus = 1
let g:yoinkIncludeDeleteOperations = 1

