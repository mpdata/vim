" myplace.vim
" Version:      1.0


if exists("g:loaded_myplace") || &cp
  finish
endif
let g:loaded_myplace = 1
let g:MyPlace_AuthorName      = 'Eotect Nahn'     
let g:MyPlace_AuthorRef       = 'eote'                         
let g:MyPlace_Email           = 'eotect@myplace'            
let g:MyPlace_Company         = 'MYPLACE HEL ORG.'    
function ModifyTemplate(name) 
        execute "%s/___AUTHOR___/" . g:MyPlace_AuthorName . "/g"
        execute "%s/___EMAIL___/" . g:MyPlace_Email . "/g"
        execute "%s/___COMPANY___/" . g:MyPlace_Company . "/g"
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


