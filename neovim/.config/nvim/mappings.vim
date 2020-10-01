""" leader

nnoremap <silent> <leader>q <cmd>qa<CR>
nnoremap <silent> <leader>Q <cmd>qa!<CR>
nnoremap <silent> <leader>* <cmd>Rg<CR>
nnoremap <silent> <leader>. <cmd>Files<CR>
nnoremap <silent> <leader>« <cmd>Buffers<CR>

"" help

let g:which_key_map.h = {
  \ 'name': '+help',
  \ 'k': [':call PromptMappingForKey()', "mappings for key"],
\ }

function! PromptMappingForKey()
  let l:key = nr2char(getchar())
  execute "map" l:key
endfunction

noremap <silent> <leader>hh <cmd>Helptags<CR>
noremap <silent> <leader>hr <cmd>registers<CR>
noremap <silent> <leader>hm <cmd>marks<CR>
noremap <silent> <leader>hj <cmd>jumps<CR>

"" project

let g:which_key_map.p = { 'name': '+project' }

nnoremap <silent> <leader>p* <cmd>Rg<CR>
nnoremap <silent> <leader>p. <cmd>Files<CR>
nnoremap <silent> <leader>pg <cmd>Commits<CR>
" TODO: CD from a path list (projects) "pp"
" TODO: add a path to project list "pa"
" TODO: remove a path to project list "pr"

"" file

let g:which_key_map.f = { 'name': '+file' }

nnoremap <silent> <leader>ff <cmd>Files<CR>
nnoremap <silent> <leader>f. <cmd>Files<CR>
nnoremap <silent> <leader>fp <cmd>Files ~/.config/nvim<CR>
nnoremap <silent> <leader>fr <cmd>History<CR>
nnoremap <silent> <leader>fg <cmd>GFiles<CR>

"" spell

let g:which_key_map.s = {
  \ 'name': '+spell',
  \ '[': ['[s', 'previous misspelled word'],
  \ ']': [']s', 'next misspelled word'],
  \ 's': ['z=', 'suggest spelling'],
  \ 'a': ['zg', 'add word'],
  \ 'w': ['zw', 'mark word as wrong'],
  \ 'e': [':set spell', 'enable spell checking'],
  \ 'd': [':set nospell', 'disable spell checking'],
  \ 't': [':set invspell', 'toggle spell checking'],
\ }

"" buffers

let g:which_key_map.b = { 'name': '+buffers' }

nnoremap <silent> <leader>bb <cmd>Buffers<CR>
nnoremap <silent> <leader>b. <cmd>Buffers<CR>
nnoremap <silent> <leader>bs <cmd>update<CR>
nnoremap <silent> <leader>bS <cmd>wa<CR>
nnoremap <silent> <leader>bd <cmd>bdelete<CR>
nnoremap <silent> <leader>bl <C-^>
nnoremap <silent> <leader>bn <cmd>bn<CR>
nnoremap <silent> <leader>bp <cmd>bp<CR>
nnoremap <silent> <leader>b* <cmd>Lines<CR>
nnoremap <silent> <leader>bg <cmd>BCommits<CR>

"" code

let g:which_key_map.c = {
  \ 'name': '+code',
  \ 'a': [':call luaeval("vim.lsp.buf.code_action()")', 'select a code action'],
  \ 'r': [':call luaeval("vim.lsp.buf.rename()")', 'rename all references'],
  \ 'f': [':call luaeval("vim.lsp.buf.formatting()")', 'format current buffer'],
  \ 'd': [':call luaeval("vim.lsp.buf.definition()")', 'jump to the definition'],
  \ 'D': [':call luaeval("vim.lsp.buf.references()")', 'list all the references'],
  \ 's': [':call Custom_lsp_hover()', 'display hover information'],
  \ 'x': [':OpenDiagnostic', 'list errors'],
  \ '.': [':Filetypes', 'change current filetype'],
\ }

let g:which_key_map.c.l = {
  \ 'name': '+lsp',
  \ 'h': [':call luaeval("vim.lsp.buf.signature_help()")', 'display signature information'],
  \ 'i': [':call luaeval("vim.lsp.buf.implementation()")', 'list all the implementations'],
  \ 't': [':call luaeval("vim.lsp.buf.type_definition()")', 'jump to the definition of the type'],
  \ 'W': [':call luaeval("vim.lsp.buf.workspace_symbol()")', 'list all symbols in the current workspace'],
  \ 's': [':call luaeval("vim.lsp.buf.document_symbol()")', 'list all symbols in the current buffer'],
\ }

let g:which_key_map.c.l.s = {
  \ 'name': '+sessions',
  \ 'c': [':call Custom_count_lsp_clients()', 'count clients attached to current buffer'],
  \ 'r': [':call Custom_reload_lsp()', 'reload LSP'],
\ }

function! Custom_lsp_hover()
  if luaeval("next(vim.lsp.buf_get_clients()) ~= nil")
    lua vim.lsp.buf.hover()
  else
    execute "normal!" "K"
  endif
endfunction

function! Custom_count_lsp_clients()
  if luaeval("next(vim.lsp.buf_get_clients()) ~= nil")
    echo "LSP is enabled in this buffer"
  else
    echo "LSP is NOT enabled in this buffer"
  endif
endfunction

function! Custom_reload_lsp()
  lua vim.lsp.stop_client(vim.lsp.get_active_clients())
  sleep 50m
  execute "edit"
endfunction

"" git

let g:which_key_map.g = { 'name': '+git' }

nnoremap <silent> <leader>gd <cmd>Gdiff<CR>
nnoremap <silent> <leader>ge <cmd>Gedit<CR>
nnoremap <silent> <leader>gm <cmd>Gmerge<CR>
nnoremap <silent> <leader>gr <cmd>Grebase<CR>
nnoremap <silent> <leader>gg <cmd>Gstatus<CR>
nnoremap <silent> <leader>gw <cmd>Gwrite<CR>
nnoremap <silent> <leader>g. <cmd>GFiles<CR>
nnoremap <silent> <leader>gl <cmd>Commits<CR>
nnoremap <silent> <leader>gb <cmd>Gblame<CR>
nmap     <silent> <leader>g] <Plug>(GitGutterNextHunk)
nmap     <silent> <leader>g[ <Plug>(GitGutterPrevHunk)
nmap     <silent> <leader>gp <Plug>(GitGutterPreviewHunk)
nmap     <silent> <leader>gs <Plug>(GitGutterStageHunk)
nmap     <silent> <leader>gx <Plug>(GitGutterUndoHunk)
nmap     <silent> <leader>go <Plug>(git-messenger)

let g:which_key_map.g.f = { 'name': '+file' }

" TODO: nnoremap <silent> <leader>gfm <cmd>Gmove<CR>
nnoremap <silent> <leader>gfd <cmd>Gremove<CR>

let g:which_key_map.g.c = { 'name': '+commit' }

nnoremap <silent> <leader>gcc <cmd>Gcommit<CR>
nnoremap <silent> <leader>gcP <cmd>Gpull<CR>
nnoremap <silent> <leader>gcp <cmd>Gpush<CR>
nnoremap <silent> <leader>gc. <cmd>Commits<CR>
nnoremap <silent> <leader>gcb <cmd>BCommits<CR>

""" localleader


