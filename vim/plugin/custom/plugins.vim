" PLUGINS
" {{{

  " NERD Tree
  let NERDTreeChDirMode = 0                 " never change directory
  let NERDTreeStatusline=" "                " override status line
  let NERDTreeQuitOnOpen = 0                " close after opening file
  let NERDTreeIgnore = ['\.bak$', '\.swp$'] " ignore backup and swap files
  let NERDTreeSortOrder = ['\/$', '*']      " sort files then directories
  let NERDTreeWinSize = 24                  " set windows size
  "autocmd VimEnter * NERDTree               " automatically open NERDTree
  "autocmd BufEnter * NERDTreeMirror         " mirror NERDTree between tabs
  "autocmd VimEnter * wincmd w               " move cursor to file being edited
  
  " Tag Bar
  let g:tagbar_width = 24                   " set tagbar width
  let g:tarbar_expand = 0                   " expand window when opening tagbar
  "autocmd BufRead * TagbarOpen
  
  " UltiSnip
  let g:UltiSnipsExpandTrigger="<tab>"
  let g:UltiSnipsJumpForwardTrigger="<tab>"
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
  let g:UltiSnipsSnippetDirectories=["UltiSnips", "snippets"]
  
  " CtrlP
  let g:ctrlp_working_path_mode = 0         " do not manage working directory

  " Supertab
  "let g:SuperTabDefaultCompletionType = "context"
  "let g:SuperTabContextDefaultCompletionType="<c-x><c-o>"

  " Syntastic
  let g:syntastic_enable_highlighting = 0   " disable highlighting
  let g:syntastic_check_on_open = 1         " check buffers on open
  let g:syntastic_c_include_dirs = [ 'src', 'src/include' ]
  let g:syntastic_c_compiler_options = '-std=gnu99'
  
" }}}

