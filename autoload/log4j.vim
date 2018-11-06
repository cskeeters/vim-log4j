let s:save_cpo = &cpo
set cpo&vim

function! log4j#get_package()
    let maxLines = line("$")
    let lineno = 1
    while lineno <= maxLines
        let text = getline(lineno)
        let m = matchlist(text, '^package \(.*\);$')
        if len(m) > 0
            return m[1]
        endif

        let lineno += 1
    endwhile

    throw "could not find package"
endfunction

function! log4j#get_class_name()
    let maxLines = line("$")
    let lineno = 1
    while lineno <= maxLines
        let text = getline(lineno)
        let m = matchlist(text, 'class \([^ ]*\)')
        if len(m) > 0
            return m[1]
        endif

        let lineno += 1
    endwhile

    throw "could not find class name"
endfunction

function! log4j#get_path()
    return findfile('log4j.properties', '**')
endfunction

function! log4j#Config(level)
    let package = log4j#get_package()
    let class_name = log4j#get_class_name()
    let l:log4j_properties_path = log4j#get_path()
    if l:log4j_properties_path != ''
        echom 'edit '.l:log4j_properties_path
        execute 'edit '.log4j_properties_path
        let line_number = line('$')+1
        let config = "log4j.logger.".package.'.'.class_name."=".a:level
        call setline(line_number, config)
        normal! G$b
    else
        echom "Could not find log4j.properties"
    endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
