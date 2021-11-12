require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'folke/which-key.nvim'
    use 'shaunsingh/nord.nvim'
    use {'nvim-treesitter/nvim-treesitter', run = ":TSUpdate"}
end)