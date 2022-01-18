local u = require("utils")

require("Comment").setup({
    sticky = false,
    -- integrate with nvim-ts-context-commentstring
    pre_hook = function(ctx)
        if not vim.tbl_contains({"typescript", "typescriptreact"}, vim.bo.ft) then
            return
        end

        local comment_utils = require("Comment.utils")
        local type = ctx.ctype == comment_utils.ctype.line and "__default" or "__multiline"

        local location
        if ctx.ctype == comment_utils.ctype.block then
            location = require("ts_context_commentstring.utils").get_cursor_location()
        elseif ctx.cmotion == comment_utils.cmotion.v or ctx.cmotion == comment_utils.cmotion.V then
            location = require("ts_context_commentstring.utils").get_visual_start_location()
        end

        return require("ts_context_commentstring.internal").calculate_commentstring({
            key = type,
            location = location
        })
    end
})

-- Use [Ctrl-/] to toggle comments in most modes
u.nmap('<C-_>', '<CMD>lua require("Comment.api").toggle_current_linewise()<CR>')
u.imap('<C-_>', '<CMD>lua require("Comment.api").toggle_current_linewise()<CR>')
u.xmap('<C-_>', '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>')
