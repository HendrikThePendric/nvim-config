local u = require("utils")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.completeopt = {"menuone", "noinsert"}
vim.opt.showcmd = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.mouse = "a"
vim.opt.pumheight = 10
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.updatetime = 300
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 2
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.timeoutlen = 800
vim.opt.shortmess:append("cA")
vim.opt.clipboard:append("unnamedplus")
vim.opt.autoindent = false

vim.cmd("autocmd BufEnter * setlocal formatoptions-=cro")

-- initialize global object for config
global = {}

-- highlight on yank
vim.cmd('autocmd TextYankPost * silent! lua vim.highlight.on_yank({ higroup = "IncSearch", timeout = 500 })')

-- terminals
-- always start in insert mode
vim.cmd("autocmd TermOpen * startinsert")
-- disable line numbers
vim.cmd("autocmd TermOpen * setlocal nonumber norelativenumber")

-- source remaining config
require("plugins")
require("lsp")

-- vim.cmd [[colorscheme nord]]
-- vim.cmd [[colorscheme gruvbox]]
-- vim.g.everforest_background = "hard"
-- vim.cmd [[colorscheme everforest]]
vim.g.tokyonight_style = "storm"
vim.cmd [[colorscheme tokyonight]]
