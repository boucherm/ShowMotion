if exists('g:loaded_showmotion')
  finish
endif
let g:loaded_showmotion = 1

let s:save_cpo = &cpo
set cpo&vim

"----- Highlights {{{
function! s:SetHighlight() abort
  highlight ShowMotion_SmallMotionGroup cterm=italic                ctermbg=53 gui=italic                guibg=#5f005f
  highlight ShowMotion_BigMotionGroup   cterm=italic,bold,underline ctermbg=57 gui=italic,bold,underline guibg=#5f0087
  highlight ShowMotion_CharSearchGroup  cterm=italic,bold           ctermbg=4  gui=italic,bold           guibg=#3f6691
endfunction
call s:SetHighlight()
augroup showmotion-highlight
  autocmd!
  autocmd ColorScheme * call s:SetHighlight()
augroup END
" }}}


"----- Autocommands to clean highlighting {{{
augroup showmotion-clean-word-autocmds
  autocmd!
  autocmd WinLeave,InsertEnter,CursorMoved * call showmotion#CleanWordMotion()
augroup END

augroup showmotion-clean-char-autocmds
  autocmd!
  autocmd WinLeave,InsertEnter * call showmotion#CleanCharMotion()
  autocmd CursorMoved * call showmotion#CleanNonFirstCharMotion()
augroup END
" }}}


"----- <Plug> mappings {{{
nnoremap <silent> <Plug>(show-motion-w) 
      \:<C-u>execute "normal!" v:count1 . "w"<CR>
      \:set cursorcolumn<CR>
      \:call showmotion#Highw()<CR>
nnoremap <silent> <Plug>(show-motion-W) 
      \:<C-u>execute "normal!" v:count1 . "W"<CR>
      \:set cursorcolumn<CR>
      \:call showmotion#HighW()<CR>
nnoremap <silent> <Plug>(show-motion-b) 
      \:<C-u>execute "normal!" v:count1 . "b"<CR>
      \:set cursorcolumn<CR>
      \:call showmotion#Highb()<CR>
nnoremap <silent> <Plug>(show-motion-B) 
      \:<C-u>execute "normal!" v:count1 . "B"<CR>
      \:set cursorcolumn<CR>
      \:call showmotion#HighB()<CR>
nnoremap <silent> <Plug>(show-motion-e) 
      \:<C-u>execute "normal!" v:count1 . "e"<CR>
      \:set cursorcolumn<CR>
      \:call showmotion#Highe()<CR>
nnoremap <silent> <Plug>(show-motion-E) 
      \:<C-u>execute "normal!" v:count1 . "E"<CR>
      \:<C-u>normal! E<CR>
      \:set cursorcolumn<CR>
      \:call showmotion#HighE()<CR>

nnoremap <silent> <Plug>(show-motion-both-w) 
      \:<C-u>execute "normal!" v:count1 . "w"<CR>
      \:set cursorcolumn<CR>
      \:call showmotion#Highw()<CR>
      \:call showmotion#HighW()<CR>
      \: echo "test" <CR>
nnoremap <silent> <Plug>(show-motion-both-W) 
      \:<C-u>execute "normal!" v:count1 . "W"<CR>
      \:set cursorcolumn<CR>
      \:call showmotion#Highw()<CR>
      \:call showmotion#HighW()<CR>
nnoremap <silent> <Plug>(show-motion-both-b) 
      \:<C-u>execute "normal!" v:count1 . "b"<CR>
      \:set cursorcolumn<CR>
      \:call showmotion#Highb()<CR>
      \:call showmotion#HighB()<CR>
nnoremap <silent> <Plug>(show-motion-both-B) 
      \:<C-u>execute "normal!" v:count1 . "B"<CR>
      \:set cursorcolumn<CR>
      \:call showmotion#Highb()<CR>
      \:call showmotion#HighB()<CR>
nnoremap <silent> <Plug>(show-motion-both-e) 
      \:<C-u>execute "normal!" v:count1 . "e"<CR>
      \:set cursorcolumn<CR>
      \:call showmotion#Highe()<CR>
      \:call showmotion#HighE()<CR>
nnoremap <silent> <Plug>(show-motion-both-E) 
      \:<C-u>execute "normal!" v:count1 . "E"<CR>
      \:set cursorcolumn<CR>
      \:call showmotion#Highe()<CR>
      \:call showmotion#HighE()<CR>

nnoremap <silent> <Plug>(show-motion-f) 
      \:<C-u>set cursorcolumn<CR>
      \:<C-u>call showmotion#FindChar( 0, "forward", v:count1)<CR>

nnoremap <silent> <Plug>(show-motion-t) 
      \:<C-u>set cursorcolumn<CR>
      \:<C-u>call showmotion#FindChar( 1, "forward", v:count1)<CR>

nnoremap <silent> <Plug>(show-motion-F) 
      \:set cursorcolumn<CR>
      \:<C-u>call showmotion#FindChar( 0, "backward", v:count1)<CR>

nnoremap <silent> <Plug>(show-motion-T) 
      \:set cursorcolumn<CR>
      \:<C-u>call showmotion#FindChar( 1, "backward", v:count1)<CR>

nnoremap <silent> <Plug>(show-motion-;) 
      \:<C-u>call showmotion#Repeater(v:count1, "showmotion#SeekRepeat")<CR>
      \:call showmotion#HighRepeat()<CR>
      \:set cursorcolumn<CR>

nnoremap <silent> <Plug>(show-motion-,) 
      \:<C-u>call showmotion#Repeater(v:count1, "showmotion#SeekReverse")<CR>
      \:call showmotion#HighReverse()<CR>
      \:set cursorcolumn<CR>
" }}}


let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set foldmethod=marker
