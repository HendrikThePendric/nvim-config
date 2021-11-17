local keymap = vim.api.nvim_set_keymap
-- Ctrl-s to save
keymap('n', '<c-s>', ':w<CR>', { noremap = true })
keymap('i', '<c-s>', '<Esc>:w<CR>a', { noremap = true })
-- Ctrl jhkl to navigate splits
keymap('n', '<c-j>', '<c-w>j', { noremap = true })
keymap('n', '<c-h>', '<c-w>h', { noremap = true })
keymap('n', '<c-k>', '<c-w>k', { noremap = true })
keymap('n', '<c-l>', '<c-w>l', { noremap = true })

-- Plugin specific keybindings are in the plugin-configs