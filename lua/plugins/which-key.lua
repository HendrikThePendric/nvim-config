local wk = require("which-key")

wk.setup({
    plugins = {
        marks = false, -- shows a list of your marks on ' and `
        registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
            enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20 -- how many suggestions should be shown in the list?
        },
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
            operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = true, -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = false, -- bindings for folds, spelling and others prefixed with z
            g = false -- bindings for prefixed with g
        }
    },
    hidden = {"<Plug>", "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "},
    key_labels = {
        ["<cr>"] = "<enter>",
        ["<c-w>"] = "<ctrl-w>",
        ["<C-L>"] = "<ctrl-l>",
        ["<M-n>"] = "<option-n>",
        ["<M-p>"] = "<option-p>"
    }
})

-- NOTE:
-- Keybindings with the modifier key (Alt/option) only work if the
-- terminal emulator / OS can use the alt key in a terminal emulator
-- For Kitty this means setting `macos_option_as_alt yes`

-- Global keys, normal mode (existing commands added here to make labels human readable)
wk.register({
    ["<M-n>"] = {'<cmd> lua require"illuminate".next_reference{wrap=true}<CR>', "Illuminate next reference"},
    ["<M-p>"] = {'<cmd> lua require"illuminate".next_reference{reverse=true,wrap=true}<CR>',
                 "Illuminate previous reference"},
    ["<2-LeftMouse>"] = {"<Plug>(matchup-double-click)", "Matchup double click"},
    ["<C-L>"] = {"<cmd>noh<CR>", "Clear search highlights"}
}, {
    prefix = "",
    mode = "n"
})

-- Global keys, visual mode (existing commands added here to make labels human readable)
wk.register({
    ["."] = {'<cmd> lua require("nvim-treesitter.textsubjects").select("textsubjects-smart", false, vim.fn.getpos("."), vim.fn.getpos("."))<CR>',
             "Textsubjects smart"},
    [";"] = {'<cmd> lua require("nvim-treesitter.textsubjects").select("textsubjects-container-outer", false, vim.fn.getpos("."), vim.fn.getpos("."))<CR>',
             "Textsubjects container outer"}
}, {
    prefix = "",
    mode = "v"
})

-- Global keys, insert mode
-- wk.register({
-- The following keybinding was meant to show which-key keymappings for insert mode
-- but it is displaying some odd entries, so it has been disabled for now
-- ["<M-w>"] = {"<cmd>WhichKey '' i<Cr>", "Show whick-key bindings (insert mode)"}

-- }, {
--     prefix = "",
--     mode = "i"
-- })

-- Leader based menu
wk.register({}, {
    prefix = "<leader>"
})

-- delete current file and buffer
-- u.command("Remove", "call delete(expand('%')) | bdelete")

-- get help for word under cursor
-- u.command("Help", 'execute ":help" expand("<cword>")')

-- reset treesitter and lsp diagnostics
-- u.command("R", "w | :e")
