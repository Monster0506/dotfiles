if exists("b:current_syntax")
	finish
endif

syntax keyword aptKeyword package package_from_url packagelist repository repository_file debconf_selection ppa
syntax keyword aptFunction update log_info log_fail
syntax match aptComment "\v#.*$"
syntax region aptString start=/\v"/ skip=/\v\\./ end=/\v"/

highlight link aptString String
highlight link aptKeyword Keyword
highlight link aptComment Comment
highlight link aptFunction Function

let b:current_syntax = "aptfile"
