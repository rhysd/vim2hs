function! vim2hs#haskell#quasi#quote() " {{{

    syntax match hsQuasiQuote /\[\$\?\k*|[^|]\+|\]/ contains=hsQuasi
    syntax match hsQuasi /|[^|]\+|/hs=s+1,he=e-1
                \ contained containedin=hsQuasiQuote

    highlight! link hsQuasiQuote Delimiter
    highlight! link hsQuasi Macro
endfunction " }}}


function! vim2hs#haskell#quasi#interpolation() " {{{
    syntax match hsStringQQuote /\[\$\?[sq]|[^|]\+|\]/
                \ contains=hsStringQQ

    syntax match hsStringQQ /|[^|]\+|/hs=s+1,he=e-1
                \ contained containedin=hsStringQQuote contains=@Spell

    syntax region hsP6Interpolation matchgroup=hsP6AntiQuote
                \ start="{" end="}"
                \ keepend contained contains=TOP

    syntax match hsP6Identifier
                \ "\$\k\+"
                \ contained

    syntax match hsP6QQuote /\[\$\?qc|[^|]\+|\]/
                \ contains=hsP6QQ

    syntax match hsP6QQ /|[^|]\+|/hs=s+1,he=e-1
                \ contained containedin=hsP6QQuote contains=hsP6Interpolation,@Spell

    syntax match hsP6QQuote /\[\$\?qq|[^|]\+|\]/
                \ contains=hsP6QQ

    syntax match hsP6QQ /|[^|]\+|/hs=s+1,he=e-1
                \ contained containedin=hsP6QQuote contains=hsP6Identifier,hsP6Interpolation,@Spell

    syntax region hsRubyInterpolation matchgroup=hsRubyAntiQuote
                \ start="#{" end="}"
                \ keepend contained contains=TOP

    syntax match hsRubyQQuote /\[\$\?istr|[^|]\+|\]/
                \ contains=hsRubyQQ

    syntax match hsP6QQ /|[^|]\+|/hs=s+1,he=e-1
                \ contained containedin=hsRubyQQuote contains=hsRubyInterpolation,@Spell

    highlight! link hsStringQQuote Delimiter
    highlight! link hsStringQQ String
    highlight! link hsP6QQuote Delimiter
    highlight! link hsP6QQ String
    highlight! link hsP6AntiQuote PreProc
    highlight! link hsP6Identifier Identifier
    highlight! link hsRubyQQuote Delimiter
    highlight! link hsRubyQQ String
    highlight! link hsRubyAntiQuote PreProc
endfunction " }}}


function! vim2hs#haskell#quasi#regex() " {{{
    syntax match regexSpecialChar
                \ /\\[a-zA-Z]/
                \ contained

    syntax match regexOperator
                \ "[\(]\@<![.*+?]"
                \ contained

    syntax match regexDelimiter
                \ "(\|)\|\[\|\]\|{\|}"
                \ contained

    syntax match regexStructure
                \ "(\@<=?.\|[$^]"
                \ contained

    syntax cluster regex
                \ contains=regexSpecialChar,regexOperator,
                \regexDelimiter,regexStructure

    syntax region hsRexMap matchgroup=hsRexMapQuote
                \ start="(\@<=?{" end="}\%(.*)\)\@="
                \ keepend contained contains=TOP

    syntax match hsRexQuote /\[\$\?b\?rex|[^|]\+|\]/
                \ contains=hsRex

    syntax match hsRexQQ /|[^|]\+|/hs=s+1,he=e-1
                \ contained containedin=hsRexQuote contains=@regex,hsRexMap

    syntax match hsRelitQuote /\[\$\?b\?re|[^|]\+|\]/
                \ contains=hsRelit

    syntax match hsP6QQ /|[^|]\+|/hs=s+1,he=e-1
                \ contained containedin=hsRelitQuote contains=@regex

    syntax match hsRegexQQote /\[\$\?b\?rx|[^|]\+|\]/
                \ contains=hsRegexQQ

    syntax match hsRegexQQ /|[^|]\+|/hs=s+1,he=e-1
                \ contained containedin=hsRegexQQuote contains=@regex

    highlight! link regexSpecialChar SpecialChar
    highlight! link regexOperator Operator
    highlight! link regexDelimiter Delimiter
    highlight! link regexStructure Structure

    highlight! link hsRexQuote Delimiter
    highlight! link hsRex String
    highlight! link hsRexMapQuote PreProc

    highlight! link hsRelitQuote Delimiter
    highlight! link hsRelit String

    highlight! link hsRegexQQuote Delimiter
    highlight! link hsRegexQQ String
endfunction " }}}


