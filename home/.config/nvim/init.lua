
local global_variables = {
    mapleader = ' ',
    largefile = 1024 * 1024,
}

local global_options = {
    syntax = 'on',
    number = true,
    wrap = false,
    paste = false,
    tabstop = 4,
    shiftwidth = 4,
    expandtab = true,
    autoindent = true,
    cindent = true,
    smartindent = true,
    hidden = true,
    splitright = true,
    background = 'dark',
    backspace = {'indent', 'eol', 'start'},
    listchars = {tab = '»·', nbsp = '·', trail = '·'},
    updatetime = 300,
    autoread = true,
    hlsearch = false,
    incsearch = true,
    encoding = 'utf-8',
    termencoding = 'utf-8',
    fileencodings = {'ucs-bom', 'utf-8', 'chinese', 'cp936', 'gb2312', 'big5', 'gb18030', 'gbk', 'latin1'},
    fencs = {'utf-8', 'gbk', 'ucs-bom', 'gb18030', 'gb2312', 'cp936'},
}

local global_mappings = {
    n = {
        options = { noremap = true, silent = true },
        mappings = {
            -- Buffer list (show buffer list: ls)
            ['[b'] = ':bprevious<CR>',
            [']b'] = ':bnext<CR>',
            ['[B'] = ':bfirst<CR>',
            [']B'] = ':blast<CR>',
            ['<Left>']  = ':bprevious<CR>',
            ['<Right>'] = ':bnext<CR>',
            ['<C-b><C-h>'] = ':bprevious<CR>',
            ['<C-b><C-l>'] = ':bnext<CR>',
            ['<C-b>c'] = ':b#<bar>bwipeout#<bar>b<CR>',

            -- Arg list (show arg list: args)
            ['[a'] = ':previous<CR>',
            [']a'] = ':pnext<CR>',
            ['[A'] = ':first<CR>',
            [']A'] = ':last<CR>',

            -- Quickfix list (show quickfix window: copen)
            ['[q'] = ':cprevious<CR>zz',
            [']q'] = ':cnext<CR>zz',
            ['[Q'] = ':cfirst<CR>zz',
            [']Q'] = ':clast<CR>zz',

            -- Tag list of ctags (show tag select window: tselect)
            ['[t'] = ':tprevious<CR>',
            [']t'] = ':tnext<CR>',
            ['[T'] = ':tfirst<CR>',
            [']T'] = ':tlast<CR>',

            -- Man page
            ['K'] = ':vertical Man <C-r><C-w><CR>',
        }
    }
}

local global_autocmds = {
    {
        event = {"BufWritePost"},
        opts = {
            command = 'source <afile> | PackerCompile',
            pattern = vim.fn.expand '$MYVIMRC',
        },
    }
}

function Apply_variables(group)
    for key, value in pairs(group) do
        vim.g[key] = value
    end
end

function Apply_options(group)
    for key, value in pairs(group) do
        vim.opt[key] = value
    end
end

function Apply_mappings(group)
    for mode, content in pairs(group) do
        for key, value in pairs(content.mappings) do
            vim.api.nvim_set_keymap(mode, key, value, content.options)
        end
    end
end

function Apply_autocmds(group)
    for idx, value in ipairs(group) do 
        vim.api.nvim_create_autocmd(value.event, value.opts)
    end
end

Apply_variables(global_variables)
Apply_options(global_options)
Apply_mappings(global_mappings)
Apply_autocmds(global_autocmds)

