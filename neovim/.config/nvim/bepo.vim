" Original by Micha Moskovic (https://github.com/michamos/vim-bepo/blob/master/plugin/bepo.vim)

if exists('g:loaded_bepo') || &compatible
  finish
else
  let g:loaded_bepo = 1
endif

" s:tomap is for text-objects
function! s:tomap(key, target) abort
  if maparg(a:key, 'o') ==# ''
    execute "onoremap" a:key a:target
  endif
  if maparg(a:key, 'x') ==# ''
    execute "xnoremap" a:key a:target
  endif
endfunction

" s:amap is for the rest
function! s:amap(key, target) abort
  if maparg(a:key, 'n') ==# ''
    execute "nnoremap" a:key a:target
  endif
  call s:tomap(a:key, a:target)
endfunction

""" Vanilla VIM

"" [hjkl]<->[ctsr] rotation

call s:amap( 'c',  'h' )
call s:amap( 't',  'j' )
call s:amap( 's',  'k' )
call s:amap( 'r',  'l' )
call s:amap( 'C',  'H' )
call s:amap( 'T',  'J' )
call s:amap( 'S',  'K' )
call s:amap( 'R',  'L' )
call s:amap( 'gt', 'gj' )
call s:amap( 'gs', 'gk' )
call s:amap( 'zt', 'zj' )
call s:amap( 'zs', 'zk' )
call s:amap( 'h',  'c' )
call s:amap( 'H',  'C' )
call s:amap( 'l',  'r' )
call s:amap( 'L',  'R' )
call s:amap( 'j',  't' )
call s:amap( 'J',  'T' )
call s:amap( 'k',  's' )
call s:amap( 'K',  'S' )

"" Tabs

" [gb]/[gé] for tabs
call s:amap( 'gb', 'gT' )
call s:amap( 'gé', 'gt' )
" goto first tab
call s:amap( 'gB', ':execute "silent! tabfirst"<CR>' )
" goto last tab
call s:amap( 'gÉ', ':execute "silent! tablast"<CR> ' )

"" Tags

call s:amap( 'gT', '<C-]>' )    "[gT] est libéré et peut agir sur les tags

"" Bépo friendly permutations

call s:amap( '«',  '<' )
call s:amap( '»',  '>' )
call s:amap( ';',  ',' )
call s:amap( ',',  ';' )
call s:amap( 'g,',  'g;' )
call s:amap( 'g;',  'g,' )
call s:amap( 'é',  'w' )
call s:amap( 'É',  'W' )
call s:tomap( 'aé',  'aw' )
call s:tomap( 'aÉ',  'aW' )
call s:tomap( 'ié',  'iw' )
call s:tomap( 'iÉ',  'iW' )
" end of line with '!'
call s:amap( '!', '$' )
" pipe on '$'
call s:amap( '$', '!' )

"" Better window control and navigation

call s:amap( 'w',  '<C-w>' )
call s:amap( 'W',  '<C-w><C-w>')
call s:amap( 'wc', '<C-w>h' )
call s:amap( 'wt', '<C-w>j' )
call s:amap( 'ws', '<C-w>k' )
call s:amap( 'wr', '<C-w>l' )
call s:amap( 'wC', '<C-w>H' )
call s:amap( 'wT', '<C-w>J' )
call s:amap( 'wS', '<C-w>K' )
call s:amap( 'wR', '<C-w>L' )
call s:amap( 'wh', '<C-w>s' )
call s:amap( 'wk', '<C-w>c' )
call s:amap( 'wé', '<C-w>t' )
call s:amap( 'wÉ', '<C-w>T' )

