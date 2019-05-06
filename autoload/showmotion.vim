let s:save_cpo = &cpo
set cpo&vim

"------- Word Motions {{{

"----- Vars {{{
let s:big_id   = 0
let s:small_id = 0
" }}}

"----- Clean words' motions highlighting {{{
function! showmotion#CleanWordMotion() abort
  if s:big_id
    let l:to_delete = s:big_id
    let s:big_id = 0
    call matchdelete(l:to_delete)
    set nocursorcolumn
  end
  if s:small_id
    let l:to_delete = s:small_id
    let s:small_id = 0
    call matchdelete(l:to_delete)
    set nocursorcolumn
  end
endfunction
" }}}

"----- Big moves {{{
function! showmotion#HighW() abort
  let s:big_id = matchadd( "ShowMotion_BigMotionGroup", '\(\s\)\@<=\S\%'.line('.').'l\%>'.(col('.')).'c' )
endfunction

function! showmotion#HighB() abort
  let s:big_id = matchadd( "ShowMotion_BigMotionGroup", '\(\s\)\@<=\S\%'.line('.').'l\%<'.(col('.')+2).'c' )
endfunction

function! showmotion#HighE() abort
  let s:big_id = matchadd( "ShowMotion_BigMotionGroup", '\(\S\ze\s\)\%'.line('.').'l\%>'.(col('.')).'c' )
endfunction
" }}}

"----- Small moves {{{
function! showmotion#Highw() abort
  " thanks to sakkemo from #vim on irc.freenode.org who found the good regexp
  let s:small_id = matchadd( "ShowMotion_SmallMotionGroup", '\(\<\k\|\>\S\|\s\zs\S\)\%'.line('.').'l\%>'.(col('.')).'c' )
endfunction

function! showmotion#Highb() abort
  let s:small_id = matchadd( "ShowMotion_SmallMotionGroup", '\(\<\k\|\>\S\|\s\zs\S\)\%'.line('.').'l\%<'.(col('.')+2).'c' )
endfunction

function! showmotion#Highe() abort
  let s:small_id = matchadd( "ShowMotion_SmallMotionGroup", '\(\k\>\|\S\<\|\S\ze\s\)\%'.line('.').'l\%>'.(col('.')).'c' )
endfunction
" }}}

" }}}


"------- Character Motions {{{

"----- Vars {{{
let s:char              = 97
let s:land_next         = 0
let s:c_id              = 0
let s:dir               = "none"
let s:char_first_search = "none"
let s:save_ignorecase   = &ignorecase
" }}}

"----- Functions {{{
"--- Ignorecase handling
function! s:SaveDisableIgnorecase() abort
  let s:save_ignorecase = &ignorecase
  set noignorecase
endfunction

function! s:RestoreIgnorecase() abort
  let &ignorecase = s:save_ignorecase
endfunction

"--- Char moves
function! showmotion#SeekCharForward() abort
  call showmotion#CleanCharMotion()
  if s:land_next
    call setpos( '.' , [0, line('.'), (col('.') + 1), 0] )
  end
  call search( escape(nr2char(s:char), ".$^~"), 'W', line('.') )
  if s:land_next
    call setpos( '.' , [0, line('.'), (col('.') - 1), 0] )
  end
endfunction

function! showmotion#SeekCharBackward() abort
  call showmotion#CleanCharMotion()
  if s:land_next
    call setpos( '.' , [0, line('.'), (col('.') - 1), 0] )
  end
  call search( escape(nr2char(s:char), ".$^~"), 'bW', line('.') )
  if s:land_next
    call setpos( '.' , [0, line('.'), (col('.') + 1), 0] )
  end
endfunction

function! showmotion#SeekRepeat() abort
  call s:SaveDisableIgnorecase()
  if s:dir ==# "forward"
    call showmotion#SeekCharForward()
  else
    call showmotion#SeekCharBackward()
  end
  call s:RestoreIgnorecase()
endfunction

function! showmotion#SeekReverse() abort
  call s:SaveDisableIgnorecase()
  if s:dir ==# "forward"
    call showmotion#SeekCharBackward()
  else
    call showmotion#SeekCharForward()
  end
  call s:RestoreIgnorecase()
endfunction


"--- Char highlights
function! showmotion#HighCharForward() abort
  if s:land_next
    let s:c_id = matchadd( "ShowMotion_CharSearchGroup", escape(nr2char(s:char), ".$^~").'\%'.line('.').'l\%>'.(col('.')+1).'c' )
  else
    let s:c_id = matchadd( "ShowMotion_CharSearchGroup", escape(nr2char(s:char), ".$^~").'\%'.line('.').'l\%>'.(col('.')).'c' )
  end
endfunction

function! showmotion#HighCharBackward() abort
  if s:land_next
    let s:c_id = matchadd( "ShowMotion_CharSearchGroup", escape(nr2char(s:char), ".$^~").'\%'.line('.').'l\%<'.(col('.')+1).'c' )
  else
    let s:c_id = matchadd( "ShowMotion_CharSearchGroup", escape(nr2char(s:char), ".$^~").'\%'.line('.').'l\%<'.(col('.')+2).'c' )
  end
endfunction

function! showmotion#HighRepeat() abort
  if s:dir ==# "forward"
    call showmotion#HighCharForward()
  else
    call showmotion#HighCharBackward()
  end
endfunction

function! showmotion#HighReverse() abort
  if s:dir ==# "forward"
    call showmotion#HighCharBackward()
  else
    call showmotion#HighCharForward()
  end
endfunction


"--- Char highlights cleaning
function! showmotion#CleanCharMotion() abort
  if s:c_id
    call matchdelete(s:c_id)
    let s:c_id = 0
    set nocursorcolumn
  end
endfunction

function! showmotion#CleanNonFirstCharMotion() abort
  if s:char_first_search==0
    call showmotion#CleanCharMotion()
  end
  let s:char_first_search=0
endfunction


function! showmotion#Repeater(count, func)
  "let n = 1
  "while n <= a:count
    "call call(a:func, [])
    "let n += 1
  "endwhile
  call map(range(a:count), 'call(a:func, [])')
endfunction


function! showmotion#FindChar( land_next, dir, count) abort
  let s:land_next = a:land_next
  let s:dir = a:dir
  echo ""
  let s:char = getchar()

  "call showmotion#SeekRepeat()
  call showmotion#Repeater(a:count, "showmotion#SeekRepeat")
  call showmotion#HighRepeat()
  let s:char_first_search=1
endfunction
" }}}

" }}}

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set foldmethod=marker
