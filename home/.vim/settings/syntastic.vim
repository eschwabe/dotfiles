" Syntastic Settings

" disable highlighting
let g:syntastic_enable_highlighting = 0

" check buffers on open
let g:syntastic_check_on_open = 1

" c language settings
let g:syntastic_c_include_dirs = [ 'src', 'src/include' ]
let g:syntastic_c_compiler_options = '-std=gnu99'

" Better sign interface symbols
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
