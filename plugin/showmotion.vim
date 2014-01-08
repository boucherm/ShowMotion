"highlight MotionGroup cterm=italic,bold ctermbg=16 ctermfg=4

"let s:bg_color = 16
highlight MotionGroup cterm=italic,bold ctermbg=16
let s:m = 0

function g:CleanMotion()
  if s:m
    call matchdelete(s:m)
    let s:m = 0
  end
endfunction

function g:HighW()
  call g:CleanMotion()
  let s:m = matchadd( "MotionGroup", '\(\s\)\@<=\S\%'.line('.').'l\%>'.(col('.')+1).'c' )
endfunction

function g:HighB()
  call g:CleanMotion()
  let s:m = matchadd( "MotionGroup", '\(\s\)\@<=\S\%'.line('.').'l\%<'.(col('.')+1).'c' )
endfunction

function g:Highw()
  call g:CleanMotion()
  " thanks to sakkemo from #vim on irc.freenode.org for finding the good regexp
  let s:m = matchadd( "MotionGroup", '\(\<\k\|\>\S\|\s\zs\S\)\%'.line('.').'l\%>'.(col('.')+1).'c' )
endfunction

function g:Highb()
  call g:CleanMotion()
  let s:m = matchadd( "MotionGroup", '\(\<\k\|\>\S\|\s\zs\S\)\%'.line('.').'l\%<'.(col('.')+1).'c' )
endfunction


nmap <silent> w w:call g:Highw()<Enter>
nmap <silent> b b:call g:Highb()<Enter>
nmap <silent> W W:call g:HighW()<Enter>
nmap <silent> B B:call g:HighB()<Enter>

autocmd WinLeave * call g:CleanMotion()
autocmd InsertEnter * call g:CleanMotion()
autocmd CursorMoved * call g:CleanMotion()
