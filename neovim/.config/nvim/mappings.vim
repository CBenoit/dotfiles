""" leader

nnoremap <silent> <leader>q <cmd>qa<CR>
nnoremap <silent> <leader>* <cmd>Rg<CR>
nnoremap <silent> <leader>. <cmd>Files<CR>
nnoremap <silent> <leader>« <cmd>Buffers<CR>

"" help
noremap <silent> <leader>hh <cmd>Helptags<CR>
noremap <silent> <leader>hr <cmd>registers<CR>
noremap <silent> <leader>hm <cmd>marks<CR>
noremap <silent> <leader>hj <cmd>jumps<CR>
noremap <silent> <leader>hk <cmd>call PromptMappingForKey()<CR>

"" project
nnoremap <silent> <leader>p* <cmd>Rg<CR>
nnoremap <silent> <leader>p. <cmd>Files<CR>
nnoremap <silent> <leader>pg <cmd>Commits<CR>
" TODO: CD from a path list (projects) "pp"
" TODO: add a path to project list "pa"
" TODO: remove a path to project list "pr"

"" file
nnoremap <silent> <leader>ff <cmd>Files<CR>
nnoremap <silent> <leader>f. <cmd>Files<CR>
nnoremap <silent> <leader>fp <cmd>Files ~/.config/nvim<CR>
nnoremap <silent> <leader>fr <cmd>History<CR>
nnoremap <silent> <leader>fg <cmd>GFiles<CR>

"" buffers
nnoremap <silent> <leader>bb <cmd>Buffers<CR>
nnoremap <silent> <leader>b. <cmd>Buffers<CR>
nnoremap <silent> <leader>bs <cmd>w<CR>
nnoremap <silent> <leader>bS <cmd>wa<CR>
nnoremap <silent> <leader>bq <cmd>bdelete<CR>
nnoremap <silent> <leader>bk <cmd>bdelete<CR>
nnoremap <silent> <leader>bl <C-^>
nnoremap <silent> <leader>bn <cmd>bn<CR>
nnoremap <silent> <leader>bp <cmd>bp<CR>
nnoremap <silent> <leader>b* <cmd>Lines<CR>
nnoremap <silent> <leader>bg <cmd>BCommits<CR>

"" code
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
" fugitive
" TODO: nnoremap <silent> <leader>gfm <cmd>Gmove<CR>
nnoremap <silent> <leader>gd  <cmd>Gdiff<CR>
nnoremap <silent> <leader>ge  <cmd>Gedit<CR>
nnoremap <silent> <leader>gfd <cmd>Gremove<CR>
nnoremap <silent> <leader>gcc <cmd>Gcommit<CR>
nnoremap <silent> <leader>gcP <cmd>Gpull<CR>
nnoremap <silent> <leader>gcp <cmd>Gpush<CR>
nnoremap <silent> <leader>gc. <cmd>Commits<CR>
nnoremap <silent> <leader>gcb <cmd>BCommits<CR>
nnoremap <silent> <leader>gm  <cmd>Gmerge<CR>
nnoremap <silent> <leader>gr  <cmd>Grebase<CR>
nnoremap <silent> <leader>gg  <cmd>Gstatus<CR>
nnoremap <silent> <leader>gw  <cmd>Gwrite<CR>
" fzf + fugitive
nnoremap <silent> <leader>g. <cmd>GFiles<CR>
nnoremap <silent> <leader>gl <cmd>Commits<CR>
nnoremap <silent> <leader>gb <cmd>Gblame<CR>
" git gutter
nmap <silent> <leader>g] <Plug>(GitGutterNextHunk)
nmap <silent> <leader>g[ <Plug>(GitGutterPrevHunk)
nmap <silent> <leader>gp <Plug>(GitGutterPreviewHunk)
nmap <silent> <leader>gs <Plug>(GitGutterStageHunk)
nmap <silent> <leader>gx <Plug>(GitGutterUndoHunk)
" git messenger (TODO: add git-messenger plugin)
nmap <silent> <leader>go <Plug>(git-messenger)

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

""" helpers

function! PromptMappingForKey()
  let key = nr2char(getchar())
  execute "map" key
endfunction