function! vim2hs#haskell#quasi#jmacro() " {{{
    syntax include @jmacro syntax/jmacro.vim
    unlet b:current_syntax

    syntax region hsJmacroSplice matchgroup=hsJmacroAntiQuote
                \ start="`(" end=")`"
                \ keepend contained contains=TOP

    syntax match hsJmacroQuote /\[\$\?jmacroE\?|[^|]\+|\]/
                \ contains=hsJmacro

    syntax match hsJmacro /|[^|]\+|/hs=s+1,he=e-1
                \ contained containedin=hsJmacroQuote contains=hsJmacroSplice,@jmacro

    highlight! link hsJmacroQuote Delimiter
    highlight! link hsJmacroAntiQuote PreProc
endfunction " }}}


function! vim2hs#haskell#quasi#shqq() " {{{
    syntax include @shell syntax/sh.vim
    unlet b:current_syntax

    syntax match hsShQQInterpolation
                \ "\$+\?\%({\k\+}\|\k\+\)"
                \ contained

    syntax match hsShQQuote /\[\$\?shc\?|[^|]\+|\]/
                \ contains=hsShQQ

    syntax match hsShQQ /|[^|]\+|/hs=s+1,he=e-1
                \ contained containedin=hsShQQuote contains=hsShQQInterpolation,@shell

    highlight! link hsShQQuote Delimiter
    highlight! link hsShQQInterpolation Identifier
endfunction " }}}


function! vim2hs#haskell#quasi#sql() " {{{
    syntax include @sql syntax/sql.vim
    unlet b:current_syntax

    syntax region hsSQLSplice matchgroup=hsSQLSpliceQuote
                \ start="\$[si]\?(" end=")"
                \ contained contains=TOP

    syntax match hsSQLQuote /\[\$\?\%(sql\|sqlStmts\?\|pgsqlStmts\?\|sqlExpr\)|[^|]\+|\]/
                \ contains=hsSQL

    syntax match hsSQL /|[^|]\+|/hs=s+1,he=e-1
                \ contained containedin=hsSQLQuote contains=hsSQLSplice,@sql

    highlight! link hsSQLQuote Delimiter
    highlight! link hsSQLSpliceQuote Preproc
endfunction " }}}


function! vim2hs#haskell#quasi#json() " {{{
    try
        syntax include @json syntax/json.vim
    catch /^Vim\%((\a\+)\)\=:E484/
        syntax include @json syntax/javascript.vim
    endtry
    unlet b:current_syntax

    syntax match hsJSONQuote /\[\$\?json|[^|]\+|\]/
                \ contains=hsJSON

    syntax match hsJSON /|[^|]\+|/hs=s+1,he=e-1
                \ contained containedin=hsJSONQuote contains=@json

    syntax match hsJSONQQKey
                \ '\$\k\+'
                \ contained

    syntax region hsJSONQQSplice matchgroup=hsJSONQQSpliceQuote
                \ start='<<' end='>>'
                \ contained contains=TOP

    syntax region hsJSONQQSplice matchgroup=hsJSONQQSpliceQuote
                \ start='<|' end='|>'
                \ contained contains=TOP

    syntax match hsJSONQuote /\[\$\?\%(jsonQQ\|aesonQQ\)|[^|]\+|\]/
                \ contains=hsJSON

    syntax match hsJSON /|[^|]\+|/hs=s+1,he=e-1
                \ contained containedin=hsJSONQuote contains=hsJSONQQKey,hsJSONQQSplice,@json

    highlight! link hsJSONQuote Delimiter
    highlight! link hsJSONQQSpliceQuote PreProc
    highlight! link hsJSONQQKey Identifier
endfunction " }}}


function! vim2hs#haskell#quasi#xml() " {{{
    syntax include @xml syntax/xml.vim
    unlet b:current_syntax

    syntax match hsXMLQuote /\[\$\?xml|[^|]\+|\]/
                \ contains=hsXML

    syntax match hsXML /|[^|]\+|/hs=s+1,he=e-1
                \ contained containedin=hsXMLQuote contains=@xml

    syntax region hsXMLQQElement matchgroup=hsXMLQQElementQuote
                \ start='<<' end='>>'
                \ contained contains=TOP

    syntax region hsXMLQQSplice matchgroup=hsXMLQQSpliceQuote
                \ start='{' end='}'
                \ contained contains=TOP containedin=xmlTag,xmlEndTag

    syntax match hsXMLQuote /\[\$\?xmlQQ|[^|]\+|\]/
                \ contains=hsXML

    syntax match hsXML /|[^|]\+|/hs=s+1,he=e-1
                \ contained containedin=hsXMLQuote contains=hsXMLQQElement,hsXMLQQSplice,@xml

    highlight! link hsXMLQuote Delimiter
    highlight! link hsXMLQQElementQuote PreProc
    highlight! link hsXMLQQSpliceQuote PreProc
endfunction " }}}
