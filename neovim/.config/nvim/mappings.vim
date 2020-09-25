""" leader

nnoremap <silent> <leader>q <cmd>qa<CR>
nnoremap <silent> <leader>* <cmd>Rg<CR>
nnoremap <silent> <leader>. <cmd>Files<CR>
nnoremap <silent> <leader>« <cmd>Buffers<CR>

"" help

function! PromptMappingForKey()
  let l:key = nr2char(getchar())
  execute "map" l:key
endfunction

let g:which_key_map.h = {
  \ 'name': '+help',
  \ 'k': [':call PromptMappingForKey()', "mappings for key"],
\ }

noremap <silent> <leader>hh <cmd>Helptags<CR>
noremap <silent> <leader>hr <cmd>registers<CR>
noremap <silent> <leader>hm <cmd>marks<CR>
noremap <silent> <leader>hj <cmd>jumps<CR>

"" project

let g:which_key_map.p = { 'name' : '+project' }

nnoremap <silent> <leader>p* <cmd>Rg<CR>
nnoremap <silent> <leader>p. <cmd>Files<CR>
nnoremap <silent> <leader>pg <cmd>Commits<CR>
" TODO: CD from a path list (projects) "pp"
" TODO: add a path to project list "pa"
" TODO: remove a path to project list "pr"

"" file

let g:which_key_map.f = { 'name' : '+file' }

nnoremap <silent> <leader>ff <cmd>Files<CR>
nnoremap <silent> <leader>f. <cmd>Files<CR>
nnoremap <silent> <leader>fp <cmd>Files ~/.config/nvim<CR>
nnoremap <silent> <leader>fr <cmd>History<CR>
nnoremap <silent> <leader>fg <cmd>GFiles<CR>

"" spell

let g:which_key_map.s = {
  \ 'name' : '+spell',
  \ '[': ['[s', 'previous misspelled word'],
  \ ']': [']s', 'next misspelled word'],
  \ 's': ['z=', 'suggest spelling'],
  \ 'a': ['zg', 'add word'],
  \ 'w': ['zw', 'mark word as wrong'],
  \ 'e': [':set spell', 'enable spellcheck'],
  \ 'd': [':set nospell', 'disable spellcheck'],
\ }

"" buffers

let g:which_key_map.b = { 'name' : '+buffers' }

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

let g:which_key_map.c = { 'name' : '+code' }

nnoremap <silent> <leader>ch <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <leader>cr <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>ca <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <leader>cf <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <silent> <leader>cd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <leader>cD <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> <leader>ci <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <leader>ct <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> <leader>cW <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> <leader>cs <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> <leader>cS <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <leader>cl <cmd>Filetypes<CR>

"" git

let g:which_key_map.g = { 'name' : '+git' }

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

let g:which_key_map.g.f = { 'name' : '+file' }

" TODO: nnoremap <silent> <leader>gfm <cmd>Gmove<CR>
nnoremap <silent> <leader>gfd <cmd>Gremove<CR>

let g:which_key_map.g.c = { 'name' : '+commit' }

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

nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.references()<CR>

""" better auto-completion navigation

inoremap <silent> <C-c> <C-x><C-o>

""" custom text objects

" whole buffer
vnoremap ag :<C-u>silent! normal! ggVG<CR>
onoremap ag :<C-u>silent! normal! ggVG<CR>
vnoremap ig :<C-u>silent! normal! ggVG<CR>
onoremap ig :<C-u>silent! normal! ggVG<CR>

