" Folding Settings

if has("folding")
  set foldenable                " Enable folding
  set foldmethod=marker         " Fold using markers
  set foldlevel=100             " No folding by default

  " Commands that trigger auto-unfold
  set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
endif
