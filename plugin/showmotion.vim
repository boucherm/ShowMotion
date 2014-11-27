"----- Highlights
  highlight SM_SmallMotionGroup cterm=italic                ctermbg=53 gui=italic                guibg=#5f005f
  highlight SM_BigMotionGroup   cterm=italic,bold,underline ctermbg=54 gui=italic,bold,underline guibg=#5f0087
  highlight SM_CharSearchGroup  cterm=italic,bold           ctermbg=4  gui=italic,bold           guibg=#3f6691



"----- Word Motions

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
      let s:big_id = matchadd( "SM_BigMotionGroup", '\(\s\)\@<=\S\%'.line('.').'l\%>'.(col('.')).'c' )
    endfunction

    function SM_HighB()
      let s:big_id = matchadd( "SM_BigMotionGroup", '\(\s\)\@<=\S\%'.line('.').'l\%<'.(col('.')+2).'c' )
    endfunction

    function SM_HighE()
      let s:big_id = matchadd( "SM_BigMotionGroup", '\(\S\ze\s\)\%'.line('.').'l\%>'.(col('.')).'c' )
    endfunction


  "--- Small moves
    function SM_Highw()
      " thanks to sakkemo from #vim on irc.freenode.org who found the good regexp
      let s:small_id = matchadd( "SM_SmallMotionGroup", '\(\<\k\|\>\S\|\s\zs\S\)\%'.line('.').'l\%>'.(col('.')).'c' )
    endfunction

    function SM_Highb()
      let s:small_id = matchadd( "SM_SmallMotionGroup", '\(\<\k\|\>\S\|\s\zs\S\)\%'.line('.').'l\%<'.(col('.')+2).'c' )
    endfunction

    function SM_Highe()
      let s:small_id = matchadd( "SM_SmallMotionGroup", '\(\k\>\|\S\<\|\S\ze\s\)\%'.line('.').'l\%>'.(col('.')).'c' )
    endfunction



"----- Character Motions

  "--- Vars
    let s:char = 97
    let s:key = 'a'
    let s:c_id = 0
    let s:dir = "none"

  "--- Functions
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
      let s:c_id = matchadd( "SM_CharSearchGroup", escape(nr2char(s:char), ".$^~").'\%'.line('.').'l\%>'.(col('.')).'c' )
    endfunction

    function SM_HighCharBackward()
      let s:c_id = matchadd( "SM_CharSearchGroup", escape(nr2char(s:char), ".$^~").'\%'.line('.').'l\%<'.(col('.')).'c' )
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
      call SM_SeekRepeat()
    endfunction



"----- Autocommands to clean highlighting
  augroup SM_CleanWordAutocmds
    autocmd! WinLeave * call SM_CleanWordMotion()
    autocmd! InsertEnter * call SM_CleanWordMotion()
    autocmd! CursorMoved * call SM_CleanWordMotion()
  augroup end

  augroup SM_CleanCharAutocmds
    autocmd! WinLeave * call SM_CleanCharMotion()
    autocmd! InsertEnter * call SM_CleanCharMotion()
    autocmd! CursorMoved * call SM_CleanCharMotion()
  augroup end



"----- <Plug> mappings
  "---<Plug> mappings
  nnoremap <Plug>(show-motion-w) :normal! w<CR>:call SM_Highw()<CR>
  nnoremap <Plug>(show-motion-W) :normal! W<CR>:call SM_HighW()<CR>
  nnoremap <Plug>(show-motion-b) :normal! b<CR>:call SM_Highb()<CR>
  nnoremap <Plug>(show-motion-B) :normal! B<CR>:call SM_HighB()<CR>
  nnoremap <Plug>(show-motion-e) :normal! e<CR>:call SM_Highe()<CR>
  nnoremap <Plug>(show-motion-E) :normal! E<CR>:call SM_HighE()<CR>

  nnoremap <Plug>(show-motion-both-w) :normal! w<CR>:call SM_Highw()<CR>:call SM_HighW()<CR>
  nnoremap <Plug>(show-motion-both-W) :normal! W<CR>:call SM_Highw()<CR>:call SM_HighW()<CR>
  nnoremap <Plug>(show-motion-both-b) :normal! b<CR>:call SM_Highb()<CR>:call SM_HighB()<CR>
  nnoremap <Plug>(show-motion-both-B) :normal! B<CR>:call SM_Highb()<CR>:call SM_HighB()<CR>
  nnoremap <Plug>(show-motion-both-e) :normal! e<CR>:call SM_Highe()<CR>:call SM_HighE()<CR>
  nnoremap <Plug>(show-motion-both-E) :normal! E<CR>:call SM_Highe()<CR>:call SM_HighE()<CR>
  "Show motion for chars:
  nnoremap <Plug>(show-motion-f) :call SM_FindChar( 'f', "forward" )<CR>
  nnoremap <Plug>(show-motion-t) :call SM_FindChar( 't', "forward" )<CR>
  nnoremap <Plug>(show-motion-F) :call SM_FindChar( 'F', "backward" )<CR>
  nnoremap <Plug>(show-motion-T) :call SM_FindChar( 'T', "backward" )<CR>
  nnoremap <Plug>(show-motion-;) :call SM_SeekRepeat()<CR>:call SM_HighRepeat()<CR>
  nnoremap <Plug>(show-motion-,) :call SM_SeekReverse()<CR>:call SM_HighReverse()<CR>
