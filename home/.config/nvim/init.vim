" >>> Basic
set syntax=c
set number
set nowrap
set nopaste
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set cindent
set smartindent
set hidden
set splitright
set backspace=indent,eol,start
set listchars=tab:»·,nbsp:·,trail:·
set updatetime=300
set autoread
set nohlsearch

" >>> Encodings
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,chinese,cp936,gb2312,big5,gb18030,gbk,latin1
set termencoding=utf-8

" 设置文件编码检测类型及支持格式
set fencs=utf-8,gbk,ucs-bom,gb18030,gb2312,cp936

" >>> Buffer list (show buffer list: ls)
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>
nnoremap <silent> <Left>  :bprevious<CR>
nnoremap <silent> <Right> :bnext<CR>

" >>> Arg list (show arg list: args)
nnoremap <silent> [a :previous<CR>
nnoremap <silent> ]a :pnext<CR>
nnoremap <silent> [A :first<CR>
nnoremap <silent> ]A :last<CR>

" >>> Quickfix list (show quickfix window: copen)
nnoremap <silent> [c :cprevious<CR>
nnoremap <silent> ]c :cnext<CR>
nnoremap <silent> [C :cfirst<CR>
nnoremap <silent> ]C :clast<CR>

" >>> Tag list of ctags (show tag select window: tselect)
" nnoremap <silent> <C-]> g<C-]> " show tselect list when mulpitle results
nnoremap <silent> [t :tprevious<CR>
nnoremap <silent> ]t :tnext<CR>
nnoremap <silent> [T :tfirst<CR>
nnoremap <silent> ]T :tlast<CR>

" 自动进入文件所在目录
execute "cd" expand("%:h")

" 保存时自动删除行尾空格
" autocmd BufWrite * :call DeleteTrailingWS()
function! DeleteTrailingWS()
    exec "normal mz"
    %s/\s\+$//ge
    exec "normal `z"
endfunc

" 禁止大文件产生swp文件
let g:large_file = 1024 * 1024
autocmd BufReadPre * let f=expand("<afile>") | if getfsize(f)
            \ > g:large_file | set noswapfile | endif
let mapleader = ","

call plug#begin(stdpath('data').'/plugged')

"--> Utils
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

"--> start screen, menu
Plug 'mhinz/vim-startify'
Plug 'skywind3000/vim-quickui'

"--> Themes, fonts, icons
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'
Plug 'ryanoasis/vim-devicons'

"--> Auto completion
"Plug 'neoclide/coc.nvim'

call plug#end()

" >>> Vim colors solarized
set background=dark
let g:solarized_termcolors = 256
colorscheme solarized

" >>> NERD_commenter
let NERDSpaceDelims = 1

" >>> Easy align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap <leader>a <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap <leader>a <Plug>(EasyAlign)

" >>> LeaderF
let g:Lf_WindowPosition = 'bottom'
let g:Lf_PreviewInPopup = 1
let g:Lf_ShowDevIcons = 1
let g:Lf_WindowHeight = 10
let g:Lf_GtagsAutoGenerate = 0
let g:Lf_GtagsAutoUpdate = 0
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_StlSeparator = { 'left': '', 'right': '' }
let g:Lf_WildIgnore = {
        \ 'dir': ['.svn','.git','.hg'],
        \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
        \}
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_ShowRelativePath = 0
let g:Lf_PreviewResult = { 'Function': 0 }
let g:Lf_ShortcutF = '<C-P>'
let g:Lf_ShortcutB = '<C-B>'
nnoremap <silent> <C-f> :LeaderfFunction<Cr>
nnoremap <silent> <C-g> :LeaderfFunctionAll<Cr>
nnoremap <silent> <leader>fp :Leaderf file<Cr>
nnoremap <silent> <leader>fb :Leaderf buffer<Cr>
nnoremap <silent> <leader>fm :Leaderf mru<Cr>
nnoremap <silent> <leader>ff :Leaderf function<Cr>
nnoremap <silent> <leader>fF :Leaderf function --all<Cr>
nnoremap <silent> <leader>fl :Leaderf line<Cr>
nnoremap <silent> <leader>fL :Leaderf line --all<Cr>
nnoremap <silent> <leader>fh :Leaderf help<Cr>
nnoremap <silent> <leader>fg :Leaderf gtags<Cr>

" >>> GitGutter
let g:gitgutter_enabled = 0
let g:gitgutter_signs = 1
let g:gitgutter_highlight_linenrs = 0
let g:gitgutter_highlight_lines = 1
nmap [h <Plug>(GitGutterPrevHunk)
nmap ]h <Plug>(GitGutterNextHunk)

" >>> Startify
let g:ascii = [
             \ '   | \ | | ___  _____   _(_)_ __ ___     ',
             \ '   |  \| |/ _ \/ _ \ \ / / | ''_ ` _ \   ',
             \ '   | |\  |  __/ (_) \ V /| | | | | | |   ',
             \ '   |_| \_|\___|\___/ \_/ |_|_| |_| |_|   ',
             \]
let g:startify_custom_header = g:ascii

" >>> Airline
set laststatus=2
set t_Co=256
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 0 " show trailing-white-space and mixed-indent
let g:airline_theme = 'murmur'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" >>> quickui

