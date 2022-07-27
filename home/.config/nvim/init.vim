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
set incsearch

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
nnoremap <silent> <C-b><C-h> :bprevious<CR>
nnoremap <silent> <C-b><C-l> :bnext<CR>
nnoremap <silent> <C-b>c :b#<bar>bwipeout#<bar>b<CR>

" >>> Arg list (show arg list: args)
nnoremap <silent> [a :previous<CR>
nnoremap <silent> ]a :pnext<CR>
nnoremap <silent> [A :first<CR>
nnoremap <silent> ]A :last<CR>

" >>> Quickfix list (show quickfix window: copen)
nnoremap <silent> [q :cprevious<CR>zz
nnoremap <silent> ]q :cnext<CR>zz
nnoremap <silent> [Q :cfirst<CR>zz
nnoremap <silent> ]Q :clast<CR>zz

" >>> Tag list of ctags (show tag select window: tselect)
" nnoremap <silent> <C-]> g<C-]> " show tselect list when mulpitle results
nnoremap <silent> [t :tprevious<CR>
nnoremap <silent> ]t :tnext<CR>
nnoremap <silent> [T :tfirst<CR>
nnoremap <silent> ]T :tlast<CR>

" >>> Man page
nnoremap <silent> K :vertical Man <C-r><C-w><CR>

" 自动进入文件所在目录
" execute "cd" expand("%:h")

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
let mapleader = " "

call plug#begin(stdpath('data').'/plugged')

"--> Utils
Plug 'nvim-lua/plenary.nvim'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tversteeg/registers.nvim'

"--> start screen, menu
Plug 'mhinz/vim-startify'
Plug 'skywind3000/vim-quickui'

"--> Themes, fonts, icons
Plug 'nvim-lualine/lualine.nvim'
Plug 'jacoborus/tender.vim'
Plug 'kyazdani42/nvim-web-devicons'

"--> Auto completion
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" >>> Vim colors solarized
set background=dark
let g:solarized_termcolors=256
colorscheme tender

" >>> NERD_commenter
let NERDSpaceDelims = 1

" >>> Easy align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap <leader>a <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap <leader>a <Plug>(EasyAlign)

" >>> LeaderF
let g:Lf_WindowPosition = 'bottom'
let g:Lf_PopupShowStatusline = 0
let g:Lf_PreviewInPopup = 1
let g:Lf_ShowDevIcons = 1
let g:Lf_WindowHeight = 10
let g:Lf_JumpToExistingWindow = 0
let g:Lf_GtagsAutoGenerate = 0
let g:Lf_GtagsAutoUpdate = 0
let g:Lf_GtagsSkipUnreadable = 1
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_StlSeparator = { 'left': '', 'right': '' }
let g:Lf_WildIgnore = {
        \ 'dir': ['.svn','.git','.hg'],
        \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
        \}
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_ShowRelativePath = 0
let g:Lf_PreviewResult = { 'Function': 0, 'BufTag': 0, }
" let g:Lf_ShortcutF = '<leader>fp'
" let g:Lf_ShortcutB = '<leader>fb'
nnoremap <silent> <leader>f[ :Leaderf --previous<Cr>
nnoremap <silent> <leader>f] :Leaderf --next<Cr>
nnoremap <silent> <leader>f. :Leaderf --recall<Cr>
" nnoremap <silent> <leader>fp :Leaderf file<Cr>
" nnoremap <silent> <leader>fb :Leaderf buffer<Cr>
nnoremap <silent> <leader>ff :Leaderf function<Cr>
nnoremap <silent> <leader>fF :Leaderf function --all<Cr>
" nnoremap <silent> <leader>fm :Leaderf mru<Cr>
" nnoremap <silent> <leader>fl :Leaderf line<Cr>
" nnoremap <silent> <leader>fL :Leaderf line --all<Cr>
" nnoremap <silent> <leader>fh :Leaderf help<Cr>
nnoremap <silent> <leader>ft :Leaderf bufTag<Cr>
nnoremap <silent> <leader>fg :Leaderf gtags<Cr>
nnoremap <silent> <leader>fd :Leaderf gtags --definition <C-R><C-W> --auto-jump<Cr>
nnoremap <silent> <leader>fr :Leaderf gtags --reference <C-R><C-W> --auto-jump<Cr>
" nnoremap <silent> <leader>fs :Leaderf gtags --symbol <C-R><C-W> --auto-jump<Cr>

" >>> Telescope
nnoremap <leader>fp <cmd>Telescope find_files<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fj <cmd>Telescope jumplist<cr>
nnoremap <leader>fs <cmd>Telescope live_grep<cr>
nnoremap <leader>fl <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fk <cmd>Telescope man_pages<cr>
nnoremap <leader>gs <cmd>Telescope grep_string<cr>

