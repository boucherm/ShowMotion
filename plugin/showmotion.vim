highlight MotionGroup cterm=italic,bold ctermbg=16 ctermfg=25
let g:m = 0

function g:CleanPrev()
  if g:m
    call matchdelete(g:m)
    let g:m = 0
  end
  set nocursorcolumn
endfunction

function g:HighW()
  call g:CleanPrev()
  let g:m = matchadd( "MotionGroup", '\(\s\)\@<=\S\%'.line('.').'l\%>'.(col('.')+1).'c' )
  set cursorcolumn
endfunction

function g:HighB()
  call g:CleanPrev()
  let g:m = matchadd( "MotionGroup", '\(\s\)\@<=\S\%'.line('.').'l\%<'.(col('.')+1).'c' )
  set cursorcolumn
endfunction

function g:Highw()
  call g:CleanPrev()
  " thanks to sakkemo from #vim on irc.freenode.org for finding the good regexp
  let g:m = matchadd( "MotionGroup", '\(\<\k\|\>\S\|\s\zs\S\)\%'.line('.').'l\%>'.(col('.')+1).'c' )
  set cursorcolumn
endfunction

function g:Highb()
  call g:CleanPrev()
  let g:m = matchadd( "MotionGroup", '\(\<\k\|\>\S\|\s\zs\S\)\%'.line('.').'l\%<'.(col('.')+1).'c' )
  set cursorcolumn
endfunction


nmap <silent> w w:call g:Highw()<Enter>
nmap <silent> b b:call g:Highb()<Enter>
nmap <silent> W W:call g:HighW()<Enter>
nmap <silent> B B:call g:HighB()<Enter>

nmap <silent> j gj:call g:CleanPrev()<Enter>
nmap <silent> k gk:call g:CleanPrev()<Enter>
nmap <silent> l l:call g:CleanPrev()<Enter>
nmap <silent> h h:call g:CleanPrev()<Enter>

autocmd WinLeave * call g:CleanPrev()
