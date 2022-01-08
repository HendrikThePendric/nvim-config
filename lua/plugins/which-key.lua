local wk = require("which-key")

wk.setup({
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
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

-- Make some labels look prettier (NORMAL mode)
wk.register({
    ["<M-n>"] = {"illuminate next reference"},
    ["<M-p>"] = {"illuminate previous reference"},
    ["<2-LeftMouse>"] = {"matchup double click"},
    ["<C-L>"] = {"clear search highlights"}
})

-- Make some labels look prettier (VISUAL mode)
wk.register({
    -- Treesitter text-objects
    ["vif"] = {"select inner function"},
    ["vic"] = {"select inner class"},
    ["vaf"] = {"select outer function"},
    ["vac"] = {"select outer class"}
})

-- Leader based menu
-- wk.register({}, {
--     prefix = "<leader>"
-- })

-- delete current file and buffer
-- u.command("Remove", "call delete(expand('%')) | bdelete")

-- get help for word under cursor
-- u.command("Help", 'execute ":help" expand("<cword>")')

-- reset treesitter and lsp diagnostics
-- u.command("R", "w | :e")
