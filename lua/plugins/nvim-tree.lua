local nvim_tree = require("nvim-tree")
local view = require("nvim-tree.view")
local u = require("utils")

local M = {}

M.toggle_replace = function()
    if view.is_visible() then
        view.close()
    else
        nvim_tree.open_replacing_current_buffer()
    end
end

nvim_tree.setup {
    view = {
        mappings = {
            list = {{
                key = "<CR>",
                action = "edit_in_place"
            }}
        }
    }
}

vim.keymap.set('n', '<leader>o', M.toggle_replace, u.create_buf_keymap_opt_with_desc(bufnr, "open nvim tree"))

return M
