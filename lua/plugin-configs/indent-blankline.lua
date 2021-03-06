require("indent_blankline").setup {
    buftype_exclude = {"terminal"},
    filetype_exclude = {"dashboard", "NvimTree", "packer"},
    use_treesitter = true,
    show_current_context = false
    -- Since I have disabled the above, these patterns have no use either
    -- context_patterns = {"class", "return", "function", "method", "^if", "^while", "jsx_element", "^for", "^object",
    --                     "^table", "block", "arguments", "if_statement", "else_clause", "jsx_element",
    --                     "jsx_self_closing_element", "try_statement", "catch_clause", "import_statement",
    --                     "operation_type"}
}
