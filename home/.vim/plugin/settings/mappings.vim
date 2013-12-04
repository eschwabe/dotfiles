" Keyboard Mappings

" set paste toggle
set pastetoggle=<F3>

" edit and update vimrc
nmap <leader>ev :e $MYVIMRC<CR>
nmap <leader>sv :source $MYVIMRC<CR>

" replace tabs with spaces
nmap <leader>wt <ESC>:%s/	/    /g<CR>

" remove trailing whitespace
nmap <leader>ws <ESC>:%s/\s\+$//e<CR>

" open plugin windows
nmap <F2> :NERDTreeToggle<CR>

" clear search highlights
nmap <leader>h :noh<CR>

" make commands
nmap <leader>m :make! -C build<CR>
nmap <leader>d :make! -C build ctags cscope<CR>

" viewport control (left, down, up, right)
nmap <leader>h <C-w>h
nmap <leader>j <C-w>j
nmap <leader>k <C-w>k
nmap <leader>l <C-w>l

" follow tags
nmap <leader>tn <C-T>
nmap <leader>tp <C-]>

" switch buffers
nmap <C-Tab> :bn<CR>
nmap <C-S-Tab> :bp<CR>

" ctrlp mappings
nmap <leader>f :CtrlP<CR>
nmap <leader>b :CtrlPBuffer<CR>
