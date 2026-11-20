" SPDX-License-Identifier: Apache-2.0
" Pooka regex highlighting, used when the Tree-sitter parser is unavailable.
if exists("b:current_syntax")
  finish
endif

syntax keyword pookaKeyword actor as assert be break class continue echo enum external fn from if import in interface is let loop match module native new panic skip test todo var with
syntax keyword pookaConstant False Nil True self super
syntax match pookaNumber @0[xX][0-9a-fA-F_]\+@
syntax match pookaNumber @0[bB][01_]\+@
syntax match pookaNumber @0[oO][0-7_]\+@
syntax match pookaNumber @[0-9][0-9_]*\(\.[0-9][0-9_]*\)\?\([eE][+-]\?[0-9][0-9_]*\)\?@
syntax match pookaFunction @_*[a-z][a-zA-Z0-9_]*\ze\s*(@
syntax match pookaVariant @_*[A-Z][a-zA-Z0-9_]*\._*[A-Z][a-zA-Z0-9_]*@
syntax match pookaType @_*[A-Z][a-zA-Z0-9_]*@
syntax match pookaOperator @\V!=\|&&\|*=\|+=\|-=\|<=\|==\|>=\||>\|||\|..\|->\|!\|%\|&\|*\|+\|-\|/\|<\|=\|>\|?\||@
syntax match pookaBracket @\V#(\|<<\|>>\|(\|)\|[\|]\|{\|}@
syntax match pookaDelimiter @\V,\|:\|.@

syntax match pookaModuleComment @/\{4\}.*$@
syntax match pookaDocComment @/\{3\}\([^/].*\|$\)@
syntax match pookaComment @//\([^/].*\|$\)@
syntax region pookaString start=/"/ skip=/\\./ end=/"/ contains=pookaEscape
syntax match pookaEscape @\\\(u{[0-9a-fA-F]\+}\|[^u]\)@ contained

highlight default link pookaKeyword Keyword
highlight default link pookaConstant Constant
highlight default link pookaComment Comment
highlight default link pookaDocComment SpecialComment
highlight default link pookaModuleComment SpecialComment
highlight default link pookaString String
highlight default link pookaEscape SpecialChar
highlight default link pookaNumber Number
highlight default link pookaFunction Function
highlight default link pookaVariant Constant
highlight default link pookaType Type
highlight default link pookaOperator Operator
highlight default link pookaBracket Delimiter
highlight default link pookaDelimiter Delimiter

let b:current_syntax = "pooka"
