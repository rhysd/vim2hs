if exists('b:current_syntax') && b:current_syntax == 'heist'
    finish
endif

runtime! syntax/html.vim

call vim2hs#heist#tags()
call vim2hs#heist#substitution()

let b:current_syntax = 'heist'
