version 6.0
source $VIMRUNTIME/mswin.vim
behave mswin
set nocp
execute pathogen#infect()
syntax on
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
nnoremap <silent> <F7> :TlistToggle<CR>
nnoremap <silent> <F8> :Project<CR>
nnoremap <silent> <F9> :Project<CR>:close!<CR>

set background=light
set backspace=2
if $OS != "Windows_NT"
    set cscopeprg=/usr/bin/cscope
    set cscopetag
    set cscopeverbose
	set tags+=./tags,./.tags,tags,.tags,~/tags,`/.tags
endif
set guifont=Consolas:h10,Bitstream\ Vera\ Sans\ Mono,DejaVu\ Sans\ Mono\ 12,Mono
colorscheme darkocean 
"darkdot "papayawhip
set helplang=en
set history=50
set hlsearch
set mouse=a
set ruler
set viminfo='20,\"50
set nu 
filetype on
filetype plugin on
filetype plugin indent on
set tabstop=4
set softtabstop=4
set shiftwidth=4
"set expandtab
set autoindent
set laststatus=2
set statusline=%<%f\ [%1*%M%*%n%R%H]%=\ %-19(%3p%%:%3l,%02c%03V%)%O:'%02B'
hi User1 term=inverse,bold cterm=inverse,bold ctermfg=red
"set fdm=syntax
"set foldminlines=10
"set foldlevel=3
"set foldnestmax=3
let g:C_AuthorName      = 'eotect'     
let g:C_AuthorRef       = 'Eotect'                         
let g:C_Email           = 'eotect@myplace'            
let g:C_Company         = 'MYPLACE .HEL'    

function ModifyTemplate(name) 
        execute "%s/___AUTHOR___/eotect/g"
        execute "%s/___EMAIL___/eotect@myplace/g"
        execute "%s/___NAME___/" . a:name . "/g"
        execute "%s/___DATE___/" . strftime("%Y-%m-%d %H:%M") . "/g"
endfunction
function PerlModuleNew(name) 
    let dir = $XR_PERL_MODULE_DIR
    if dir == ""
        return 
    endif
    let name = substitute(a:name,"::","\/","g")
    let filename = dir . "/" . name . ".pm"
    execute "tabedit " . filename
    if !filereadable(filename)
        execute "0read !pmnew -o \"" . a:name . "\""
    endif
endfunction
command -nargs=+ Pmnew call PerlModuleNew(<f-args>)

function PerlScriptNew(name)
    let dir = $XR_PERL_SOURCE_DIR
    if dir == ""
        return
    endif
    let filename = dir . "/" . a:name . ".pl"
    execute "tabedit " . filename
    if !filereadable(filename)
        execute "0read !plnew -o \"" . a:name . "\""
    endif
endfunction
command -nargs=+ Plnew call PerlScriptNew(<f-args>)

function ScriptNew(name)
    let dir = $XR_SHELL_SOURCE_DIR
    if dir == ""
        return
    endif
    let filename = dir . "/" . a:name . ".sh"
    execute "tabedit " . filename
    if !filereadable(filename)
        execute "0read " . dir . "/script_template"
        call ModifyTemplate(a:name)
    endif
endfunction
command -nargs=+ Shnew call ScriptNew(<f-args>)

function CommandEdit(name)
    let filename = system("which " . shellescape(a:name))
    if filename != ""
        execute "tabedit " . filename
    else
        echo a:name . " not found!"
    endif
endfunction
command -nargs=+ Cmdedit call CommandEdit(<f-args>)

function URLRuleEdit(name,...) 
	let dir = $XR_PERL_SOURCE_DIR . "/urlrule/"
	let lvl = a:0 ? a:1 : 0
		let filename = "" . dir . lvl . "/" . a:name
    if !filereadable(filename)
		execute "tabedit " . filename
		execute "0read " . dir . "TEMPLATE" 
        call ModifyTemplate(a:name)
		execute "set filetype=perl"
	else
		execute "tabedit " . filename
	endif
endfunction
command -nargs=+ URnew call URLRuleEdit(<f-args>)


au GUIEnter * simalt ~x

"set fileencoding=utf-8
"set fileencodings=utf-8,cp936,latin1
"set binary

" Stick with the UTF-8 encoding.
if has('multi_byte')
  " Encoding used for the terminal.
  if empty(&termencoding)
    let &termencoding = &encoding
  endif

  " Encoding used in buffers, registers, strings in expressions, "viminfo"
  " file, etc.
  set encoding=utf-8

  " Encoding used for writing files.
  setglobal fileencoding=utf-8
endif

" Use both Unix and DOS file formats, but favor the Unix one for new files.
set fileformats=unix,dos
