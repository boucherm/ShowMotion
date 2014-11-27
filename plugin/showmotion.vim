"---<Plug> mappings
  nnoremap <Plug>(showmotion-w) w:call g:Highw()<CR>:call g:HighW()<CR>
  nnoremap <Plug>(showmotion-W) W:call g:Highw()<CR>:call g:HighW()<CR>
  nnoremap <Plug>(showmotion-b) b:call g:Highb()<CR>:call g:HighB()<CR>
  nnoremap <Plug>(showmotion-B) B:call g:Highb()<CR>:call g:HighB()<CR>
  nnoremap <Plug>(showmotion-e) e:call g:Highe()<CR>:call g:HighE()<CR>
  nnoremap <Plug>(showmotion-E) E:call g:Highe()<CR>:call g:HighE()<CR>

  "Show motion for chars:
  nnoremap <Plug>(show-motion-f) :call g:FindChar( 'f', "forward" )<CR>
  nnoremap <Plug>(show-motion-t) :call g:FindChar( 't', "forward" )<CR>
  nnoremap <Plug>(show-motion-F) :call g:FindChar( 'F', "backward" )<CR>
  nnoremap <Plug>(show-motion-T) :call g:FindChar( 'T', "backward" )<CR>
  nnoremap <Plug>(show-motion-;) :call g:SeekRepeat()<CR>:call g:HighRepeat()<CR>
  nnoremap <Plug>(show-motion-,) :call g:SeekReverse()<CR>:call g:HighReverse()<CR>

"----- Word Motions
  highlight SmallMotionGroup cterm=italic ctermbg=53 ctermfg=none
  highlight BigMotionGroup cterm=italic,bold,underline ctermbg=54 ctermfg=none


  "--- Vars
    let s:big_id = 0
    let s:small_id = 0

  "--- Clean words' motions highlighting
    function g:CleanWordMotion()
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
      let s:big_id = matchadd( "BigMotionGroup", '\(\s\)\@<=\S\%'.line('.').'l\%>'.(col('.')).'c' )
    endfunction

    function g:HighB()
      let s:big_id = matchadd( "BigMotionGroup", '\(\s\)\@<=\S\%'.line('.').'l\%<'.(col('.')+2).'c' )
    endfunction

    function g:HighE()
      let s:big_id = matchadd( "BigMotionGroup", '\(\S\ze\s\)\%'.line('.').'l\%>'.(col('.')).'c' )
    endfunction


  "--- Small moves
    function g:Highw()
      " thanks to sakkemo from #vim on irc.freenode.org who found the good regexp
      let s:small_id = matchadd( "SmallMotionGroup", '\(\<\k\|\>\S\|\s\zs\S\)\%'.line('.').'l\%>'.(col('.')).'c' )
    endfunction

    function g:Highb()
      let s:small_id = matchadd( "SmallMotionGroup", '\(\<\k\|\>\S\|\s\zs\S\)\%'.line('.').'l\%<'.(col('.')+2).'c' )
    endfunction

    function g:Highe()
      let s:small_id = matchadd( "SmallMotionGroup", '\(\k\>\|\S\<\|\S\ze\s\)\%'.line('.').'l\%>'.(col('.')).'c' )
    endfunction


  "---Autocommands to call CleanWordMotion
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
      let n = search( escape(nr2char(g:char), ".$^~" ), 'W', line('.') )
    end
    if g:key=='t'
      call setpos( '.' , [0, line('.'), (col('.') + 1), 0] )
      let n = search( escape(nr2char(g:char), ".$^~"), 'W', line('.') )
      call setpos( '.' , [0, line('.'), (col('.') - 1), 0] )
    end
    "let s:c_id = matchadd( "CharSearchGroup", escape(nr2char(g:char), ".$^~").'\%'.line('.').'l\%>'.(col('.')).'c' )
  endfunction

  function SeekCharBackward()
    call g:CleanCharMotion()
    if g:key=='F'
      let n = search( escape(nr2char(g:char), ".$^~"), 'bW', line('.') )
    end
    if g:key=='T'
      call setpos( '.' , [0, line('.'), (col('.') - 1), 0] )
      let n = search( escape(nr2char(g:char), ".$^~"), 'bW', line('.') )
      call setpos( '.' , [0, line('.'), (col('.') + 1), 0] )
    end
    "let s:c_id = matchadd( "CharSearchGroup", escape(nr2char(g:char), ".$^~").'\%'.line('.').'l\%<'.(col('.')).'c' )
  endfunction

  function g:SeekRepeat()
    if ( g:dir == "forward" )
      call SeekCharForward()
    else
      call SeekCharBackward()
    end
  endfunction

  function g:SeekReverse()
    if ( g:dir == "forward" )
      call SeekCharBackward()
    else
      call SeekCharForward()
    end
  endfunction


  function HighCharForward()
    let s:c_id = matchadd( "CharSearchGroup", escape(nr2char(g:char), ".$^~").'\%'.line('.').'l\%>'.(col('.')).'c' )
  endfunction

  function HighCharBackward()
    let s:c_id = matchadd( "CharSearchGroup", escape(nr2char(g:char), ".$^~").'\%'.line('.').'l\%<'.(col('.')).'c' )
  endfunction

  function g:HighRepeat()
    if ( g:dir == "forward" )
      call HighCharForward()
    else
      call HighCharBackward()
    end
  endfunction

  function g:HighReverse()
    if ( g:dir == "forward" )
      call HighCharBackward()
    else
      call HighCharForward()
    end
  endfunction


  function g:CleanCharMotion()
    if s:c_id
      call matchdelete(s:c_id)
      let s:c_id = 0
    end
  endfunction


  function g:FindChar( key, dir)
    let g:key = a:key
    let g:dir = a:dir
    let g:char = getchar()

    call g:CleanCharMotion()
    let s:c_id = matchadd( "CharSearchGroup", escape(nr2char(g:char), ".$^~").'\%'.line('.').'l\%>'.(col('.')).'c' )
    call g:SeekRepeat()
  endfunction


  "---Autocommands to call CleanCharMotion
  autocmd WinLeave * call g:CleanCharMotion()
  autocmd InsertEnter * call g:CleanCharMotion()
  autocmd CursorMoved * call g:CleanCharMotion()
