ShowMotion
==========

Ever hammered the {`w`,`W`,`b`,`B`,`e`,`E`,`;`,`,`} keys to finally pass over the location you were aiming for?  
ShowMotion is a tiny vim plugin to highlight the potential landing places when moving:

* by words with {`w`,`W`,`b`,`B`,`e`,`E`}.
* by chars with {`f`,`F`,`t`,`T`,`;`,`,`}

Somewhat inspired by the EasyMotion plugin, this one is only aimed at providing cues about where you'll land, not allowing to select a specific landing place. The pleasant consequence of this is it doesn't break your moving flow, which was the motivation for writing it.

 ![Demo](https://i.imgur.com/sWUqiF3.gif)

Installation:

 I suggest using [pathogen](https://github.com/tpope/vim-pathogen)


Add these highlighting settings to your vimrc:  

    "*** If your plugins are loaded after your colorscheme
    highlight SM_SmallMotionGroup cterm=italic                ctermbg=53 gui=italic                guibg=#5f005f
    highlight SM_BigMotionGroup   cterm=italic,bold,underline ctermbg=54 gui=italic,bold,underline guibg=#5f0087
    highlight SM_CharSearchGroup  cterm=italic,bold           ctermbg=4  gui=italic,bold           guibg=#3f6691

    "*** If your colorscheme is loaded after your plugins
    function! SM_Highlight()
      highlight SM_SmallMotionGroup cterm=italic                ctermbg=53 gui=italic                guibg=#5f005f
      highlight SM_BigMotionGroup   cterm=italic,bold,underline ctermbg=54 gui=italic,bold,underline guibg=#5f0087
      highlight SM_CharSearchGroup  cterm=italic,bold           ctermbg=4  gui=italic,bold           guibg=#3f6691
    endfunction
    call SM_Highlight()
    augroup SM_HighlightAutocmds
      autocmd!
      autocmd ColorScheme call SM_Highlight()
    augroup END

Add these word-motion settings to your vimrc:  

    "*** Highlights both big and small motions
    nnoremap <silent> w w:call SM_Highw()<CR>:call SM_HighW()<CR>
    nnoremap <silent> W W:call SM_Highw()<CR>:call SM_HighW()<CR>
    nnoremap <silent> b b:call SM_Highb()<CR>:call SM_HighB()<CR>
    nnoremap <silent> B B:call SM_Highb()<CR>:call SM_HighB()<CR>
    nnoremap <silent> e e:call SM_Highe()<CR>:call SM_HighE()<CR>
    nnoremap <silent> E E:call SM_Highe()<CR>:call SM_HighE()<CR>

    "*** Only highlights motions corresponding to the one you typed
    nnoremap <silent> w w:call SM_Highw()<CR>
    nnoremap <silent> W W:call SM_HighW()<CR>
    nnoremap <silent> b b:call SM_Highb()<CR>
    nnoremap <silent> B B:call SM_HighB()<CR>
    nnoremap <silent> e e:call SM_Highe()<CR>
    nnoremap <silent> E E:call SM_HighE()<CR>

Add these character-motion settings to your vimrc:  

    "Show motion for chars:  
    nnoremap f :call SM_FindChar( 'f', "forward" )<CR>
    nnoremap t :call SM_FindChar( 't', "forward" )<CR>
    nnoremap F :call SM_FindChar( 'F', "backward" )<CR>
    nnoremap T :call SM_FindChar( 'T', "backward" )<CR>
    nnoremap ; :call SM_SeekRepeat()<CR>:call SM_HighRepeat()<CR>
    nnoremap , :call SM_SeekReverse()<CR>:call SM_HighReverse()<CR>


Known limitations:

* For char-motions highlighting is only triggered when pressing `;` or `,`
* `E` fails on highlighting the last character of the line
* Char-motions appear to be case-insensitive


Errors on update?  
* A gif was pushed on the repo, I realized it wasn't a good idea, thus I removed it from the repo and its history. The internet says this may cause some troubles.
* I changed the function's names, hence mappings need to be updated.
