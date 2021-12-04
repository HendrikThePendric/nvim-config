-- Note that global options should be set BEFORE running the setup function (tha docs).
vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_respect_buf_cwd = 1

require("nvim-tree").setup({
    update_cwd = true,
    update_focused_file = {
        enable = true,
        update_cwd = true
    }
})

