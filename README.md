ShowMotion
==========

Tiny vim plugin to highlight landing places when moving with {w,W,b,B,e,E}.

Somewhat inspired by the EasyMotion plugin, this one is only aimed at providing cues about where you'll land, not allowing to select a specific landing place. The pleasant consequence of this is it doesn't break your moving flow, which was the motivation for writing it.

Highlights are triggered when pressing the w,W...,E keys thus some mappings are defined on these. Please let me know if you know a cleaner way.

Highlight group is defined for term vim, update it if you use gvim.

Highlight parameters are not (yet?) modifiable outside of the script.

Not yet very polished:
  highlights for f,F,t,T moves.
