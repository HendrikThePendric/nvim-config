-- Ensure packer is installed
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.cmd [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]]

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'folke/which-key.nvim'
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
    use 'akinsho/toggleterm.nvim'
    use 'lukas-reineke/indent-blankline.nvim'
    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = 'nvim-lua/plenary.nvim'
    }
    use 'nvim-telescope/telescope-file-browser.nvim'
    use 'nvim-telescope/telescope-fzy-native.nvim'
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
    use 'tpope/vim-fugitive'
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
    -- Themes
    use 'shaunsingh/nord.nvim'
    use 'folke/tokyonight.nvim'
    use 'sainnhe/everforest'
    use {
        "ellisonleao/gruvbox.nvim",
        requires = {"rktjmp/lush.nvim"}
    }
end)
