"----- Word Motions
  "highlight MotionGroup cterm=italic,bold ctermbg=16 ctermfg=4
  "highlight MotionGroup cterm=bold,italic ctermbg=none ctermfg=4
  "highlight MotionGroup cterm=bold,italic ctermbg=233 ctermfg=4
  highlight MotionGroup cterm=italic,bold ctermbg=53 ctermfg=none
  highlight SmallMotionGroup cterm=italic ctermbg=53 ctermfg=none
  highlight BigMotionGroup cterm=italic,bold,underline ctermbg=54 ctermfg=none


  "--- IDs of the highlighting groups
  "let s:id = 0
  let s:big_id = 0
  let s:small_id = 0
  "---
  let s:behaviour = 1

  "--- Clean words' motions highlighting
    function g:CleanWordMotion()
      "if s:id
        "call matchdelete(s:id)
        "let s:id = 0
      "end
      if s:big_id
        call matchdelete(s:big_id)
        let s:big_id = 0
      end
      if s:small_id
        call matchdelete(s:small_id)
        let s:small_id = 0
      end
    endfunction


  "--- Big moves
    function g:HighW()
      "let s:id = matchadd( "MotionGroup", '\(\s\)\@<=\S\%'.line('.').'l\%>'.(col('.')).'c' )
      let s:big_id = matchadd( "BigMotionGroup", '\(\s\)\@<=\S\%'.line('.').'l\%>'.(col('.')).'c' )
    endfunction

    function g:HighB()
      "let s:id = matchadd( "MotionGroup", '\(\s\)\@<=\S\%'.line('.').'l\%<'.(col('.')+2).'c' )
      let s:big_id = matchadd( "BigMotionGroup", '\(\s\)\@<=\S\%'.line('.').'l\%<'.(col('.')+2).'c' )
    endfunction

    function g:HighE()
      "let s:id = matchadd( "MotionGroup", '\(\S\ze\s\)\%'.line('.').'l\%>'.(col('.')).'c' )
      let s:big_id = matchadd( "BigMotionGroup", '\(\S\ze\s\)\%'.line('.').'l\%>'.(col('.')).'c' )
    endfunction


  "--- Small moves
    function g:Highw()
      " thanks to sakkemo from #vim on irc.freenode.org who found the good regexp
      "let s:id = matchadd( "MotionGroup", '\(\<\k\|\>\S\|\s\zs\S\)\%'.line('.').'l\%>'.(col('.')).'c' )
      let s:small_id = matchadd( "SmallMotionGroup", '\(\<\k\|\>\S\|\s\zs\S\)\%'.line('.').'l\%>'.(col('.')).'c' )
    endfunction

    function g:Highb()
      "let s:id = matchadd( "MotionGroup", '\(\<\k\|\>\S\|\s\zs\S\)\%'.line('.').'l\%<'.(col('.')+2).'c' )
      let s:small_id = matchadd( "SmallMotionGroup", '\(\<\k\|\>\S\|\s\zs\S\)\%'.line('.').'l\%<'.(col('.')+2).'c' )
    endfunction

    function g:Highe()
      "let s:id = matchadd( "MotionGroup", '\(\k\>\|\S\<\|\S\ze\s\)\%'.line('.').'l\%>'.(col('.')).'c' )
      let s:small_id = matchadd( "SmallMotionGroup", '\(\k\>\|\S\<\|\S\ze\s\)\%'.line('.').'l\%>'.(col('.')).'c' )
    endfunction


  "--- Mappings
  if ( 0 == s:behaviour )
    nnoremap <silent> w w:call g:Highw()<Enter>
    nnoremap <silent> W W:call g:HighW()<Enter>
    nnoremap <silent> b b:call g:Highb()<Enter>
    nnoremap <silent> B B:call g:HighB()<Enter>
    nnoremap <silent> e e:call g:Highe()<Enter>
    nnoremap <silent> E E:call g:HighE()<Enter>
  else
    nnoremap <silent> w w:call g:Highw()<Enter>:call g:HighW()<Enter>
    nnoremap <silent> W W:call g:Highw()<Enter>:call g:HighW()<Enter>
    nnoremap <silent> b b:call g:Highb()<Enter>:call g:HighB()<Enter>
    nnoremap <silent> B B:call g:Highb()<Enter>:call g:HighB()<Enter>
    nnoremap <silent> e e:call g:Highe()<Enter>:call g:HighE()<Enter>
    nnoremap <silent> E E:call g:Highe()<Enter>:call g:HighE()<Enter>
  endif


  "---Autocommand to call CleanWordMotion
  autocmd WinLeave * call g:CleanWordMotion()
  autocmd InsertEnter * call g:CleanWordMotion()
  autocmd CursorMoved * call g:CleanWordMotion()



