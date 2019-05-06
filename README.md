ShowMotion
==========

Ever hammered the {`w`,`W`,`b`,`B`,`e`,`E`,`;`,`,`} keys to finally pass over the location you were aiming for?
ShowMotion is a tiny vim plugin to highlight the potential landing places when moving:

* by words with {`w`,`W`,`b`,`B`,`e`,`E`}.
* by chars with {`f`,`F`,`t`,`T`,`;`,`,`}

Somewhat inspired by the EasyMotion plugin, this one is only aimed at providing cues about where you'll land, not allowing to select a specific landing place. The pleasant consequence of this is it doesn't break your moving flow, which was the motivation for writing it.

 <!--![Demo](https://i.imgur.com/sWUqiF3.gif)-->

Installation:

 I suggest using [pathogen](https://github.com/tpope/vim-pathogen)


Add these highlighting settings to your vimrc:

    highlight SM_SmallMotionGroup cterm=italic                ctermbg=53 gui=italic                guibg=#5f005f
    highlight SM_BigMotionGroup   cterm=italic,bold,underline ctermbg=54 gui=italic,bold,underline guibg=#5f0087
    highlight SM_CharSearchGroup  cterm=italic,bold           ctermbg=4  gui=italic,bold           guibg=#3f6691

Add these word-motion settings to your vimrc:

    "*** Highlights both big and small motions
    nmap w <Plug>(show-motion-both-w)
    nmap W <Plug>(show-motion-both-W)
    nmap b <Plug>(show-motion-both-b)
    nmap B <Plug>(show-motion-both-B)
    nmap e <Plug>(show-motion-both-e)
    nmap E <Plug>(show-motion-both-E)

    "*** Only highlights motions corresponding to the one you typed
    nmap w <Plug>(show-motion-w)
    nmap W <Plug>(show-motion-W)
    nmap b <Plug>(show-motion-b)
    nmap B <Plug>(show-motion-B)
    nmap e <Plug>(show-motion-e)
    nmap E <Plug>(show-motion-E)

Add these character-motion settings to your vimrc:

    "Show motion for chars:
    nmap f <Plug>(show-motion-f)
    nmap t <Plug>(show-motion-t)
    nmap F <Plug>(show-motion-F)
    nmap T <Plug>(show-motion-T)
    nmap ; <Plug>(show-motion-;)
    nmap , <Plug>(show-motion-,)


Known limitations:

* `E` fails on highlighting the last character in the line


Errors on update?
* A gif was pushed on the repo, I realized it wasn't a good idea, thus I removed it from the repo and its history. The internet says this may cause some troubles.
* I changed the function's names, hence mappings need to be updated.

Thanks:

* IRC: #vim, sakkemo, bairui, Raimondi and many others
* Github: itchyny, haya14busa, Pyrohh
