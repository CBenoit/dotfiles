" >>> VIM Config - Benoît CORTIER <<< "

" Be iMproved (required by Vundle and other stuff).
" This must be first, because it changes other options as side effect.
set nocompatible

" —————————————— PLUGINS ———————————————————
" Vundle initialization
" Avoid modify this section, unless you are very sure of what you are doing

" Setting up Vundle - the vim plugin bundler
let installVundle=0
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle..."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    let installVundle=1
endif

filetype off

" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle
call vundle#begin('~/.vim/bundle/')

" Let Vundle handle Vundle.
Plugin 'gmarik/Vundle.vim', {'name': 'vundle'}

" >> Plugins from github repositories

" To search for a pattern in files.
Plugin 'mileszs/ack.vim'
" A beautiful status/tabline.
Plugin 'bling/vim-airline'
" Provide easy code formatting in Vim by integrating existing code formatters.
Plugin 'Chiel92/vim-autoformat'
" To search for files.
Plugin 'kien/ctrlp.vim'
" To colorize all text in the form #rrggbb or #rgb.
Plugin 'lilydjwg/colorizer'
" Better C++ highlight.
Plugin 'octol/vim-cpp-enhanced-highlight'
" Print documents in echo area.
Plugin 'Shougo/echodoc.vim'
" Help to define and maintain consistent coding styles.
Plugin 'editorconfig/editorconfig-vim'
" Update folds only when called-for.
Plugin 'Konfekt/FastFold'
" An awesome Git wrapper !
Plugin 'tpope/vim-fugitive'
" gdscript syntax file for vim
Plugin 'quabug/vim-gdscript'
" To recognizes .gradle files as being groovy syntax
Plugin 'tfnico/vim-gradle'
" HTML5 omnicomplete and syntax
Plugin 'othree/html5.vim'
" A fuzzy file and buffer explorer !
Plugin 'sjbach/lusty'
" Sublime Text-like multiple cursors feature.
Plugin 'kristijanhusak/vim-multiple-cursors'
" Support for markdown.
Plugin 'plasticboy/vim-markdown'
" Mustache and handlebars mode for vim
Plugin 'mustache/vim-mustache-handlebars'
" Handle completion.
Plugin 'Shougo/neocomplete.vim'
" Racer support (rust autocompletion).
Plugin 'racer-rust/vim-racer'
" Vim configuration for Rust.
Plugin 'rust-lang/rust.vim'
" Various snippets for UltiSnips.
Plugin 'honza/vim-snippets'
" Syntax checking
Plugin 'scrooloose/syntastic'
" Useful plugin to align regions of text.
Plugin 'godlygeek/tabular'
" Excellent solution to handle snippets in Vim.
Plugin 'sirver/ultisnips'
" A collection of vimscripts for Haskell development
Plugin 'dag/vim2hs'
" gmpl syntax
Plugin 'maelvalais/gmpl.vim'

" A beautiful colorscheme.
Plugin 'crusoexia/vim-monokai'

" >> Local plugins

" The pinned flag tells Vundle not to perform any git operation on the plugin,
" while still adding the existing plugin under the bundles directories to the
" runtimepath. Useful to use another version control system than git, or
" to include plugins without one (for instance, plugins from vim.org).

"Plugin 'file://myPluginWithoutGit/', {'pinned': 1}

" All of Plugins must be added before the following line
call vundle#end()

" Install plugins the first time vim runs using this config.

if installVundle == 1
    echo "Installing Bundles, please ignore potential key map error messages"
    echo ""
    :PluginInstall
endif

" ——— Display ———
set title	" Update window / terminal title.
set number	" Display line number.
set ruler	" Display current cursor's position.
set wrap	" Display long lines on several lines.
set linebreak   " Avoid wrap option to split words across two lines (doesn't work when list setting enabled !).
set nolist  " Thus, disabling list setting.
set showbreak=----------------->    " Characters used to show line's breaks.
set scrolloff=3	    " Display at least 3 lines around cursor.
set guioptions-=T   " Remove gvim toolbar.
set guioptions-=r   " Remove right scrollbar.
set guioptions-=L   " Prevent left scrollbar to be present when there is a vertically split window.
set guioptions-=m   " Remove menu.
set noshowmode      " doesn't show the mode in the command line. Airline already show that.

" ——— Search ———
set ignorecase	" Ignore case while searching.
set smartcase	" If search term contain an uppercase it become case sensitive.
set incsearch	" Highlight search results while typing.
set hlsearch	" Highlight search results.

" ——— Beep ———
set novisualbell	" Prevent VIM visual bell (blinking).
set noerrorbells	" Same.

" ——— LaTeX concealing ———

