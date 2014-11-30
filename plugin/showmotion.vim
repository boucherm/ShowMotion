if exists('g:loaded_showmotion')
  finish
endif
let g:loaded_showmotion = 1

let s:save_cpo = &cpo
set cpo&vim

" Highlights {{{
function! s:SetHighlight() abort
  highlight ShowMotion_SmallMotionGroup cterm=italic                ctermbg=53 gui=italic                guibg=#5f005f
  highlight ShowMotion_BigMotionGroup   cterm=italic,bold,underline ctermbg=54 gui=italic,bold,underline guibg=#5f0087
  highlight ShowMotion_CharSearchGroup  cterm=italic,bold           ctermbg=4  gui=italic,bold           guibg=#3f6691
endfunction
call s:SetHighlight()
augroup showmotion-highlight
  autocmd!
  autocmd ColorScheme * call s:SetHighlight()
augroup END
" }}}


" Autocommands to clean highlighting {{{
augroup showmotion-clean-word-autocmds
  autocmd!
  autocmd WinLeave,InsertEnter,CursorMoved * call showmotion#CleanWordMotion()
augroup END

augroup showmotion-clean-char-autocmds
  autocmd!
  autocmd WinLeave,InsertEnter,CursorMoved * call showmotion#CleanCharMotion()
augroup END
" }}}


" <Plug> mappings {{{
nnoremap <silent> <Plug>(show-motion-w) :normal! w<CR>:call showmotion#Highw()<CR>
nnoremap <silent> <Plug>(show-motion-W) :normal! W<CR>:call showmotion#HighW()<CR>
nnoremap <silent> <Plug>(show-motion-b) :normal! b<CR>:call showmotion#Highb()<CR>
nnoremap <silent> <Plug>(show-motion-B) :normal! B<CR>:call showmotion#HighB()<CR>
nnoremap <silent> <Plug>(show-motion-e) :normal! e<CR>:call showmotion#Highe()<CR>
nnoremap <silent> <Plug>(show-motion-E) :normal! E<CR>:call showmotion#HighE()<CR>

nnoremap <silent> <Plug>(show-motion-both-w) :normal! w<CR>:call showmotion#Highw()<CR>:call showmotion#HighW()<CR>
nnoremap <silent> <Plug>(show-motion-both-W) :normal! W<CR>:call showmotion#Highw()<CR>:call showmotion#HighW()<CR>
nnoremap <silent> <Plug>(show-motion-both-b) :normal! b<CR>:call showmotion#Highb()<CR>:call showmotion#HighB()<CR>
nnoremap <silent> <Plug>(show-motion-both-B) :normal! B<CR>:call showmotion#Highb()<CR>:call showmotion#HighB()<CR>
nnoremap <silent> <Plug>(show-motion-both-e) :normal! e<CR>:call showmotion#Highe()<CR>:call showmotion#HighE()<CR>
nnoremap <silent> <Plug>(show-motion-both-E) :normal! E<CR>:call showmotion#Highe()<CR>:call showmotion#HighE()<CR>

nnoremap <silent> <Plug>(show-motion-f) :<C-u>call showmotion#FindChar( 'f', "forward" )<CR>
nnoremap <silent> <Plug>(show-motion-t) :<C-u>call showmotion#FindChar( 't', "forward" )<CR>
nnoremap <silent> <Plug>(show-motion-F) :<C-u>call showmotion#FindChar( 'F', "backward" )<CR>
nnoremap <silent> <Plug>(show-motion-T) :<C-u>call showmotion#FindChar( 'T', "backward" )<CR>
nnoremap <silent> <Plug>(show-motion-;) :<C-u>call showmotion#SeekRepeat()<CR>:call showmotion#HighRepeat()<CR>
nnoremap <silent> <Plug>(show-motion-,) :<C-u>call showmotion#SeekReverse()<CR>:call showmotion#HighReverse()<CR>
" }}}

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set foldmethod=marker
