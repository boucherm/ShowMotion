let s:save_cpo = &cpo
set cpo&vim

" Word Motions {{{

" Vars {{{
let s:big_id = 0
let s:small_id = 0
" }}}

" Clean words' motions highlighting {{{
function! showmotion#CleanWordMotion() abort
  if s:big_id
    call matchdelete(s:big_id)
    let s:big_id = 0
  end
  if s:small_id
    call matchdelete(s:small_id)
    let s:small_id = 0
  end
endfunction
" }}}

" Big moves {{{
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

" Small moves {{{
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


" Character Motions {{{

" Vars {{{
let s:char = 97
let s:key = 'a'
let s:c_id = 0
let s:dir = "none"
" }}}

" Functions {{{
function! showmotion#SeekCharForward() abort
  call showmotion#CleanCharMotion()
  if s:key ==# 'f'
    call search( escape(nr2char(s:char), ".$^~" ), 'W', line('.') )
  end
  if s:key ==# 't'
    call setpos( '.' , [0, line('.'), (col('.') + 1), 0] )
    call search( escape(nr2char(s:char), ".$^~"), 'W', line('.') )
    call setpos( '.' , [0, line('.'), (col('.') - 1), 0] )
  end
  "let s:c_id = matchadd( "CharSearchGroup", escape(nr2char(s:char), ".$^~").'\%'.line('.').'l\%>'.(col('.')).'c' )
endfunction

function! showmotion#SeekCharBackward() abort
  call showmotion#CleanCharMotion()
  if s:key ==# 'F'
    call search( escape(nr2char(s:char), ".$^~"), 'bW', line('.') )
  end
  if s:key ==# 'T'
    call setpos( '.' , [0, line('.'), (col('.') - 1), 0] )
    call search( escape(nr2char(s:char), ".$^~"), 'bW', line('.') )
    call setpos( '.' , [0, line('.'), (col('.') + 1), 0] )
  end
  "let s:c_id = matchadd( "CharSearchGroup", escape(nr2char(s:char), ".$^~").'\%'.line('.').'l\%<'.(col('.')).'c' )
endfunction

function! showmotion#SeekRepeat() abort
  if s:dir ==# "forward" 
    call showmotion#SeekCharForward()
  else
    call showmotion#SeekCharBackward()
  end
endfunction

function! showmotion#SeekReverse() abort
  if s:dir ==# "forward" 
    call showmotion#SeekCharBackward()
  else
    call showmotion#SeekCharForward()
  end
endfunction


function! showmotion#HighCharForward() abort
  let s:c_id = matchadd( "ShowMotion_CharSearchGroup", escape(nr2char(s:char), ".$^~").'\%'.line('.').'l\%>'.(col('.')).'c' )
endfunction

function! showmotion#HighCharBackward() abort
  let s:c_id = matchadd( "ShowMotion_CharSearchGroup", escape(nr2char(s:char), ".$^~").'\%'.line('.').'l\%<'.(col('.')).'c' )
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


function! showmotion#CleanCharMotion() abort
  if s:c_id
    call matchdelete(s:c_id)
    let s:c_id = 0
  end
endfunction


function! showmotion#FindChar( key, dir) abort
  let s:key = a:key
  let s:dir = a:dir
  echo ""
  let s:char = getchar()

  call showmotion#CleanCharMotion()
  call showmotion#SeekRepeat()
endfunction
" }}}

" }}}

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set foldmethod=marker
