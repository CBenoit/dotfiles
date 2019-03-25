" Add some shortcuts to use tabular.

if isbepo == 1
    nmap <leader>a= NTabularize /=<CR>
    vmap <leader>a= NTabularize /=<CR>

    nmap <leader>a: NTabularize /:\zs<CR>
    vmap <leader>a: NTabularize /:\zs<CR>
else
    nmap <leader>a= :Tabularize /=<CR>
    vmap <leader>a= :Tabularize /=<CR>

    nmap <leader>a: :Tabularize /:\zs<CR>
    vmap <leader>a: :Tabularize /:\zs<CR>
endif

