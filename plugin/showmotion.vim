"----- Word Motions
  highlight SmallMotionGroup cterm=italic ctermbg=53 ctermfg=none
  highlight BigMotionGroup cterm=italic,bold,underline ctermbg=54 ctermfg=none


  "--- Vars
    let s:big_id = 0
    let s:small_id = 0

  "--- Clean words' motions highlighting
    function SM_CleanWordMotion()
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
    function SM_HighW()
      let s:big_id = matchadd( "BigMotionGroup", '\(\s\)\@<=\S\%'.line('.').'l\%>'.(col('.')).'c' )
    endfunction

    function SM_HighB()
      let s:big_id = matchadd( "BigMotionGroup", '\(\s\)\@<=\S\%'.line('.').'l\%<'.(col('.')+2).'c' )
    endfunction

    function SM_HighE()
      let s:big_id = matchadd( "BigMotionGroup", '\(\S\ze\s\)\%'.line('.').'l\%>'.(col('.')).'c' )
    endfunction


  "--- Small moves
    function SM_Highw()
      " thanks to sakkemo from #vim on irc.freenode.org who found the good regexp
      let s:small_id = matchadd( "SmallMotionGroup", '\(\<\k\|\>\S\|\s\zs\S\)\%'.line('.').'l\%>'.(col('.')).'c' )
    endfunction

    function SM_Highb()
      let s:small_id = matchadd( "SmallMotionGroup", '\(\<\k\|\>\S\|\s\zs\S\)\%'.line('.').'l\%<'.(col('.')+2).'c' )
    endfunction

    function SM_Highe()
      let s:small_id = matchadd( "SmallMotionGroup", '\(\k\>\|\S\<\|\S\ze\s\)\%'.line('.').'l\%>'.(col('.')).'c' )
    endfunction


  "---Autocommands to call CleanWordMotion
    autocmd WinLeave * call SM_CleanWordMotion()
    autocmd InsertEnter * call SM_CleanWordMotion()
    autocmd CursorMoved * call SM_CleanWordMotion()



"----- Character Motions
  highlight CharSearchGroup cterm=italic,bold ctermbg=4 ctermfg=none

  " The vars
    let s:char = 97
    let s:key = 'a'
    let s:c_id = 0
    let s:dir = "none"

  "--- The functions
  function SM_SeekCharForward()
    call SM_CleanCharMotion()
    if s:key=='f'
      let n = search( escape(nr2char(s:char), ".$^~" ), 'W', line('.') )
    end
    if s:key=='t'
      call setpos( '.' , [0, line('.'), (col('.') + 1), 0] )
      let n = search( escape(nr2char(s:char), ".$^~"), 'W', line('.') )
      call setpos( '.' , [0, line('.'), (col('.') - 1), 0] )
    end
    "let s:c_id = matchadd( "CharSearchGroup", escape(nr2char(s:char), ".$^~").'\%'.line('.').'l\%>'.(col('.')).'c' )
  endfunction

  function SM_SeekCharBackward()
    call SM_CleanCharMotion()
    if s:key=='F'
      let n = search( escape(nr2char(s:char), ".$^~"), 'bW', line('.') )
    end
    if s:key=='T'
      call setpos( '.' , [0, line('.'), (col('.') - 1), 0] )
      let n = search( escape(nr2char(s:char), ".$^~"), 'bW', line('.') )
      call setpos( '.' , [0, line('.'), (col('.') + 1), 0] )
    end
    "let s:c_id = matchadd( "CharSearchGroup", escape(nr2char(s:char), ".$^~").'\%'.line('.').'l\%<'.(col('.')).'c' )
  endfunction

  function SM_SeekRepeat()
    if ( s:dir == "forward" )
      call SM_SeekCharForward()
    else
      call SM_SeekCharBackward()
    end
  endfunction

  function SM_SeekReverse()
    if ( s:dir == "forward" )
      call SM_SeekCharBackward()
    else
      call SM_SeekCharForward()
    end
  endfunction


  function SM_HighCharForward()
    let s:c_id = matchadd( "CharSearchGroup", escape(nr2char(s:char), ".$^~").'\%'.line('.').'l\%>'.(col('.')).'c' )
  endfunction

  function SM_HighCharBackward()
    let s:c_id = matchadd( "CharSearchGroup", escape(nr2char(s:char), ".$^~").'\%'.line('.').'l\%<'.(col('.')).'c' )
  endfunction

  function SM_HighRepeat()
    if ( s:dir == "forward" )
      call SM_HighCharForward()
    else
      call SM_HighCharBackward()
    end
  endfunction

  function SM_HighReverse()
    if ( s:dir == "forward" )
      call SM_HighCharBackward()
    else
      call SM_HighCharForward()
    end
  endfunction


  function SM_CleanCharMotion()
    if s:c_id
      call matchdelete(s:c_id)
      let s:c_id = 0
    end
  endfunction


  function SM_FindChar( key, dir)
    let s:key = a:key
    let s:dir = a:dir
    let s:char = getchar()

    call SM_CleanCharMotion()
    let s:c_id = matchadd( "CharSearchGroup", escape(nr2char(s:char), ".$^~").'\%'.line('.').'l\%>'.(col('.')).'c' )
    call SM_SeekRepeat()
  endfunction


  "---Autocommands to call CleanCharMotion
  autocmd WinLeave * call SM_CleanCharMotion()
  autocmd InsertEnter * call SM_CleanCharMotion()
  autocmd CursorMoved * call SM_CleanCharMotion()
