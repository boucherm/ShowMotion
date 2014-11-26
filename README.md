ShowMotion
==========

Ever hammered the {'w','W','b','B','e','E',';',','} keys to finally pass over the location you were aiming for?  
ShowMotion is a tiny vim plugin to highlight the potential landing places when moving:

* by words with {'w','W','b','B','e','E'}.
* by chars with {'f','F','t','T',';',','}

Somewhat inspired by the EasyMotion plugin, this one is only aimed at providing cues about where you'll land, not allowing to select a specific landing place. The pleasant consequence of this is it doesn't break your moving flow, which was the motivation for writing it.

 [Demo]()


Installation:

 I suggest using [pathogen](https://github.com/tpope/vim-pathogen)


Add these to your vimrc:  
  > "Show motion for words:  
    nnoremap <silent> w w:call g:Highw()<Enter>:call g:HighW()<Enter>  
    nnoremap <silent> W W:call g:Highw()<Enter>:call g:HighW()<Enter>  
    nnoremap <silent> b b:call g:Highb()<Enter>:call g:HighB()<Enter>  
    nnoremap <silent> B B:call g:Highb()<Enter>:call g:HighB()<Enter>  
    nnoremap <silent> e e:call g:Highe()<Enter>:call g:HighE()<Enter>  
    nnoremap <silent> E E:call g:Highe()<Enter>:call g:HighE()<Enter>  

  > "Show motion for chars:  
    nnoremap f :call g:FindChar( 'f', "forward" )<CR>  
    nnoremap t :call g:FindChar( 't', "forward" )<CR>  
    nnoremap F :call g:FindChar( 'F', "backward" )<CR>  
    nnoremap T :call g:FindChar( 'T', "backward" )<CR>  
    nnoremap ; :call g:SeekRepeat()<CR>:call g:HighRepeat()<CR>
    nnoremap , :call g:SeekReverse()<CR>:call g:HighReverse()<CR>


Known limitations:

* For char-motions highlighting is only triggered when pressing ';' or ','
* Highlight groups are defined for term vim, update them if you use gvim.
* Highlight groups are not modifiable outside of the script.
* Reloading vimrc seems to break the plugin
* 'E' fails on highlighting the last character of the line