"----- Character Motions
  highlight CharSearchGroup cterm=italic,bold ctermbg=4 ctermfg=none


  " The vars
  let g:char = 97
  let g:key = 'a'
  let s:c_id = 0
  let g:dir = "none"


  "--- The functions
  function SeekCharForward()
    call g:CleanCharMotion()
    if g:key=='f'
      let n = search( nr2char(g:char), 'W', line('.') )
    end
    if g:key=='t'
      call setpos( '.' , [0, line('.'), (col('.') + 1), 0] )
      let n = search( nr2char(g:char), 'W', line('.') )
      call setpos( '.' , [0, line('.'), (col('.') - 1), 0] )
    end
    let s:c_id = matchadd( "CharSearchGroup", nr2char(g:char).'\%'.line('.').'l\%>'.(col('.')).'c' )
  endfunction

  function SeekCharBackward()
    call g:CleanCharMotion()
    if g:key=='F'
      let n = search( nr2char(g:char), 'bW', line('.') )
    end
    if g:key=='T'
      call setpos( '.' , [0, line('.'), (col('.') - 1), 0] )
      let n = search( nr2char(g:char), 'bW', line('.') )
      call setpos( '.' , [0, line('.'), (col('.') + 1), 0] )
    end
    let s:c_id = matchadd( "CharSearchGroup", nr2char(g:char).'\%'.line('.').'l\%<'.(col('.')).'c' )
  endfunction

  function SeekRepeat()
    if ( g:dir == "forward" )
      call SeekCharForward()
    else
      call SeekCharBackward()
    end
  endfunction

  function SeekReverse()
    if ( g:dir == "forward" )
      call SeekCharBackward()
    else
      call SeekCharForward()
    end
  endfunction

  function g:CleanCharMotion()
    if s:c_id
      call matchdelete(s:c_id)
      let s:c_id = 0
    end
  endfunction

  function FindChar( key, dir)
    let g:key = a:key
    let g:dir = a:dir
    let g:char = escape( getchar(), '.' )

    call g:CleanCharMotion()
    let s:c_id = matchadd( "CharSearchGroup", nr2char(g:char).'\%'.line('.').'l\%>'.(col('.')).'c' )
    call SeekRepeat()
  endfunction


  "--- The mappings
  nmap f       :call FindChar( 'f', "forward" )<CR>
  nmap t       :call FindChar( 't', "forward" )<CR>
  nmap F       :call FindChar( 'F', "backward" )<CR>
  nmap T       :call FindChar( 'T', "backward" )<CR>
  nmap ;       :call SeekRepeat()<CR>
  nmap <Space> :call SeekReverse()<CR>


  " Issues:
  " . some characters interpreted as regexp ('.' for example)
  " . direct mappings may conflict with vimrc defined mappings
  " . need to call g:CleanCharMotion() when: insert, winleave, cursor moved " except by 'f','t','F','T',';',','

  "---Autocommand to call CleanMotion
  autocmd WinLeave * call g:CleanCharMotion()
  autocmd InsertEnter * call g:CleanCharMotion()



  " Alternative:
  " The CursorMoved autocmd triggered "f{char}", take a look at last action (check for f, t, ;...), use something like getcurpos() to know which character you landed on, then highlight all the others in the line
