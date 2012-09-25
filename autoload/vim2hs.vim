function! vim2hs#letdefault(var, val) " {{{
  if !exists(a:var)
    execute "let " . a:var . " = " . string(a:val)
  endif
endfunction " }}}
