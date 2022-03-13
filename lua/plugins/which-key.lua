local wk = require("which-key")
local u = require("utils")

-- reset treesitter and lsp diagnostics
u.command("DiagnosticsReset", "w | :e")

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
    layout = {
        width = {
            -- can be handy to increase to work out what command is called
            max = 50
        }
    },
    key_labels = {
        ["<cr>"] = "<enter>",
        ["<c-w>"] = "<ctrl-w>",
        ["<C-_>"] = "<ctrl-/>",
        ["<C-L>"] = "<ctrl-l>",
        ["<M-n>"] = "<option-n>",
        ["<M-p>"] = "<option-p>",
        ["<M-h>"] = "<option-h>"
    }
})

wk.register({
    -- Hide
    ["<C-H>"] = {"which_key_ignore"},
    ["<C-K>"] = {"which_key_ignore"},
    ["<C-S>"] = {"which_key_ignore"},
    ["<NL>"] = {"which_key_ignore"},
    ["<80>"] = {"which_key_ignore"},
    -- Make labels look pretty
    ["Y"] = {"yank until line end"},
    ["<C-_>"] = {"toggle line comment"},
    ["<M-n>"] = {"illuminate next reference"},
    ["<M-p>"] = {"illuminate previous reference"},
    ["<2-LeftMouse>"] = {"matchup double click"},
    ["<C-L>"] = {"clear search highlights"},
    ["gc"] = {
        name = "line comment",
        c = {"toggle line comment"},
        O = {"add comment on the line above"},
        o = {"add comment on the line below"},
        A = {"add comment at the end of line"}
    },
    ["gb"] = {
        name = "block comment",
        c = {"toggle block comment"}
    },
    ["<C-w>_"] = {"Maximize window"},
    -- Some actual mappings
    ["<M-h>"] = {"<cmd>HopChar2<cr>", "hop 2 char mode"},
    ["<C-w>p"] = {"<Plug>(choosewin)", "Pick window"},
    ["<C-w>n"] = {
        name = "new layout",
        b = {
            name = "terminal below",
            ["2"] = {"<cmd>only|bufdo bwipeout|vs n|vs n|wincmd J|res 10|terminal<cr>", "2 columns"},
            ["3"] = {"<cmd>only|bufdo bwipeout|vs n|vs n|vs n|wincmd J|res 10|terminal<cr>", "3 columns"}
        },
        r = {
            name = "terminal bottom right",
            ["2"] = {"<cmd>only|bufdo bwipeout|vs n|10:split|terminal<cr>", "2 columns"},
            ["3"] = {"<cmd>only|bufdo bwipeout|vs n|vs n|10:split|terminal<cr>", "3 columns"}
        }
    }
})

-- Make some Treesitter text-objects labels look prettier (VISUAL mode)
wk.register({
    ["<M-h>"] = {"<cmd>HopChar2<cr>", "hop 2 char mode"},
    ["vif"] = {"select inner function"},
    ["vic"] = {"select inner class"},
    ["vaf"] = {"select outer function"},
    ["vac"] = {"select outer class"}
})

wk.register({
    g = {
        name = "Comments",
        c = {"toggle line comment"},
        b = {"toggle block comments"}
    }
}, {
    mode = "v"
})

-- Leader based menu
wk.register({
    t = {
        name = "telescope",
        ['.'] = {"<cmd>TelescopeDotFiles<cr>", "dot files"},
        b = {"<cmd>Telescope buffers<cr>", "buffers"},
        f = {"<cmd>Telescope find_files<cr>", "find files"},
        l = {"<cmd>Telescope live_grep<cr>", "live grep"},
        t = {"<cmd>Telescope builtin<cr>", "builtin"}
    },
    g = {
        name = "git",
        h = "hunks",
        c = {"<cmd>Git commit<cr>", "commit"},
        b = {u.create_branch, "create branch"},
        p = {"<cmd>Git pull", "pull"},
        s = {"<cmd>Telescope git_branches<cr>", "switch branch"},
        l = {
            name = "lists (telescope)",
            c = {"<cmd>Telescope git_commits<cr>", "commits"},
            l = {"<cmd>Telescope git_bcommits<cr>", "branch commits"},
            b = {"<cmd>Telescope git_branches<cr>", "branches"},
            t = {"<cmd>Telescope git_status<cr>", "status"},
            s = {"<cmd>Telescope git_stash<cr>", "stashes"}
        }

    },
    d = {
        name = "diagnostics",
        t = {"<cmd>TroubleToggle<cr>", "toggle trouble panel"},
        r = {"DiagnosticsReset", "reset diagnostics"}
    }
}, {
    prefix = "<leader>"
})

