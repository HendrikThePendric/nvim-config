local u = require("utils")

local api = vim.api

-- make global to make ex commands easier
_G.inspect = function(...)
    print(vim.inspect(...))
end

local commands = {}

-- open file manager in floating terminal window and edit selected file(s)
-- requires file manager to output paths to stdout, split w/ newlines
commands.file_manager = function(command, edit_command)
    edit_command = edit_command or "edit"
    local winnr, win_bufnr = u.make_floating_window()

    global.fm_cbs = {}
    local bind_index = 1
    local bind_to_command = function(keys, new_command)
        u.buf_map(win_bufnr, "t", keys, string.format([[<C-\><C-n>:lua global.fm_cbs[%d]()<CR>i<CR>]], bind_index))

        global.fm_cbs[bind_index] = function()
            edit_command = new_command
        end
        bind_index = bind_index + 1
    end

    bind_to_command("<C-v>", "vsplit")
    bind_to_command("<C-s>", "split")
    bind_to_command("<C-t>", "tabedit")

    vim.fn.termopen(command, {
        on_exit = function()
            global.fm_cbs = nil

            local output = api.nvim_buf_get_lines(win_bufnr, 0, -1, false)
            api.nvim_win_close(winnr, true)

            local files = vim.tbl_filter(u.is_file, output)
            vim.tbl_map(function(file)
                vim.cmd(table.concat({ edit_command, file }, " "))
            end, files)
        end,
    })
end

u.lua_command("Nnn", [[global.commands.file_manager({ "nnn", "-p", "-", vim.fn.expand("%:p:h") })]])
u.nmap("-", ":Nnn<CR>")

u.lua_command(
    "Broot",
    [[global.commands.file_manager({ "broot", "--conf", vim.fn.expand("$HOME/.config/broot/to_stdout.hjson") })]]
)
u.nmap("_", ":Broot<CR>")

-- cmd should be in the form of "edit $FILE",
-- where $FILE is replaced with the found file's name
commands.edit_test_file = function(cmd)
    cmd = cmd or "edit"
    if not cmd:find("$FILE") then
        cmd = cmd .. " $FILE"
    end

    local done = function(file)
        vim.cmd(cmd:gsub("$FILE", file))
    end

    local root, ft = vim.pesc(vim.fn.expand("%:t:r")), vim.bo.filetype

    local patterns = {}
    if ft == "lua" then
        table.insert(patterns, "_spec")
    elseif ft == "typescript" or ft == "typescriptreact" then
        table.insert(patterns, "%.test")
        table.insert(patterns, "%.spec")
    end

    local final_patterns = {}
    for _, pattern in ipairs(patterns) do
        -- go from test file to non-test file
        if root:match(pattern) then
            pattern = root:gsub(vim.pesc(pattern), "")
        else
            pattern = root .. pattern
        end
        -- make sure extension matches
        pattern = pattern .. "%." .. vim.fn.expand("%:e") .. "$"
        table.insert(final_patterns, pattern)
    end

    -- check buffers first
    for _, b in ipairs(vim.fn.getbufinfo({ buflisted = 1 })) do
        for _, pattern in ipairs(final_patterns) do
            if b.name:match(pattern) then
                done(b.name)
                return
            end
        end
    end

    local scandir = function(path, depth, next)
        require("plenary.scandir").scan_dir_async(path, {
            depth = depth,
            search_pattern = final_patterns,
            on_exit = vim.schedule_wrap(function(found)
                if found[1] then
                    done(found[1])
                    return
                end

                if not next then
                    u.warn("test_file: corresponding file not found for file " .. vim.fn.expand("%:t"))
                    return
                end

                next()
            end),
        })
    end

    -- check same dir files first, then cwd
    scandir(vim.fn.expand("%:p:h"), 1, function()
        scandir(vim.fn.getcwd(), 5)
    end)
end

vim.cmd("command! -complete=command -nargs=* TestFile lua global.commands.edit_test_file(<f-args>)")
u.nmap("<Leader>tv", ":TestFile vsplit<CR>")

commands.open_on_github = function(count, start_line, end_line)
    local remote = u.get_system_output("git remote -v")[1]
    if remote == "" then
        u.warn("not in a git repo")
        return
    end
    local username, repo = remote:match(":(%S+)/(%S+)%.")
    if not (username and repo) then
        u.warn("failed to get repo info")
        return
    end

    local branch = u.get_system_output("git rev-parse --abbrev-ref --symbolic-full-name HEAD")[1]
    if branch == "HEAD" then
        branch = u.get_system_output("git rev-parse HEAD")[1]
    end
    local repo_root = u.get_system_output("git rev-parse --show-toplevel")[1] .. "/"
    local path = api.nvim_buf_get_name(0):gsub(vim.pesc(repo_root), "")

    local url = table.concat({ "https://github.com", username, repo, "blob", branch, path }, "/")
    if count > 0 then
        local line_template = start_line == end_line and "#L%d" or "#L%d-L%d"
        url = url .. string.format(line_template, start_line, end_line)
    end

    vim.fn.system("open " .. url)
end

vim.cmd("command! -range GBrowse lua global.commands.open_on_github(<count>, <line1>, <line2>)")

global.commands = commands

-- misc
u.command("Bonly", '%bdelete | edit # | normal `"')
u.command("Bdelete", "%bdelete")

u.command("Git", "tabnew term://lazygit")
u.nmap("<Leader>g", ":Git<CR>")

-- delete current file and buffer
u.command("Remove", "call delete(expand('%')) | bdelete")

-- get help for word under cursor
u.command("Help", 'execute ":help" expand("<cword>")')

-- reset treesitter and lsp diagnostics
u.command("R", "w | :e")

return commands
