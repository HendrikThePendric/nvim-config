vim.cmd("packadd packer.nvim")

return require("packer").startup(function()
    use({
        "wbthomason/packer.nvim",
        opt = true
    })

    use("nathom/filetype.nvim") -- improves startup time
    -- basic
    use("tpope/vim-sleuth") -- detects indentation
    use({
        "numToStr/Comment.nvim",
        config = function()
            require("plugins.comment")
        end
    })
    use({
        "lewis6991/gitsigns.nvim",
        config = function()
            require("plugins.gitsigns")
        end
    })
    use({
        "andymass/vim-matchup",
        config = function()
            require("plugins.matchup")
        end
    }) -- improves %, now with treesitter
    use('roxma/vim-window-resize-easy') -- repeat window resize commands

    -- additional functionality
    use {
        'phaazon/hop.nvim',
        config = function()
            -- you can configure Hop the way you like here; see :h hop-config
            require'hop'.setup()
        end
    }
    use({
        "svermeulen/vim-subversive",
        config = function()
            require("plugins.subversive")
        end
    }) -- adds substitute operator
    use("tpope/vim-abolish") -- case perserving substitutions
    use {'L3MON4D3/LuaSnip'}
    use "rafamadriz/friendly-snippets" -- snippets
    use {
        'rmagatti/auto-session',
        config = function()
            require("plugins.auto-session")
        end
    } -- session management
    use {
        'rmagatti/session-lens',
        requires = {'rmagatti/auto-session', 'nvim-telescope/telescope.nvim'},
        config = function()
            require('session-lens').setup()
        end
    }
    use({
        "windwp/nvim-autopairs",
        config = function()
            require("plugins.autopairs")
        end
    }) -- autocomplete pairs
    use({
        "hrsh7th/nvim-cmp", -- completion
        requires = {"hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "hrsh7th/cmp-cmdline",
                    "saadparwaiz1/cmp_luasnip", "hrsh7th/cmp-nvim-lsp-signature-help", "onsails/lspkind-nvim",
                    "folke/lua-dev.nvim"},
        config = function()
            require("plugins.cmp")
        end
    })
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make'
    }
    use 'nvim-telescope/telescope-file-browser.nvim'
    use({
        "nvim-telescope/telescope.nvim", -- fuzzy finder
        config = function()
            require("plugins.telescope")
        end
    })

    -- lsp
    use("neovim/nvim-lspconfig") -- makes lsp configuration easier
    use({
        "RRethy/vim-illuminate",
        config = function()
            require("plugins.illuminate")
        end
    }) -- highlights and allows moving between variable references
    use("b0o/schemastore.nvim") -- simple access to json-language-server schemae
    use("jose-elias-alvarez/null-ls.nvim") -- transforms CLI output / Lua code into language server diagnostics, formatting, and more
    use("jose-elias-alvarez/nvim-lsp-ts-utils") -- improves TypeScript development experience
    use("glepnir/lspsaga.nvim") -- pretty lsp

    -- treesitter
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = function()
            require("plugins.treesitter")
        end
    })
    use("nvim-treesitter/playground")
    use("nvim-treesitter/nvim-treesitter-textobjects")
    use({
        "windwp/nvim-ts-autotag",
        ft = {"typescript", "typescriptreact"}
    }) -- automatically close jsx tags
    use({
        "JoosepAlviste/nvim-ts-context-commentstring",
        ft = {"typescript", "typescriptreact"}
    }) -- makes jsx comments actually work

    -- visual
    use("kyazdani42/nvim-web-devicons") -- icons
    use({
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("plugins.indent-blankline")
        end
    }) -- show indent markers
    use({
        "nvim-lualine/lualine.nvim",
        config = function()
            require("plugins.lualine")
        end
    }) -- statusline

    -- misc
    use("nvim-lua/plenary.nvim")
    use({
        "iamcco/markdown-preview.nvim", -- preview markdown output in browser
        opt = true,
        ft = {"markdown"},
        config = "vim.cmd[[doautocmd BufEnter]]",
        run = "cd app && yarn install",
        cmd = "MarkdownPreview"
    })
    use {
        'kevinhwang91/nvim-bqf',
        ft = 'qf'
    } -- better quickfix window
    use {'MunifTanjim/nui.nvim'} -- nice ui
    use {
        'junegunn/fzf',
        run = function()
            vim.fn['fzf#install']()
        end
    } -- fuzzy search, recommended addition to nvim-bqf

    use 'folke/lsp-colors.nvim'
    use 'norcalli/nvim-colorizer.lua'
    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup {}
        end
    }
    use 'tpope/vim-fugitive'
    use 'svermeulen/vim-yoink'
    use 'famiu/nvim-reload'
    use 'tonchis/vim-to-github'
    use 't9md/vim-choosewin'
    use 'tpope/vim-repeat'
    -- WhichKey
    use {
        "folke/which-key.nvim",
        event = "VimEnter",
        config = function()
            require("plugins.which-key")
        end
    }

    -- themes
    use 'sainnhe/sonokai'
    use 'rmehri01/onenord.nvim'
    use 'shaunsingh/nord.nvim'
    use 'folke/tokyonight.nvim'
    use 'sainnhe/everforest'
    use {
        "ellisonleao/gruvbox.nvim",
        requires = {"rktjmp/lush.nvim"}
    }
end)
