" >>> Basic
syntax on
filetype on
filetype plugin on
set nocompatible
set syntax=c
set number
set nowrap
set nopaste
set ts=4
set shiftwidth=4
set expandtab
set autoindent
set cindent
set smartindent
set hidden " Allowing switch to other buffer without saving

let mapleader = ","
nnoremap <silent> Y y$

" >>> Search
"set hlsearch " hightlight search
set incsearch " increase search
vnoremap // y/<C-R>"<CR> " Search for visually selected text
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l> " clear screen and temporary disable highlight

" >>> Encodings
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb2312,big5,gb18030,gbk,latin1
set termencoding=utf-8

" >>> Buffer list (show buffer list: ls)
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

" >>> Arg list (show arg list: args)
nnoremap <silent> [a :previous<CR>
nnoremap <silent> ]a :next<CR>
nnoremap <silent> [A :first<CR>
nnoremap <silent> ]A :last<CR>

" >>> Quickfix list (show quickfix window: copen)
nnoremap <silent> [c :cprevious<CR>
nnoremap <silent> ]c :cnext<CR>
nnoremap <silent> [C :cfirst<CR>
nnoremap <silent> ]C :clast<CR>

" >>> Tag list of ctags (show tag selection window :tselect)
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

" >>> Plugins (Bundle)
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'a.vim'
Plugin 'ctrlp.vim'
Plugin 'tacahiroy/ctrlp-funky'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'Raimondi/delimitMate'
Plugin 'majutsushi/tagbar'
Plugin 'surround.vim'
Plugin 'The-NERD-Tree'
Plugin 'The-NERD-Commenter'
Plugin 'xterm-color-table.vim'
Plugin 'asins/vimcdoc'
Plugin 'Yggdroot/indentLine'
Plugin 'vim-scripts/ShowMarks7'
Plugin 'vim-scripts/Marks-Browser'
Plugin 'vim-scripts/QFixToggle'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'junegunn/vim-easy-align'
Plugin 'altercation/vim-colors-solarized'
Plugin 'git://fedorapeople.org/home/fedora/wwoods/public_git/vim-scripts.git'
call vundle#end()
filetype plugin indent on

" >>> NERD-Commenter
let NERDSpaceDelims = 1

" >>> Easy Align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap <leader>a <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap <leader>a <Plug>(EasyAlign)

" >>> Open CtrlP buffer list
let g:ctrlp_cmd = 'CtrlPBuffer'
let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/]\.(git|hg|svn)$',
            \ 'file': '\v\.(exe|so|dll|o|lst)$',
            \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
            \ }
let g:ctrlp_funky_syntax_highlight = 1
let g:ctrlp_extensions = ['funky']

" >>> <leader>h - Toggle between c/h file
nnoremap <silent> <leader>h :A<CR>


if &term =~ 'xterm'

    " >>> Command complete
    set wildmenu
    " set wildmode=full
    set wildmode=list:longest

    " >>> Replace grep with ack
    set grepprg=ack\ --nogroup\ --column\ $*
    set grepformat=%f:%l:%c:%m

    " >>> Airline
    set laststatus=2
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

    " F1 Hightlight search
    nnoremap <silent> <F1> :set hlsearch! hlsearch?<CR>

    " F2 ShowMarks toggle
    let showmarks_include="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    let showmarks_ignore_type="hqm"
    let g:showmarks_hlline_lower=1
    let g:showmarks_hlline_upper=1
    hi ShowMarksHLl ctermbg=Yellow   ctermfg=Black  guibg=#FFDB72 guifg=Black
    hi ShowMarksHLu ctermbg=Magenta  ctermfg=Black  guibg=#FFB3FF guifg=Black
    nnoremap <silent> <F2> :ShowMarksToggle<CR>

    " F3 Show listchars
    set listchars=tab:»·,nbsp:·,trail:·
    nnoremap <silent> <F3> :set list! list?<CR>

    " F4 Toggle IndentLines
    let g:indentLine_enabled = 0
    let g:indentLine_color_term = 236
    nnoremap <silent> <F4> :IndentLinesToggle<CR>

    " F5 Toggle wrap
    nnoremap <silent> <F5> :set wrap! wrap?<CR>

    " F6 Paste toggle
    nnoremap <silent> <F6> :set paste! paste?<CR>

    " F8 Update ctags
    set tags+=./../tags,./../../tags,./../../../tags,./../../../../tags
    nnoremap <silent> <F8> :!ctags -R<CR>

    " F9 NERDTree window toggle
    nnoremap <silent> <F9> :NERDTreeToggle<CR>
    nnoremap <silent> <leader>e :NERDTreeToggle<CR>

    " F10 tagbar window toggle
    nnoremap <silent> <F10> :TagbarToggle<CR>
    nnoremap <silent> <leader>t :TagbarToggle<CR>
    let g:tagbar_autofocus = 1

    " F11 Quickfix window toggle
    nnoremap <silent> <F11> :QFix<CR>

    " F12 Marks-Browser toggle
    nnoremap <silent> <F12> :MarksBrowser<CR>

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
function! InsertHeadDef()
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
