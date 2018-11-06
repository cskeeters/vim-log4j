if exists("loaded_log4j")
    finish
endif
let loaded_log4j = 1

command -nargs=0 Log4jDebug :call log4j#Config('DEBUG')
command -nargs=0 Log4jInfo  :call log4j#Config('INFO')
command -nargs=0 Log4jWarn  :call log4j#Config('WARN')
command -nargs=0 Log4jError :call log4j#Config('ERROR')

"nnoremap <space>l :Log4jDebug<cr>
