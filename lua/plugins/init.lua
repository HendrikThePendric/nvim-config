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

    -- additional functionality
    use {
        'phaazon/hop.nvim',
        branch = 'v1', -- optional but strongly recommended
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
    use({
        "hrsh7th/vim-vsnip",
        requires = {"hrsh7th/vim-vsnip-integ"},
        config = function()
            require("plugins.vsnip")
        end
    }) -- snippets
    use({
        "windwp/nvim-autopairs",
        config = function()
            require("plugins.autopairs")
        end
    }) -- autocomplete pairs
    use({
        "hrsh7th/nvim-cmp", -- completion
        requires = {"hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "hrsh7th/cmp-vsnip",
                    "onsails/lspkind-nvim", "folke/lua-dev.nvim"},
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

    -- treesitter
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = function()
            require("plugins.treesitter")
        end
    })
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
    -- use {
    --     "AckslD/nvim-neoclip.lua",
    --     config = function()
    --         require('neoclip').setup()
    --     end
    -- } TRYING VIM_YOINK INSTEAD CAUSE THAT INTERGRATES WITH VIM-SUBVERSIVE
    use 'famiu/nvim-reload'
    use 'tonchis/vim-to-github'

    -- WhichKey
    use {
        -- "folke/which-key.nvim",
        "zeertzjq/which-key.nvim",
        event = "VimEnter",
        config = function()
            require("plugins.which-key")
        end,
        branch = "patch-1"
        -- using fork until this is merged https://github.com/folke/which-key.nvim/pull/227
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
