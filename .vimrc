" >>> Basic
syntax on
filetype on
filetype plugin on
set syntax=c
set number
set nowrap
set nopaste
set ts=4
set shiftwidth=4
"set expandtab
set autoindent
set cindent
set smartindent
set hidden " 允许隐藏缓冲区

" >>> CTRL+S to Save
nnoremap <silent> <C-s> :w<CR>
inoremap <silent> <C-s> <ESC>:w<cr>a

" >>> Search 
"set hlsearch " hightlight search
set incsearch " increase search 
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l> " clear screen and temporary disable highlight

" >>> Encodings
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb2312,big5,gb18030,gbk,latin1
set termencoding=utf-8

" >>> Buffer list (缓冲区列表 :ls)
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

" >>> Arg list (参数列表 :args)
nnoremap <silent> [a :previous<CR>
nnoremap <silent> ]a :next<CR>
nnoremap <silent> [A :first<CR>
nnoremap <silent> ]A :last<CR>

" >>> Quickfix list (quickfix列表 :copen)
nnoremap <silent> [c :cprevious<CR>
nnoremap <silent> ]c :cnext<CR>
nnoremap <silent> [C :cfirst<CR>
nnoremap <silent> ]C :clast<CR>

" >>> Tag list of ctags (tag多选列表 :tselect)
nnoremap <silent> <C-]> g<C-]> " show tselect list when mulpitle results
nnoremap <silent> [t :tprevious<CR>
nnoremap <silent> ]t :tnext<CR>
nnoremap <silent> [T :tfirst<CR>
nnoremap <silent> ]T :tlast<CR>

" >>> Move all files in Quickfix list to Arg list (:Qargs)
command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
function! QuickfixFilenames()
    let buffer_numbers = {}
    for quickfix_item in getqflist()
        let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
    endfor
    return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction

" >>> Open CtrlP buffer list
let g:ctrlp_cmd = 'CtrlPBuffer'
let g:ctrlp_custom_ignore = {
	\ 'dir':  '\v[\/]\.(git|hg|svn)$',
	\ 'file': '\v\.(exe|so|dll|o|lst)$',
	\ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
	\ }

" >>> \a to Toggle between c/h file
nnoremap <silent> \a :A<CR>


if &term =~ 'xterm'

	" >>> Command complete
	set wildmenu
	set wildmode=full

	" >>> Replace grep with ack
    set grepprg=ack\ --nogroup\ --column\ $*
    set grepformat=%f:%l:%c:%m

	" >>> Airline
	set laststatus=2
	set nocompatible
	set t_Co=256
	let g:airline_powerline_fonts = 1
	let g:airline#extensions#tabline#enabled = 1
	let g:airline_theme = 'murmur'
	" let g:airline#extensions#tabline#left_sep = ' '
	" let g:airline#extensions#tabline#left_alt_sep = '|'

	" >>> Theme
	"set t_Co=256
	set background=dark
	let g:solarized_termcolors=256
	colorscheme solarized

	" >>> Function keys

	" F1 hightlight search
	nnoremap <silent> <F1> :set hlsearch! hlsearch?<CR> 

	" F2 行号切换
	function! NumberToggle()
		if(&relativenumber == 1)
			set norelativenumber number
		else
			set relativenumber
		endif
	endfunc
	set listchars=tab:»·,nbsp:·,trail:·
	nnoremap <silent> <F2> :call NumberToggle()<CR>

	" F3 显示Tab键(Show Tab)
	nnoremap <silent> <F3> :set list! list?<CR>

	" F4 换行开关
	nnoremap <silent> <F4> :set wrap! wrap?<CR>

	" F5 Paste toggle
	nnoremap <silent> <F5> :set paste! paste?<CR>

	" F8 NERDTree window toggle
	nnoremap <silent> <F8> :NERDTreeToggle<CR>

	" F9 taglist window toggle
	let Tlist_Close_On_Select=1 " close taglist window on select
	let Tlist_GainFocus_On_ToggleOpen=1 " gain focus when taglist window open
	let Tlist_Use_Right_Window=1 " show taglist on the right
	nnoremap <silent> <F9> :TlistToggle<CR>

	" F10 Quickfix window toggle
	nnoremap <silent> <F10> :QFix<CR>

	" F12 Update ctags
	nnoremap <silent> <F12> :!ctags -R<CR>

endif

" >>> Templates
autocmd BufNewFile *.sh,*.py call SetFileHead()
function! SetFileHead()
	if &filetype == 'sh'
		call setline(1, ["\#!/usr/bin/env bash", ""])
	endif
	if &filetype == 'python'
		call setline(1, ["\#!/usr/bin/env python", "\# -*- coding:utf-8 -*-", ""])
	endif
	normal G
	normal o
endfunction

autocmd BufNewFile *.h call InsertHeadDef()
function InsertHeadDef()
    let sourcefilename=expand("%:t")
    let definename=substitute(sourcefilename,' ','','g')
    let definename=substitute(definename,'\.','_','g')
    let definename = toupper(definename)
    call setline('1', '#ifndef _'.definename."_")
    call setline('2', '#define _'.definename."_")
	call setline('3', ['', '', ''])
    call setline('6', '#endif')
	normal 4G
endfunction
