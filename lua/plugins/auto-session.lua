local u = require("utils")

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

function get_auto_session_allowed_dirs()
    --[[ The `auto_session_allowed_dirs` config option doesn't
    seem to be able to handle globs. I tried several flavours,
    but nothing worked. But I do want to only have this 
    auto-session behaviour for my projects and my nvim config.
    So I did this instead. ¯\_(ツ)_/¯. ]]
    local neovim_config_dir = os.getenv("HOME") .. "/.config/nvim"
    local allowed_session_dirs = {neovim_config_dir}
    local app_dir_ls = io.popen('ls -d ~/apps/*')

    for dir in app_dir_ls:lines() do
        table.insert(allowed_session_dirs, dir)
    end

    return allowed_session_dirs
end

function update_kitty_window_title()
    --[[ Folder name matches git repo name, so this is a 
    convenient way to easily see what project session is active]]
    local current_dir_name = u.split_string(vim.fn.getcwd(), "/", 0, true)
    local cmd = "kitty @ set-window-title " .. current_dir_name

    vim.fn.jobstart(cmd)
end

require('auto-session').setup {
    auto_session_root_dir = u.session_dir .. "/",
    auto_session_allowed_dirs = get_auto_session_allowed_dirs(),
    post_restore_cmds = {update_kitty_window_title}
}

