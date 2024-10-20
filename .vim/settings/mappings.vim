" Keyboard Mappings

" set paste toggle
set pastetoggle=<F4>

" open plugin windows
nmap <F2> :NERDTreeToggle<CR>

" open tagbar plugin
nnoremap <silent> <F3> :TagbarToggle<CR>

" switch buffers
nmap <C-Tab> :bn<CR>
nmap <C-S-Tab> :bp<CR>

" edit and update vimrc
nmap <leader>ev :e $MYVIMRC<CR>
nmap <leader>sv :source $MYVIMRC<CR>

" replace tabs with spaces
nmap <leader>wt <ESC>:%s/	/    /g<CR>

" remove trailing whitespace
nmap <leader>ws <ESC>:%s/\s\+$//e<CR>

" clear search highlights
nmap <leader>h :noh<CR>

" make commands
nmap <leader>m :make! -C build<CR>
nmap <leader>mc :make! -C build ctags cscope<CR>

" viewport control (left, down, up, right)
nmap <leader>h <C-w>h
nmap <leader>j <C-w>j
nmap <leader>k <C-w>k
nmap <leader>l <C-w>l

" follow tags
nmap <leader>tn <C-T>
nmap <leader>tp <C-]>

" ctrlp mappings
nmap <leader>f :CtrlP<CR>
nmap <leader>b :CtrlPBuffer<CR>

" insert timestamp
nmap <leader>i a<C-R>=strftime("%Y-%m-%d %I:%M:%S")<CR><Esc>
imap <leader>i <C-R>=strftime("%Y-%m-%d %I:%M:%S")<CR>
