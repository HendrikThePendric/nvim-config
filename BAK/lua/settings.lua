vim.cmd [[filetype plugin indent on]]

vim.g.mapleader = ' '

vim.o.autoindent = true
vim.o.clipboard = 'unnamedplus'
vim.o.cmdheight = 2
vim.o.conceallevel = 0
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.fileencoding = 'utf-8'
vim.o.hidden = true
vim.o.mouse = 'a'
vim.o.pumheight = 10
vim.o.scrolloff = 3
vim.o.shiftwidth = 4
-- Avoid showing message extra message when using completion
vim.o.shortmess = vim.o.shortmess .. 'c'
vim.o.showmode = false
vim.o.showtabline = 0
vim.o.sidescrolloff = 5
vim.o.softtabstop = 4
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.tabstop = 4
vim.o.whichwrap = 'b,s,<,>,[,],h,l'

vim.bo.autoindent = true
vim.bo.expandtab = true
vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4
vim.bo.tabstop = 4

vim.opt.termguicolors = true

vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = 'yes'
vim.wo.wrap = false

-- vim.cmd [[colorscheme nord]]
-- vim.cmd [[colorscheme gruvbox]]
vim.g.everforest_background = "hard"
vim.cmd [[colorscheme everforest]]
-- vim.g.tokyonight_style = "storm"
-- vim.cmd [[colorscheme tokyonight]]

-- Plugin specific settings are in the plugin-configs
