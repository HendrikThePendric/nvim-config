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
-- vim.opt.shell = "/bin/sh"
vim.opt.autoindent = false

-- vim.cmd("autocmd BufEnter * setlocal formatoptions-=cro")

-- initialize global object for config
global = {}

-- -- maps
-- -- make going to normal mode from terminals less painful
-- u.tmap("<C-o>", "<C-\\><C-n>")

-- -- make useless keys useful
-- u.nmap("<BS>", "<C-^>")

-- u.nmap("<Esc>", ":nohl<CR>")

-- u.nmap("<Tab>", "%", {
--     noremap = false
-- })
-- u.xmap("<Tab>", "%", {
--     noremap = false
-- })
-- u.omap("<Tab>", "%", {
--     noremap = false
-- })

-- u.imap("<S-Tab>", "<Esc>A")
-- u.nmap("<S-CR>", ":wqall<CR>")

-- u.nmap("H", "^")
-- u.omap("H", "^")
-- u.xmap("H", "^")
-- u.nmap("L", "$")
-- u.omap("L", "$")
-- u.xmap("L", "$")

-- -- u.nmap("<Space>", ":", {
-- --     silent = false
-- -- })
-- -- u.xmap("<Space>", ":", {
-- --     silent = false
-- -- })

-- -- save on <CR> in normal buffers
-- u.nmap("<CR>", "(&buftype is# '' ? ':w<CR>' : '<CR>')", {
--     expr = true
-- })

-- -- tabs
-- u.nmap("<LocalLeader>t", ":tabnew<CR>")
-- u.nmap("<LocalLeader>T", ":tabedit %<CR>")
-- u.nmap("<LocalLeader>x", ":tabclose<CR>")
-- u.nmap("<LocalLeader>o", ":tabonly<CR>")

-- -- registers
-- -- always send to black hole register
-- u.nmap("c", '"_c')
-- u.xmap("c", '"_c')
-- u.nmap("cc", '"_cc')
-- u.nmap("C", '"_C')
-- u.xmap("C", '"_C')

-- u.nmap("d", '"_d')
-- u.xmap("d", '"_d')
-- u.nmap("dd", '"_dd')
-- u.nmap("D", '"_D')
-- u.xmap("D", '"_D')

-- u.nmap("x", '"_x')
-- u.xmap("x", '"_x')
-- u.nmap("X", '"_X')
-- u.xmap("X", '"_X')

-- -- m for default d behavior
-- u.nmap("m", "d")
-- u.xmap("m", "d")
-- u.nmap("mm", "dd")
-- u.nmap("M", "D")
-- u.xmap("M", "D")

-- -- automatically add jumps > 1 to jump list
-- u.nmap("k", [[(v:count > 1 ? "m'" . v:count : '') . 'k'"]], {
--     expr = true
-- })
-- u.nmap("j", [[(v:count > 1 ? "m'" . v:count : '') . 'j'"]], {
--     expr = true
-- })

-- -- gm for marks
-- u.nmap("gm", "m")

-- -- misc
-- u.xmap(">", ">gv")
-- u.xmap("<", "<gv")

-- u.nmap("n", "nzz")
-- u.nmap("N", "Nzz")

-- -- autocommands
-- -- highlight on yank
-- vim.cmd('autocmd TextYankPost * silent! lua vim.highlight.on_yank({ higroup = "IncSearch", timeout = 500 })')

-- -- terminals
-- -- always start in insert mode
-- vim.cmd("autocmd TermOpen * startinsert")
-- -- disable line numbers
-- vim.cmd("autocmd TermOpen * setlocal nonumber norelativenumber")
-- -- suppress process exited message
-- vim.cmd("autocmd TermClose term://*lazygit execute 'bdelete! ' . expand('<abuf>')")

-- source remaining config
require("commands")
require("plugins")
require("lsp")
-- which-key keybindings
-- require("which-key-bindings")

-- vim.cmd [[colorscheme nord]]
-- vim.cmd [[colorscheme gruvbox]]
vim.g.everforest_background = "hard"
vim.cmd [[colorscheme everforest]]
-- vim.g.tokyonight_style = "storm"
-- vim.cmd [[colorscheme tokyonight]]
