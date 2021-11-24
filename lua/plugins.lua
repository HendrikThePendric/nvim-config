require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'folke/which-key.nvim'
    use 'shaunsingh/nord.nvim'
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ":TSUpdate"
    }
    use 'nvim-lua/plenary.nvim'
    use 'famiu/nvim-reload'
    use {
        'nvim-lualine/lualine.nvim',
        requires = {
            'kyazdani42/nvim-web-devicons',
            opt = true
        }
    }
    use {
        'akinsho/bufferline.nvim',
        requires = 'kyazdani42/nvim-web-devicons'
    }
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons'
    }
    use 'akinsho/toggleterm.nvim'
    use 'lukas-reineke/indent-blankline.nvim'
    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = 'nvim-lua/plenary.nvim'
    }
    use 'nvim-telescope/telescope-fzy-native.nvim'
    use {
        "ahmedkhalf/project.nvim",
        config = function()
            require("project_nvim").setup {}
        end
    }
    use {
        "AckslD/nvim-neoclip.lua",
        config = function()
            require('neoclip').setup()
        end
    }
    use 'norcalli/nvim-colorizer.lua'
    use {
        'lewis6991/gitsigns.nvim',
        requires = {'nvim-lua/plenary.nvim'},
        config = function()
            require('gitsigns').setup()
        end
    }

    -- cmp-nvim
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-vsnip'
    -- vim snip
    use 'hrsh7th/vim-vsnip'
    -- LSP config
    use 'neovim/nvim-lspconfig'
    use 'onsails/lspkind-nvim'
    use "jose-elias-alvarez/null-ls.nvim"
    use "jose-elias-alvarez/nvim-lsp-ts-utils"
    use 'windwp/nvim-ts-autotag'
    use 'windwp/nvim-autopairs'
    use 'ray-x/lsp_signature.nvim'
    use 'folke/lsp-colors.nvim'
    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup {}
        end
    }

end)
