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
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
    use {
        'akinsho/bufferline.nvim',
        requires = 'kyazdani42/nvim-web-devicons'
    }
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
    }
    use 'windwp/nvim-ts-autotag'
    use 'windwp/nvim-autopairs'
end)