require('packer').startup({function(use)
    -- Packer can manage itself
    use { 'wbthomason/packer.nvim'}

    -- Themes, fonts, icons
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = function() require('lualine').setup {
            options = {
                theme = 'onedark',
                section_separators = { left = '', right = '' },
                component_separators = { left = '', right = '' },
                path = 1,
            },
            sections = {
                lualine_b = {'branch', 'diff'},
            },
            tabline = {
                lualine_a = {'buffers'},
                lualine_z = {'tabs'}
            },
        } end
    }

    use {
        'jacoborus/tender.vim',
        config = 'vim.cmd([[colorscheme tender]])',
    }

    -- Utils
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup({
                ignore = '^$',
                toggler = {
                    ---Line-comment toggle keymap
                    line = '<leader>cc',
                    ---Block-comment toggle keymap
                    block = '<leader>cs',
                },
                ---LHS of operator-pending mappings in NORMAL and VISUAL mode
                opleader = {
                    ---Line-comment keymap
                    line = '<leader>cc',
                    ---Block-comment keymap
                    block = '<leader>cs',
                },
                mappings = {
                    ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
                    basic = true,
                    ---Extra mapping; `gco`, `gcO`, `gcA`
                    extra = false,
                    ---Extended mapping; `g>` `g<` `g>[count]{motion}` `g<[count]{motion}`
                    extended = false,
                },
            })
        end
    }

    use {
        'junegunn/vim-easy-align',
        config = function()
            Apply_mappings({
                n = {
                    options = { noremap = true, silent = true },
                    mappings = {
                        ['<leader>a'] = '<Plug>(EasyAlign)',
                    }
                },
                x = {
                    options = { noremap = true, silent = true },
                    mappings = {
                        ['<leader>a'] = '<Plug>(EasyAlign)',
                    }
                },
            })
        end
    }

    use { 'tpope/vim-surround' }
    use { 'tpope/vim-repeat' }
    use { 'Darazaki/indent-o-matic' }

    -- Fuzz finder
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make'
    }

    use {
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('telescope').load_extension('fzf')
            require('telescope').setup{
                defaults = {
                    scroll_strategy = "limit",
                    mappings = {
                        i = {
                            ["<C-j>"] = require('telescope.actions').move_selection_next,
                            ["<C-k>"] = require('telescope.actions').move_selection_previous,
                        },
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
            Apply_mappings({
                n = {
                    options = { noremap = true, silent = true },
                    mappings = {
                        ['<leader>fp'] = ':Telescope find_files<cr>',
                        ['<leader>fb'] = ':Telescope buffers<cr>',
                        ['<leader>fj'] = ':Telescope jumplist<cr>',
                        ['<leader>fs'] = ':Telescope live_grep<cr>',
                        ['<leader>fl'] = ':Telescope current_buffer_fuzzy_find<cr>',
                        ['<leader>fh'] = ':Telescope help_tags<cr>',
                        ['<leader>fk'] = ':Telescope man_pages<cr>',
                        ['<leader>gs'] = ':Telescope grep_string<cr>',
                        ['<leader>gr'] = ':Telescope lsp_references<cr>',
                        ['<leader>gi'] = ':Telescope lsp_implementations<cr>',
                        ['<leader>gd'] = ':Telescope lsp_definitions<cr>',
                        ['<leader>gt'] = ':Telescope lsp_type_definitions<cr>',
                        ['<leader>ff'] = ':Telescope treesitter<cr>',
                    }
                }
            })
        end
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup {
                -- 安装 language parser
                -- :TSInstallInfo 命令查看支持的语言
                ensure_installed = {"c", "vim", "lua", "dockerfile"},
                -- 启用代码高亮功能
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false
                },
                -- 启用增量选择
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = '<CR>',
                        node_incremental = '<CR>',
                        node_decremental = '<BS>',
                        scope_incremental = '<TAB>',
                    }
                },
                -- 启用基于Treesitter的代码格式化(=) . NOTE: This is an experimental feature.
                indent = {
                    enable = true
                }
            }
            -- 开启 Folding
            vim.wo.foldmethod = 'expr'
            vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
            -- 默认不要折叠
            -- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
            vim.wo.foldlevel = 99
        end
    }

    -- LSP
    --[[ use {
        "neovim/nvim-lspconfig",
        config = function()
            require('lspconfig').sumneko_lua.setup {
                settings = {
                    Lua = {
                        runtime = {
                            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                            version = 'LuaJIT',
                        },
                        diagnostics = {
                            -- Get the language server to recognize the `vim` global
                            globals = {'vim'},
                        },
                        workspace = {
                            -- Make the server aware of Neovim runtime files
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                        -- Do not send telemetry data containing a randomized but unique identifier
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            }
            require('lspconfig').ccls.setup {
                init_options = {
                    -- compilationDatabaseDirectory = "build",
                    index = {
                        threads = 0,
                    },
                    clang = {
                        excludeArgs = { "-frounding-math"},
                    },
                }
            }
        end
    } ]]

end,
    config = {
        display = {
            open_fn = require('packer.util').float,
        }
    }
})

