require'nvim-treesitter.configs'.setup {
    ensure_installed = {"html", "javascript", "lua"},
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
    },
    autotag = {
        enable = true
    },
    autopairs = {
        enable = true
    }
}
