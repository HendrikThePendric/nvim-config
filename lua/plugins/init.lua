vim.cmd("packadd packer.nvim")
return require("packer").startup(function()
    use({
        "wbthomason/packer.nvim",
        opt = true
    })

    local config = function(name)
        return string.format("require('plugins.%s')", name)
    end

    local use_with_config = function(path, name)
        use({
            path,
            config = config(name)
        })
    end

    -- basic
    use("tpope/vim-surround")
    use("tpope/vim-unimpaired")
    use("tpope/vim-sleuth") -- detects indentation
    use_with_config("numToStr/Comment.nvim", "comment")
    use_with_config("lewis6991/gitsigns.nvim", "gitsigns")

    -- text objects
    use("wellle/targets.vim") -- many useful additional text objects
    use({"kana/vim-textobj-user", {"kana/vim-textobj-entire", -- ae/ie for entire buffer
    "Julian/vim-textobj-variable-segment", -- av/iv for variable segment
    "michaeljsmith/vim-indent-object", -- ai/ii for indentation area
    "beloglazov/vim-textobj-punctuation" -- au/iu for punctuation
    }})
    use_with_config("andymass/vim-matchup", "matchup") -- improves %, now with treesitter

    -- additional functionality
    use("ggandor/lightspeed.nvim") -- motion
    use_with_config("svermeulen/vim-subversive", "subversive") -- adds substitute operator
    use_with_config("hrsh7th/vim-vsnip", "vsnip") -- snippets
    use_with_config("windwp/nvim-autopairs", "autopairs") -- autocomplete pairs
    use({
        "hrsh7th/nvim-cmp", -- completion
        requires = {"hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "hrsh7th/cmp-vsnip",
                    "onsails/lspkind-nvim", "folke/lua-dev.nvim"},
        config = config("cmp")
    })
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make'
    }
    use({
        "nvim-telescope/telescope.nvim", -- fuzzy finder
        config = config("telescope")
    })

    -- lsp
    use("neovim/nvim-lspconfig") -- makes lsp configuration easier
    use_with_config("RRethy/vim-illuminate", "illuminate") -- highlights and allows moving between variable references
    use("b0o/schemastore.nvim") -- simple access to json-language-server schemae
    use("jose-elias-alvarez/null-ls.nvim") -- transforms CLI output / Lua code into language server diagnostics, formatting, and more
    use("jose-elias-alvarez/nvim-lsp-ts-utils") -- improves TypeScript development experience

    -- treesitter
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = config("treesitter")
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
    use({"sainnhe/sonokai", -- themes
    "rmehri01/onenord.nvim"})
    use("kyazdani42/nvim-web-devicons") -- icons
    use_with_config("lukas-reineke/headlines.nvim", "headlines") -- markdown highlights
    use_with_config("lukas-reineke/indent-blankline.nvim", "indent-blankline") -- show indent markers
    use_with_config("nvim-lualine/lualine.nvim", "lualine") -- statusline

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
    use("tridactyl/vim-tridactyl") -- tridactylrc syntax
    use_with_config("nathom/filetype.nvim", "filetype") -- greatly reduces startup time

    -- theme
    use("sainnhe/everforest")
end)
