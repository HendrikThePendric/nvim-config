local api = vim.api

local get_map_options = function(custom_options)
    local options = {
        noremap = true,
        silent = true
    }
    if custom_options then
        options = vim.tbl_extend("force", options, custom_options)
    end
    return options
end

local M = {}

M.session_dir = os.getenv("HOME") .. "/.config/nvim/sessions"

M.map = function(mode, target, source, opts)
    api.nvim_set_keymap(mode, target, source, get_map_options(opts))
end

for _, mode in ipairs({"n", "o", "i", "x", "t"}) do
    M[mode .. "map"] = function(...)
        M.map(mode, ...)
    end
end

M.buf_map = function(bufnr, mode, target, source, opts)
    api.nvim_buf_set_keymap(bufnr or 0, mode, target, source, get_map_options(opts))
end

M.command = function(name, fn)
    vim.cmd(string.format("command! %s %s", name, fn))
end

M.lua_command = function(name, fn)
    M.command(name, "lua " .. fn)
end

M.t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

M.input = function(keys, mode)
    api.nvim_feedkeys(M.t(keys), mode or "m", true)
end

M.warn = function(msg)
    api.nvim_echo({{msg, "WarningMsg"}}, true, {})
end

M.is_file = function(path)
    if path == "" then
        return false
    end

    local stat = vim.loop.fs_stat(path)
    return stat and stat.type == "file"
end

M.make_floating_window = function(custom_window_config, height_ratio, width_ratio)
    height_ratio = height_ratio or 0.8
    width_ratio = width_ratio or 0.8

    local height = math.ceil(vim.opt.lines:get() * height_ratio)
    local width = math.ceil(vim.opt.columns:get() * width_ratio)
    local window_config = {
        relative = "editor",
        style = "minimal",
        border = "double",
        width = width,
        height = height,
        row = width / 2,
        col = height / 2
    }
    window_config = vim.tbl_extend("force", window_config, custom_window_config or {})

    local bufnr = api.nvim_create_buf(false, true)
    local winnr = api.nvim_open_win(bufnr, true, window_config)
    return winnr, bufnr
end

M.get_system_output = function(cmd)
    return vim.split(vim.fn.system(cmd), "\n")
end

M.split_string = function(str, delimiter, occurance, reverse)
    occurance = occurance or 1
    reverse = reverse or false

    local splitted_str = ''
    local curr_occurance = 0

    if (reverse) then
        str = string.reverse(str)
    end

    for c in str:gmatch "." do
        if (c == delimiter) then
            curr_occurance = curr_occurance + 1
        end

        if (curr_occurance > occurance) then
            break
        end

        if (reverse) then
            splitted_str = c .. splitted_str
        else
            splitted_str = splitted_str .. c
        end
    end

    return splitted_str
end

M.create_branch = function()
    local on_confirm = function(input)
        -- Clear prompt
        vim.cmd("redraw")
        if input == nil then
            print('Branch creation aborted')
        else
            vim.cmd("Git checkout -b " .. input)
        end
    end
    vim.ui.input({
        prompt = "Name for new branch: "
    }, on_confirm)
end

M.get_project_dirs = function()
    local results = {}
    local p = io.popen('ls -d ~/apps/*')

    for dir in p:lines() do
        local name = M.split_string(dir, '/', 0, true)
        table.insert(results, {name, dir})
    end
    return results
end

M.get_current_dir_name = function()
    local current_dir = os.getenv("PWD") or io.popen("cd"):read()
    return M.split_string(current_dir, "/", 0, true)
end

M.is_project_dir = function(dir)
    local project_names = M.get_project_dirs()

    for _, value in pairs(project_names) do
        local name = unpack(value)
        if name == dir then
            return true
        end
    end

    return false
end

M.get_project_session_path = function(project_name)
    return M.session_dir .. "/" .. project_name .. ".vim"
end

M.has_session = function(project_name)
    local path = M.get_project_session_path(project_name)
    local session_file = io.open(path, "r")

    if session_file == nil then
        return false
    else
        io.close(session_file)
        return true
    end
end

M.save_session = function(name)
    vim.cmd("SaveSession " .. name)
end

M.open_session = function(name)
    vim.cmd("OpenSession " .. name)
end

M.init_session_and_finder = function()
    print("HENKIE")
    print(vim.fn.stdpath('data'))
    local no_args = vim.tbl_count(vim.v.argv) == 1
    local current_dir_name = M.get_current_dir_name()
    local is_project_dir = M.is_project_dir(current_dir_name)
    local has_session = M.has_session(current_dir_name)

    if no_args and is_project_dir then
        if has_session then
            -- M.open_session(current_dir_name)
        else
            M.save_session(current_dir_name)
            -- Open telescope file browser
        end
    else
        -- show project browse_projects
    end
end

return M
