" /!\ It may be necessary to update this file regarding LustyExplorer and
" LustyJuggler updates.

" Disable default LustyExplorer mapping.
let g:LustyExplorerDefaultMappings = 0

" Remap the shortcuts.
if isbepo == 1
    nmap <silent> <Leader>f NLustyFilesystemExplorer<CR>
    nmap <silent> <Leader>r NLustyFilesystemExplorerFromHere<CR>
    nmap <silent> <Leader>b NLustyBufferExplorer<CR>
    nmap <silent> <Leader>g NLustyBufferGrep<CR>
else
    nmap <silent> <Leader>f :LustyFilesystemExplorer<CR>
    nmap <silent> <Leader>r :LustyFilesystemExplorerFromHere<CR>
    nmap <silent> <Leader>b :LustyBufferExplorer<CR>
    nmap <silent> <Leader>g :LustyBufferGrep<CR>
endif

" Disable default LustyJuggler mapping as well.
let g:LustyJugglerDefaultMappings = 0

