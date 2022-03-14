local u = require("utils")

--[[
    TODO:
    - CANCELLED Try different version of which-key that works better
    - DONE Re-review plugins and only keep ones that are 100% useful
    - DONE Replace textsubjects with nvim-treesitter/nvim-treesitter-textobjects
    - DONE Illuminate keybindings
    - DONE Comment keybindings
    - DONE Window management keybindings
    - DONE Use tmux for project sessions and intergrate with custom telescope project switcher
    - DONE Telescope keybindings
    - DONE GitSigns + Git fugitive keybindings
    - Hop keybindings
    - CMP keybindings / Switch to cmp-nvim-lsp-signature-help / Switch to luasnip /see tj video
    - LSP keybindings
    - Subversive + abolish + yoink keybindings
--]]

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
vim.opt.timeoutlen = 100
vim.opt.shortmess:append("cA")
vim.opt.clipboard:append("unnamedplus")
vim.opt.autoindent = false
-- performance
vim.opt.ttyfast = true
vim.opt.lazyredraw = true

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
-- exit terminal insert mode more easily
u.tmap("<Esc>", "<C-\\><C-n>")

-- window switching
u.nmap("<C-h>", "<C-w>h")
u.nmap("<C-j>", "<C-w>j")
u.nmap("<C-k>", "<C-w>k")
u.nmap("<C-l>", "<C-w>l")
-- file saving
u.nmap("<C-s>", "<cmd>w<cr>")
u.imap("<C-s>", "<cmd>w<cr>")

-- source remaining config
require("plugins")
require("lsp")

-- vim.cmd [[colorscheme nord]]
-- vim.cmd [[colorscheme gruvbox]]
-- vim.g.everforest_background = "hard"
-- vim.cmd [[colorscheme everforest]]
vim.g.tokyonight_style = "storm"
vim.cmd [[colorscheme tokyonight]]
