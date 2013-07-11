"
" $Id: .vimrc,v 1.1 2003/02/01 23:49:04 huntert Exp huntert $
"
"set compatible
set nocompatible
let cpo_save=&cpo
set cpo=B
map! <xHome> <Home>
map! <xEnd> <End>
map! <S-xF4> <S-F4>
map! <S-xF3> <S-F3>
map! <S-xF2> <S-F2>
map! <S-xF1> <S-F1>
map! <xF4> <F4>
map! <xF3> <F3>
map! <xF2> <F2>
map! <xF1> <F1>
map <xHome> <Home>
map <xEnd> <End>
map <S-xF4> <S-F4>
map <S-xF3> <S-F3>
map <S-xF2> <S-F2>
map <S-xF1> <S-F1>
map <xF4> <F4>
map <xF3> <F3>
map <xF2> <F2>
map <xF1> <F1>
"
" terminal munging
"
if &term == "xterm"
    set t_kb=
endif
if &term == "xterm-color"
    set t_kb=
endif
"
" color terminal setup
"
"if &term =~ "xterm"
if has("terminfo")
  set t_Co=8
  set t_Sf=[3%p1%dm
  set t_Sb=[4%p1%dm
"  vt220-color|xterm-co|xterm with ANSI colors:\
"          :pa#64:Co#8:AF=\E[3%dm:AB=\E[4%dm:op=\E[39;49m:tc=vt220:
else
  set t_Co=8
  set t_Sf=[3%dm
  set t_Sb=[4%dm
endif
"endif
let &cpo=cpo_save
unlet cpo_save
set autoindent
set backspace=indent,eol,start
set shiftwidth=4
set smarttab
set wrapmargin=5
set textwidth=78
set formatoptions=vtqc
set showmatch
set comments=:\ \ #,s1:/*,mb:*,ex:*/,://,b:#,:%,:XCOMM,n:>,fb:-
set title
syntax on
highlight Normal guifg=yellow guibg=black
highlight Search gui=reverse guifg=white guibg=blue
"highlight Comment    ctermfg=white ctermbg=black
highlight Comment    ctermfg=8 ctermbg=black
highlight Statement  ctermfg=green 			" keywords
highlight Constant   ctermfg=cyan
highlight Identifier ctermfg=yellow			" variable
highlight Type       ctermfg=red			" package name
highlight Special    ctermfg=magenta			" regex escape?
"
" 0 - black	1 - dk red	2 - dk green	3 - dk brown/yellow
" 4 - dk blue	5 - dk purple	6 - dk cyan	7 - grey
" also bright:
" red green yellow blue magenta cyan darkgrey
"
"
" PreProc        term=underline  ctermfg=5  guifg=Purple
" Ignore         cterm=bold  ctermfg=7  guifg=bg
" Error          term=reverse  cterm=bold  ctermfg=7  ctermbg=1  guifg=White guibg=Red
" Todo           term=standout  ctermfg=0  ctermbg=3 guifg=Blue  guibg=Yellow
"
" use :Man command
"runtime ftplugin/man/default.vim
"runtime ftplugin/man/default.vim
"
" doesn't seem to work on rm2, other v5 systems
"
if version >= 600
    runtime ftplugin/man.vim
endif
