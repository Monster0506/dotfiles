setlocal foldmethod=expr
setlocal foldexpr=GetAptFold(v:lnum)

function! GetAptFold(lnum)
    if getline(a:lnum) =~? '\v^\s*$'
        return 0
    endif
    " If the line starts with package, return 1
    if getline(a:lnum) =~? '^\s*package'
        return 1
    endif
    " If the line starts with a '#' sign, return 1
    if getline(a:lnum) =~? '^\s*\#'
        return 1
    endif
    
endfunction