" clear all the menus
call quickui#menu#reset()

call quickui#menu#install("&Display", [
   \ [ "Toggle hl&search", 'set hlsearch! hlsearch?'],
   \ [ "Toggle l&ist",     'set list! list?'],
   \ [ "Toggle &wrap",     'set wrap! wrap?'],
   \ [ "Toggle &paste",    'set paste! paste?'],
   \ ])

call quickui#menu#install("&Plugin", [
   \ [ "GitGutter toggle on/off",           'GitGutterToggle',        'Toggle vim-gitgutter off and on '],
   \ [ "GitGutter next change\t(]h)",       'GitGutterNextHunk',      'jump to next hunk (change)'],
   \ [ "GitGutter previous change\t([h)",   'GitGutterPrevHunk',      'jump to previous hunk (change)'],
   \ [ "-"],
   \ [ "Commenter comment\t(<leader>cc)",   'normal ,cc',             'Comment out the current line or text selected in visual mode'],
   \ [ "Commenter comment\t(<leader>cs)",   'normal ,cs',             'Comments out the selected lines sexily'],
   \ [ "Commenter uncomment\t(<leader>cu)", 'normal ,cu',             'Uncomments the selected line(s)'],
   \ [ "-"],
   \ [ "EasyAlign align\t(vip<leader>a=)",  'normal vip,a=',          'Align align inner paragraph by ='],
   \ [ "-"],
   \ [ "LeaderF File\t(<leader>fp)",        'Leaderf file',           'Search files with leaderf'],
   \ [ "LeaderF Buffer\t(<leader>fb)",      'Leaderf buffer',         'Search buffers with leaderf'],
   \ [ "LeaderF Mru\t(<leader>fm)",         'Leaderf mru',            'Search mru with leaderf'],
   \ [ "LeaderF Funcion\t(<leader>ff)",     'Leaderf function',       'Search functions in current buffer with leaderf'],
   \ [ "LeaderF FuncionAll\t(<leader>fF)",  'Leaderf function --all', 'Search functions in all buffers with leaderf'],
   \ [ "LeaderF Line\t(<leader>fl)",        'Leaderf line',           'Search lines in current buffer with leaderf'],
   \ [ "LeaderF LineAll\t(<leader>fL)",     'Leaderf line --all',     'Search lines in all buffers with leaderf'],
   \ [ "LeaderF Help\t(<leader>fh)",        'Leaderf help',           'Search help tags with leaderf'],
   \ [ "LeaderF Gtags\t(<leader>fg)",       'Leaderf gtags',          'Search gtags with leaderf'],
   \ [ "-"],
   \ [ "Plugin Install",                    "PlugInstall",            "Install plugins"],
   \ [ "Plugin Update",                     "PlugUpdate",             "Update plugins"],
   \ [ "Plugin Status",                     "PlugStatus",             "Show plugin status"],
   \ ])

call quickui#menu#install("&Config", [
   \ [ "Vim configuration",     "e ~/.config/nvim/init.vim",    "Edit ~/.config/nvim/init.vim"],
   \ [ "I3wm configuration",    "e ~/.config/i3/config",        "Edit ~/.config/i3/config"],
   \ [ "Polybar configuration", "e ~/.config/polybar/config",   "Edit ~/.config/polybar/config"],
   \ [ "Rofi configuration",    "e ~/.config/rofi/config.rasi", "Edit ~/.config/rofi/config.rasi"],
   \ ])

let g:quickui_show_tip = 1
let g:quickui_border_style = 2
let g:quickui_color_scheme = 'solarized'

noremap <F1> :call quickui#menu#open()<cr>
noremap <leader><leader> :call quickui#menu#open()<cr>


" >>> coc.nvim

" TextEdit might fail if hidden is not set.
" set hidden

" Some servers have issues with backup files, see #649.
" set nobackup
" set nowritebackup

" Give more space for displaying messages.
" set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
" set updatetime=300

" Don't pass messages to |ins-completion-menu|.
" set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
" if has("patch-8.1.1564")
  " " Recently vim can merge signcolumn and number column into one
  " set signcolumn=number
" else
  " set signcolumn=yes
" endif

" Use <c-space> to trigger completion.
" if has('nvim')
  " inoremap <silent><expr> <c-n> coc#refresh()
" else
  " inoremap <silent><expr> <c-@> coc#refresh()
" endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
" if exists('*complete_info')
  " inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
" else
  " inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
" nmap <silent> [g <Plug>(coc-diagnostic-prev)
" nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
" nnoremap <silent> K :call <SID>show_documentation()<CR>

" function! s:show_documentation()
  " if (index(['vim','help'], &filetype) >= 0)
    " execute 'h '.expand('<cword>')
  " else
    " call CocAction('doHover')
  " endif
" endfunction

" Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
" nmap <leader>rn <Plug>(coc-rename)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
" xmap if <Plug>(coc-funcobj-i)
" omap if <Plug>(coc-funcobj-i)
" xmap af <Plug>(coc-funcobj-a)
" omap af <Plug>(coc-funcobj-a)
" xmap ic <Plug>(coc-classobj-i)
" omap ic <Plug>(coc-classobj-i)
" xmap ac <Plug>(coc-classobj-a)
" omap ac <Plug>(coc-classobj-a)
