" Syntastic Settings

" disable highlighting
let g:syntastic_enable_highlighting = 0

" check buffers on open
let g:syntastic_check_on_open = 0

" better sign interface symbols
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'

" c language settings
let g:syntastic_c_include_dirs = [ 'src', 'src/include' ]
let g:syntastic_c_compiler_options = '-std=gnu99'

" c++ language settings
let g:syntastic_cpp_include_dirs = [ 'src', 'src/include' ]
let g:syntastic_cpp_compiler_options = '-std=c++0x'

" python language settings
let g:syntastic_python_checkers=['pylint', 'pyflake', 'python']

