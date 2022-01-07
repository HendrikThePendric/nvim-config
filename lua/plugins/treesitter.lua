require("nvim-treesitter.configs").setup({
    ensure_installed = "maintained",
    highlight = {
        enable = true
    },
    -- plugins
    autopairs = {
        enable = true
    },
    matchup = {
        enable = true
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = false
    },
    textobjects = {
        select = {
            enable = true,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner"
            }
        }
    },
    autotag = {
        enable = true
    }
})