""" better escape shortcuts

inoremap ,c    <ESC><cmd>noh<CR>
vnoremap <ESC> <ESC><cmd>noh<CR>
nnoremap <ESC> <ESC><cmd>noh<CR>
noremap  çç    <ESC>:
inoremap çç    <ESC>:
tnoremap ,c    <C-\><C-n>

""" misc

nnoremap <silent> <M-x> <cmd>Commands<CR>

""" LSP

nnoremap <silent> S  <cmd>call Custom_lsp_hover()<CR>
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.references()<CR>

" Goto previous/next diagnostic warning/error (I don't use tag search)
nnoremap <silent> g[ <cmd>PrevDiagnosticCycle<CR>
nnoremap <silent> g] <cmd>NextDiagnosticCycle<CR>

""" better auto-completion navigation

imap <silent> <C-c> <Plug>(completion_trigger)
nmap          <C-n> <Plug>(completion_smart_tab)
nmap          <C-p> <Plug>(completion_smart_s_tab)

""" custom text objects

" whole buffer
vnoremap ag :<C-u>silent! normal! ggVG<CR>
onoremap ag :<C-u>silent! normal! ggVG<CR>
vnoremap ig :<C-u>silent! normal! ggVG<CR>
onoremap ig :<C-u>silent! normal! ggVG<CR>
