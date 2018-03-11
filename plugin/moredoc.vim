"----------------------------------------------------------------------------------
" Project Name      - vimconfig/plugin/moredoc.vim
" Started On        - Mon  5 Mar 17:21:01 GMT 2018
" Last Change       - Sun 11 Mar 09:40:41 GMT 2018
" Author E-Mail     - terminalforlife@yahoo.com
" Author GitHub     - https://github.com/terminalforlife
"----------------------------------------------------------------------------------
" Display helpful screen information; good for code. Use <leader>more to toggle.
" Use VIM as a standard text editor, for non-code. Use with <leader>doc to toggle.
"----------------------------------------------------------------------------------

func! TFL_DocMode(...)
	if(a:0 == "true")
		"TODO - Not sure why this won't work.
		if filereadable("$HOME/.vim/plugin/sanekeys.vim")
			noremap k gj
			noremap l gk
		else
			noremap j gj
			noremap k gk
		endif
	endif

	if(exists("g:docmodestate") == 0)
		set linebreak
		set wrap
		syntax off

		let g:docmodestate="true"
		echo "Document Mode is enabled."
	elseif(g:docmodestate == "true")
		set nolinebreak
		set nowrap
		syntax on

		unlet g:docmodestate
		echo "Document Mode is disabled."
	endif
endfunc

func! TFL_MoreMode()
	if(exists("g:moremodestate") == 0)
		set showmatch
		set ruler
		set cursorline
		set norelativenumber
		set number
		set colorcolumn=84
		set laststatus=2

		let g:moremodestate="true"
		echo "More mode is enabled."
	elseif(g:moremodestate == "true")
		set noshowmatch
		set noruler
		set nocursorline
		set norelativenumber
		set nonumber
		set colorcolumn=0
		set laststatus=1

		unlet g:moremodestate
		echo "More mode is disabled."
	endif
endfunc

"TODO - This won't work; why?
if(&ft =~? '\(c\|sh\|python\|vim\)')
	call TFL_MoreMode()
elseif(&ft =~? '\(text\|markdown\)')
	call TFL_DocMode("true")
else
	" If all else fails, go by the file extension.
	if(expand("%:e") =~? '^\(c\|py\|sh\|vim\)$')
		silent call TFL_MoreMode()
	elseif(expand("%:e") =~? '^\(txt\|md\)$')
		silent call TFL_DocMode("true")
	endif
endif

noremap <silent> <leader>more :call TFL_MoreMode()<CR>
noremap <silent> <leader>doc :call TFL_DocMode("true")<CR>