" Enable automatic folding for LaTeX (sections, chapters, etc).
let g:tex_fold_enabled = 1
" Set tex conceal to level 2.
let g:tex_conceal = 2
" Makes sure that text is unconcealed when the cursor is on the same line.
set concealcursor=""
" Concealed superscripts and subscripts often do not look very good. Disabling them.
let g:tex_conceal="adgm"

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

" Hide buffers instead of closing them when opening another buffer in a window.
set hidden

" Enable syntax highlighting.
syntax enable

" Enable file related behaviour such as syntax or indentation.
filetype on
filetype plugin on
filetype indent on

" Use dark monokai.
set background=dark
colorscheme monokai

" Use "DejaVu Sans Mono" font, size 13.
set guifont=DejaVu\ Sans\ Mono\ 13
set antialias

" Highlight hard spaces.
highlight NbSp ctermbg=darkred guibg=darkred
match NbSp /\%xa0/

" ——— Indentation ——
" Number of spaces per tab.
set tabstop=4

" Number of spaces to use for each step of indent.
set shiftwidth=4

" Number of spaces that a <Tab> count while performing editing operations.
set softtabstop=4

" Replace tab by spaces.
set expandtab

" Normal mode.
" Tab to indent line.
nnoremap <Tab> >>
" Shift + Tab to unindent line.
nnoremap <S-Tab> <<

" Insert mode.
" Shift + Tab to unindent line.
inoremap <S-Tab> <C-D>

" Visual mode.
" Tab to indent selected lines.
vnoremap <Tab> >gv
" Shift + Tab to unindent selected lines.
vnoremap <S-Tab> <gv
" ——————————————————

" Save using sudo with :w!!
ca w!! w !sudo tee "%"

" Disable arrows keys.
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" <Esc> alias.
map ii <Esc>
imap ii <Esc>

" Set leader key.
let mapleader="\<Space>"

" Shortcut to save current file.
noremap <leader>w :w<CR>

" Shortcut to quit VIM.
noremap <leader>q :q<CR>

" Shortcut to change to the directory of the currently open file (for all
" windows in Vim).
noremap <leader>cd :cd %:p:h<CR>

" Shortcut to change to the directory of the currently open file (for the
" current window).
noremap <leader>lcd :lcd %:p:h<CR>

" shortcut to replace hardspaces by tildes
noremap <leader>k :%s/ /\~/g<CR>
" shortcut to insert a latex right arrow
inoremap iar \(\rightarrow\)

" Set isbepo variable.
source ~/.vim/conf/isbepo.vim

if isbepo == 1
    " Remap bépo keys to qwerty (except for insert mode).
    source ~/.vim/conf/bepo-qwerty.vim

    " Move through wrapped lines using usual keys.
    noremap s gk
    noremap t gj

    " Remap PageUp and PageDown.
    nnoremap <leader>s <PageUp>
    nnoremap <leader>t <PageDown>

    " Better tab shortcut.
    nnoremap ,t gT
    nnoremap ,s gt

    " Splits
    nnoremap <silent> S :resize -5<CR>
    nnoremap <silent> T :resize +5<CR>
    nnoremap <silent> C :vertical resize -5<CR>
    nnoremap <silent> R :vertical resize +5<CR>
    nnoremap Z <C-W><C-W>
else
    noremap k gk
    noremap j gj

    nnoremap <leader>k <PageUp>
    nnoremap <leader>j <PageDown>

    nnoremap gj gT
    nnoremap gk gt
endif

" ___________ Plugins configuration ________

" >> EditorConfig
" To ensure that editorconfig works well with Tim Pope's fugitive
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" >> CtrlP
" Adding CtrlP shortcut.
let g:ctrlp_map = '<leader>c'

" >> UltiSnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger       = "<c-j>"
let g:UltiSnipsJumpForwardTrigger  = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit = "vertical"

" >> Airline
let g:airline_powerline_fonts            = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline_left_sep                   = '▶'
let g:airline_right_sep                  = '◀'
" Make the statusline appear all the time.
set laststatus=2

" >> FastFold
let g:tex_fold_enabled=1
let g:vimsyn_folding='af'
let g:xml_syntax_folding = 1

" >> HTML5
" Disable all these. I don't need them.
let g:html5_event_handler_attributes_complete = 0
let g:html5_rdfa_attributes_complete = 0
let g:html5_microdata_attributes_complete = 0
let g:html5_aria_attributes_complete = 0

" >> Racer
let g:racer_cmd = "/home/benoit/LocalDev/racer/target/release/racer"
let g:racer_experimental_completer = 1

" >> echodoc
let g:echodoc_enable_at_startup = 1

" >> autoformat
" shortcut to autoformat code.
noremap <F3> :Autoformat<CR>

" >> bigger configurations files
source ~/.vim/conf/lusty.vim
source ~/.vim/conf/ack.vim
source ~/.vim/conf/tabular.vim
source ~/.vim/conf/neocomplete.vim
source ~/.vim/conf/syntastic.vim


