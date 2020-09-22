""" leader

nnoremap <silent> <leader>q <cmd>qa<CR>
nnoremap <silent> <leader>* <cmd>Rg<CR>
nnoremap <silent> <leader>. <cmd>Files<CR>
nnoremap <silent> <leader>« <cmd>Buffers<CR>

" help
noremap <silent> <leader>ht <cmd>Helptags<CR>

" project
nnoremap <silent> <leader>pg <cmd>Commits<CR>

" file
nnoremap <silent> <leader>ff <cmd>Files<CR>
nnoremap <silent> <leader>fp <cmd>Files ~/.config/nvim<CR>
nnoremap <silent> <leader>fr <cmd>History<CR>
nnoremap <silent> <leader>fg <cmd>GFiles<CR>

" buffers
nnoremap <silent> <leader>bb <cmd>Buffers<CR>
nnoremap <silent> <leader>bs <cmd>w<CR>
nnoremap <silent> <leader>bS <cmd>wa<CR>
nnoremap <silent> <leader>bq <cmd>bdelete<CR>
nnoremap <silent> <leader>bk <cmd>bdelete<CR>
nnoremap <silent> <leader>bl <C-^>
nnoremap <silent> <leader>bn <cmd>bn<CR>
nnoremap <silent> <leader>bp <cmd>bp<CR>
nnoremap <silent> <leader>bf <cmd>Lines<CR>
nnoremap <silent> <leader>bg <cmd>BCommits<CR>

" code
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

" git
nnoremap <silent> <leader>gf  <cmd>GFiles<CR>
nnoremap <silent> <leader>gcp <cmd>Commits<CR>
nnoremap <silent> <leader>gcb <cmd>BCommits<CR>
nnoremap <silent> <leader>gg  <cmd>Gstatus<CR>
nnoremap <silent> <leader>gb  <cmd>Gblame<CR>
nnoremap <silent> <leader>gl  <cmd>Glog<CR>
nmap     <silent> <leader>g]  <Plug>(GitGutterNextHunk)
nmap     <silent> <leader>g[  <Plug>(GitGutterPrevHunk)
nmap     <silent> <leader>gp  <Plug>(GitGutterPreviewHunk)
nmap     <silent> <leader>gs  <Plug>(GitGutterStageHunk)
nmap     <silent> <leader>gx  <Plug>(GitGutterUndoHunk)
                  
""" localleader

""" better escape shortcuts
inoremap ,c    <ESC><cmd>noh<CR>
vnoremap <ESC> <ESC><cmd>noh<CR>
nnoremap <ESC> <ESC><cmd>noh<CR>
noremap  çç    <ESC>:
inoremap çç    <ESC>:
tnoremap ,c    <C-\><C-n>

""" misc
nmap <C-t> 15t
nmap <C-s> 15s
nnoremap <silent> <M-x> <cmd>Commands<CR>

""" LSP
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.references()<CR>

""" better auto-completion navigation
inoremap <silent> <C-c> <C-x><C-o>

""" custom text objects

" whole buffer
vnoremap ag :<C-u>silent! normal! ggVG<CR>
onoremap ag :<C-u>silent! normal! mwggVG<CR>'wzz
vnoremap ig :<C-u>silent! normal! ggVG<CR>
onoremap ig :<C-u>silent! normal! mwggVG<CR>'wzz

