-- ***** TODO ***** 
-- [DONE] review all plugins
-- get my:
-- * [DONE] lualine setup
-- * [DONE] telescope: neovim config file browser
-- * [DONE] telescope: project switcher/opener
-- * [BUSY] telescope: check keybindings and combine config with mine
-- * [BUSY] which-key installation
-- Create vim.abolish + tweak subversive + nvim-treesitter-textsubjects setup
-- [DONE] Why is space (leader) not triggering which-key, but command mode / why not working?
-- [DONE] What's up with the nathom/filetype.nvim plugin throwing an error?
-- [DONE] Show lint icons instead of letters
-- [DONE] remove vim surround and replace with autotags or sth
-- [DONE] Remove markdown linter, should just be done with prettier
-- review + update keybindings, incl which-key
-- [DONE] review what is in my setup that should be kept     
-- [CANCELLED] Lazy loading, and getting rid of helpers in plugin/init.lua - NOT WORTH IT STARTUP ONLY TAKES 265ms
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
    use("ggandor/lightspeed.nvim") -- motion
    use({
        "svermeulen/vim-subversive",
        config = function()
            require("plugins.subversive")
        end
    }) -- adds substitute operator
    use("tpope/vim-abolish") -- case perserving substitutions
    use({
        "hrsh7th/vim-vsnip",
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
    use({
        "RRethy/nvim-treesitter-textsubjects", -- adds smart text objects
        ft = {"lua", "typescript", "typescriptreact"}
    })
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
    use {

        "folke/which-key.nvim",
        config = function()
            require("which-key").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
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