lua << EOF
require('telescope').load_extension('fzf')
require('telescope').setup{
    defaults = {
        scroll_strategy = "limit",
        mappings = {
            i = {
                ["<C-j>"] = require('telescope.actions').move_selection_next,
                ["<C-k>"] = require('telescope.actions').move_selection_previous,
            }
        }
    },
    pickers = {
        buffers = {
            theme = "ivy",
        },
        jumplist = {
            theme = "ivy",
        },
        man_pages = {
            sections = { "ALL" },
        }
    },
}
EOF

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

" >>> lualine
lua <<EOF
require('lualine').setup {
    options = {theme = 'onedark'},
    tabline = {
        lualine_a = {'buffers'},
        lualine_z = {'tabs'}
    },
}
EOF

" >>> quickui

" clear all the menus
call quickui#menu#reset()

call quickui#menu#install("[&1]Builtin", [
   \ [ "[&1]Toggle hlsearch", 'set hlsearch! hlsearch?'],
   \ [ "[&2]Toggle list",     'set list! list?'],
   \ [ "[&3]Toggle wrap",     'set wrap! wrap?'],
   \ [ "[&4]Toggle paste",    'set paste! paste?'],
   \ [ "-"],
   \ [ "Buffer previous",     'bprevious'],
   \ [ "Buffer next",         'bnext'],
   \ [ "Buffer close",        'b#|bwipeout#|b'],
   \ [ "-"],
   \ [ "&Quickfix open",      'copen'],
   \ [ "Quickfix close",      'cclose'],
   \ ])

call quickui#menu#install("[&2]Telescope", [
   \ [ "Telescope find_files\t(<leader>fp)",                'Telescope find_files',                'Lists files in your current working directory'],
   \ [ "Telescope buffers\t(<leader>fb)",                   'Telescope buffers',                   'Lists open buffers in current neovim instance'],
   \ [ "Telescope jumplist\t(<leader>fj)",                  'Telescope jumplist',                  'Lists Jump List entries'],
   \ [ "Telescope live_grep\t(<leader>fs)",                 'Telescope live_grep',                 'Search for a string in your current working directory'],
   \ [ "Telescope current_buffer_fuzzy_find\t(<leader>fl)", 'Telescope current_buffer_fuzzy_find', 'Live fuzzy search inside of the currently open buffer'],
   \ [ "Telescope help_tags\t(<leader>fh)",                 'Telescope help_tags',                 'Lists available help tags'],
   \ [ "Telescope man_pages\t(<leader>fk)",                 'Telescope man_pages',                 'Lists manpage entries'],
   \ [ "-"],
   \ [ "Telescope grep_string\t(<leader>gs)",               'Telescope grep_string',               'Searches for the string under your cursor'],
   \ ])

call quickui#menu#install("[&3]Leaderf", [
   \ [ "LeaderF Recall\t(<leader>f.)",           'Leaderf --recall',           'Reopen last leaderf window'],
   \ [ "LeaderF Previous\t(<leader>f[)",         'Leaderf --previous',         'Jump to preview entry in leaderf'],
   \ [ "LeaderF Previous\t(<leader>f])",         'Leaderf --next',             'Jump to next entry in leaderf'],
   \ [ "LeaderF Funcion\t(<leader>ff)",          'Leaderf function',           'Search functions in current buffer with leaderf'],
   \ [ "LeaderF FuncionAll\t(<leader>fF)",       'Leaderf function --all',     'Search functions in all buffers with leaderf'],
   \ [ "LeaderF GTags\t(<leader>fg)",            'Leaderf gtags',              'Search gtags with leaderf'],
   \ [ "LeaderF GTags update",                   'Leaderf gtags --update',     'Create/update gtags with leaderf'],
   \ [ "-"],
   \ [ "LeaderF GTags definition\t(<leader>gd)", 'Leaderf gtags --definition', 'Searches for definition of the string under cursor'],
   \ [ "LeaderF GTags reference\t(<leader>gr)",  'Leaderf gtags --reference',  'Searches for reference of the string under cursor'],
   \ ])

call quickui#menu#install("[&4]Plugin", [
   \ [ "Gitblame toggle on/off",             'GitBlameToggle ',        'Toggle git blame off and on '],
   \ [ "-"],
   \ [ "Commenter comment\t(<leader>cc)",    'normal ,cc',             'Comment out the current line or text selected in visual mode'],
   \ [ "Commenter comment\t(<leader>cs)",    'normal ,cs',             'Comments out the selected lines sexily'],
   \ [ "Commenter uncomment\t(<leader>cu)",  'normal ,cu',             'Uncomments the selected line(s)'],
   \ [ "-"],
   \ [ "EasyAlign align\t(vip<leader>a=)",   'normal vip,a=',          'Align align inner paragraph by ='],
   \ [ "-"],
   \ [ "Plugin Install",                     "PlugInstall",            "Install plugins"],
   \ [ "Plugin Update",                      "PlugUpdate",             "Update plugins"],
   \ [ "Plugin Status",                      "PlugStatus",             "Show plugin status"],
   \ ])

call quickui#menu#install("[&5]Config", [
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
