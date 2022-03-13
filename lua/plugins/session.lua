local u = require("utils")

-- Do not use ~ as home directory here, because the full path is needed by my DYI project switcher
vim.api.nvim_set_var("session_directory", u.session_dir)
vim.api.nvim_set_var("session_autosave", "yes")
vim.api.nvim_set_var("session_autosave_periodic", 5)
vim.api.nvim_set_var("session_autosave_silent", 1)
vim.api.nvim_exec([[
set sessionoptions-=buffers
]], false)
