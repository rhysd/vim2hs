if exists('b:current_syntax') && b:current_syntax == 'lhaskell'
    finish
endif

syntax clear
runtime! syntax/markdown.vim
unlet b:current_syntax

call vim2hs#haskell#markdown#literate()

let b:current_syntax = "lhaskell"
