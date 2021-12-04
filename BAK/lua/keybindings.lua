local keymap = vim.api.nvim_set_keymap
local noRemap = { noremap = true }
-- Ctrl-s to save
keymap('n', '<c-s>', ':w<CR>', noRemap)
keymap('i', '<c-s>', '<Esc>:w<CR>a', noRemap)
-- Ctrl jhkl to navigate splits
keymap('n', '<c-j>', '<c-w>j', noRemap)
keymap('n', '<c-h>', '<c-w>h', noRemap)
keymap('n', '<c-k>', '<c-w>k', noRemap)
keymap('n', '<c-l>', '<c-w>l', noRemap)

-- Plugin specific keybindings are in the plugin-configs