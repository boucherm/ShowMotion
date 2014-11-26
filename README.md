ShowMotion
==========

Tiny vim plugin to highlight landing places when moving:

* by words with {'w','W','b','B','e','E'}.
* by char with {'f','F','t','T',';',','}

Somewhat inspired by the EasyMotion plugin, this one is only aimed at providing cues about where you'll land, not allowing to select a specific landing place. The pleasant consequence of this is it doesn't break your moving flow, which was the motivation for writing it.

Add these to your vimrc:
  "Show motion for words:
    nnoremap <silent> w w:call g:Highw()<Enter>:call g:HighW()<Enter>
    nnoremap <silent> W W:call g:Highw()<Enter>:call g:HighW()<Enter>
    nnoremap <silent> b b:call g:Highb()<Enter>:call g:HighB()<Enter>
    nnoremap <silent> B B:call g:Highb()<Enter>:call g:HighB()<Enter>
    nnoremap <silent> e e:call g:Highe()<Enter>:call g:HighE()<Enter>
    nnoremap <silent> E E:call g:Highe()<Enter>:call g:HighE()<Enter>
  "Show motion for chars:
    nnoremap f :call g:FindChar( 'f', "forward" )<CR>
    nnoremap t :call g:FindChar( 't', "forward" )<CR>
    nnoremap F :call g:FindChar( 'F', "backward" )<CR>
    nnoremap T :call g:FindChar( 'T', "backward" )<CR>
    nnoremap ; :call g:SeekRepeat()<CR>
    nnoremap , :call g:SeekReverse()<CR>


Known limitations:

* Highlight groups are defined for term vim, update it if you use gvim.
* Highlight groups are not modifiable outside of the script.
