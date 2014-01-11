"highlight MotionGroup cterm=italic,bold ctermbg=16 ctermfg=4
"highlight MotionGroup cterm=underline,italic,bold ctermbg=16
highlight MotionGroup cterm=underline,italic ctermbg=16

"--- ID of the highlighting group
let s:id = 0

"--- Clean Motion highlighting
function g:CleanMotion()
  if s:id
    call matchdelete(s:id)
    let s:id = 0
  end
endfunction


"--- Big moves
function g:HighW()
  let s:id = matchadd( "MotionGroup", '\(\s\)\@<=\S\%'.line('.').'l\%>'.(col('.')).'c' )
endfunction

function g:HighB()
  let s:id = matchadd( "MotionGroup", '\(\s\)\@<=\S\%'.line('.').'l\%<'.(col('.')+2).'c' )
endfunction

function g:HighE()
  let s:id = matchadd( "MotionGroup", '\(\S\ze\s\)\%'.line('.').'l\%>'.(col('.')).'c' )
endfunction


"--- Small moves
function g:Highw()
  " thanks to sakkemo from #vim on irc.freenode.org who found the good regexp
  let s:id = matchadd( "MotionGroup", '\(\<\k\|\>\S\|\s\zs\S\)\%'.line('.').'l\%>'.(col('.')).'c' )
endfunction

function g:Highb()
  let s:id = matchadd( "MotionGroup", '\(\<\k\|\>\S\|\s\zs\S\)\%'.line('.').'l\%<'.(col('.')+2).'c' )
endfunction

function g:Highe()
  let s:id = matchadd( "MotionGroup", '\(\k\>\|\S\<\|\S\ze\s\)\%'.line('.').'l\%>'.(col('.')).'c' )
endfunction


"--- Mapings
nmap <silent> w w:call g:Highw()<Enter>
nmap <silent> W W:call g:HighW()<Enter>
nmap <silent> b b:call g:Highb()<Enter>
nmap <silent> B B:call g:HighB()<Enter>
nmap <silent> e e:call g:Highe()<Enter>
nmap <silent> E E:call g:HighE()<Enter>


"---Autocommand to call CleanMotion
autocmd WinLeave * call g:CleanMotion()
autocmd InsertEnter * call g:CleanMotion()
autocmd CursorMoved * call g:CleanMotion()
