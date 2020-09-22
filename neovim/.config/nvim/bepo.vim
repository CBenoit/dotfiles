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

" [hjkl]<->[ctsr] rotation
call s:amap( 'c',  'h' )  " on préserve {hjkl} pour les directions
call s:amap( 't',  'j' )  " on préserve {hjkl} pour les directions
call s:amap( 's',  'k' )  " on préserve {hjkl} pour les directions
call s:amap( 'r',  'l' )  " on préserve {hjkl} pour les directions
call s:amap( 'C',  'H' )  " {HJKL} devient [CTSR]
call s:amap( 'T',  'J' )  " {HJKL} devient [CTSR]
call s:amap( 'S',  'K' )  " {HJKL} devient [CTSR]
call s:amap( 'R',  'L' )  " {HJKL} devient [CTSR]
call s:amap( 'gt', 'gj' ) " on préserve les variantes avec 'g'
call s:amap( 'gs', 'gk' ) " on préserve les variantes avec 'g'
call s:amap( 'zt', 'zj' ) " on préserve les variantes avec 'z'
call s:amap( 'zs', 'zk' ) " on préserve les variantes avec 'z'
call s:amap( 'h',  'c' )  " {t} devient [h] pour être proche de [f]
call s:amap( 'H',  'C' )  " idem pour {T} et [H]
call s:amap( 'l',  'r' )  " {c} devient [l]
call s:amap( 'L',  'R' )  " {C} devient [L]
call s:amap( 'j',  't' )  " {j} devient [r]
call s:amap( 'J',  'T' )  " {J} devient [R]
call s:amap( 'k',  's' )  " {k} devient [s]
call s:amap( 'K',  'S' )  " {h} devient [S]

" Tabs
call s:amap( 'gb', 'gT' )    "le couple [gb]/[gé] agit sur les tabs
call s:amap( 'gé', 'gt' )    "le couple [gb]/[gé] agit sur les tabs
call s:amap( 'gB', ':execute "silent! tabfirst"<CR>' )    "[gB] va au premier tab
call s:amap( 'gÉ', ':execute "silent! tablast"<CR> ' )    "[gÉ] au dernier

" Tags
call s:amap( 'gT', '<C-]>' )    "[gT] est libéré et peut agir sur les tags

" Bepo-friendly permutations
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
call s:amap( '!', '$' ) " end of line with '!'
call s:amap( '$', '!' ) " pipe on '$'

" Better window control and navigation
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
call s:amap( 'wé', '<C-w>t' )
call s:amap( 'wÉ', '<C-w>T' )

" Surround support
if exists('g:loaded_surround')
    nmap ds  <Plug>Dsurround
    nmap hs  <Plug>Csurround
    nmap hS  <Plug>CSurround
    nmap ys  <Plug>Ysurround
    nmap yS  <Plug>YSurround
    nmap yss <Plug>Yssurround
    nmap ySs <Plug>YSsurround
    nmap ySS <Plug>YSsurround
    xmap S   <Plug>VSurround
    xmap gS  <Plug>VgSurround
endif

" TODO: fugitive

