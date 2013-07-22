" Default GUI options

if has("gui_running")

  set guitablabel=%t\ %m%r            " tab label
  set guioptions-=m                   " remove menu bar
  set guioptions-=l                   " remove left-hand scrollbar
  set guioptions-=L                   " remove left-hand scrollbar
  set guioptions-=r                   " remove right-hand scrollbar
  set guioptions-=R                   " remove right-hand scrollbar
  set title                           " show window title

endif

