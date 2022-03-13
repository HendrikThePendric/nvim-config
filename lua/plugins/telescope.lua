local telescope = require("telescope")
local actions = require('telescope.actions')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local action_state = require('telescope.actions.state')
local api = vim.api
local u = require("utils")

-- Setup
telescope.setup({
    defaults = {
        layout_config = {
            width = 0.95,
            prompt_position = "top",
            preview_width = 0.55,
            horizontal = {
                mirror = false
            },
            vertical = {
                mirror = false
            }
        },
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        -- Carefully review this options and the mapping and see what config I was using
        vimgrep_arguments = {"rg", "--color=never", "--no-heading", "--with-filename", "--line-number", "--column",
                             "--smart-case", "--ignore", "--hidden", "-g", "!.git"},
        mappings = {
            i = {
                ["<C-u>"] = false,
                ["<Esc>"] = actions.close,
                ["<M-u>"] = actions.preview_scrolling_up,
                ["<M-d>"] = actions.preview_scrolling_down
            }
        }
    },
    pickers = {
        buffers = {
            show_all_buffers = true,
            sort_lastused = true,
            mappings = {
                i = {
                    ["<c-d>"] = "delete_buffer"
                }
            }
        }
        -- git_branches = {
        --     mappings = {
        --         i = {
        --             ["<c-d>"] = 
        --         }
        --     }
        -- }
    },
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true -- override the file sorter
        }
    }

})

telescope.load_extension('fzf')
telescope.load_extension('file_browser')

function has_tmux_session(project_name)
    local found = false
    local s = io.popen('tmux list-sessions')

    for session in s:lines() do
        local session_name = u.split_string(session, ":", 0)

        if session_name == project_name then
            found = true
            break
        end
    end

    return found
end

function create_or_attach_tmux_session(action_state)
    local selection = action_state.get_selected_entry()
    local name, full_path = unpack(selection.value)
    local open_window_cmd = "kitty @ new-window --window-type os --cwd " .. full_path .. " --title " .. name

    if (has_tmux_session(name)) then
        -- Load session
        local load_session_cmd = open_window_cmd .. " tmux attach-session -t " .. name
        vim.fn.jobstart(load_session_cmd)
    else
        -- New session
        local new_session_cmd = open_window_cmd .. " tmux new-session -s " .. name .. " nvim"
        vim.fn.jobstart(new_session_cmd)
    end
end

-- TMUX STUFF
--[[
attach_mappings = function(prompt_bufnr, map)
    -- Open project in new kitty OS window
    -- AKA "Open new project"
    actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        create_or_attach_tmux_session(action_state)
    end)

    -- Open project in new kitty OS window and close current
    -- AKA "Switch to project"
    map("i", "<M-CR>", function()
        actions.close(prompt_bufnr)

        -- Open new
        create_or_attach_tmux_session(action_state)
        -- Close current
        local current_dir = os.getenv("PWD") or io.popen("cd"):read()
        vim.fn.jobstart("kitty @ close-window --match cwd:" .. current_dir)

        local curr_project_name = u.split_string(current_dir, "/", 0, true)
        if (has_tmux_session(curr_project_name)) then
            vim.fn.jobstart("tmux detach")
        end
    end)
    return true
end
]]

--[[
    ***** Projects with vim sessions *****
    - Avalaible parameters: 
        * project dir
        * session dir
        * current project/dir
        * next project/dir
     - Always - before:
        * Save current session with `SaveSession ${current_project_name}`
    - Scenario: New window      | new session
        * Open new kitty os-window
        * Set kitty os-window CWD to project dir
        * Set kitty os-window title to project name
        * Start nvim with `SaveSession ${next_project_name}` command
    - Scenario: Current window  | open session
        * Close current session
        * Set kitty os-window CWD to project dir
        * Set kitty os-window title to project name
        * Start nvim with `OpenSession ${next_project_name}` command
    - Scenario: New window      | open session
        * Open new kitty os-window
        * Set kitty os-window CWD to project dir
        * Set kitty os-window title to project name
        * Start nvim with `OpenSession ${next_project_name}` command
    - Scenario: Current window  | new session
        * Close current session
        * Set kitty os-window CWD to project dir
        * Set kitty os-window title to project name
        * Start nvim with `SaveSession ${next_project_name}` command

    Functions:
    -> save_current_session
        * Save current session with `SaveSession ${current_project_name}`
    -> create_kitty_window
        * Open new kitty os-window
        * Set kitty os-window CWD to project dir
        * Set kitty os-window title to project name
    -> update_kitty_window
        * Close current session
        * Set kitty os-window CWD to project dir
        * Set kitty os-window title to project name
    -> create_nvim_session
        * Start nvim with `SaveSession ${next_project_name}` command
    -> open_vim_session
        * Start nvim with `OpenSession ${next_project_name}` command
]]

function update_kitty_window(current_project_name, next_project_name, next_project_dir)
    -- * Close current session
    if (u.has_session(current_project_name)) then
        vim.cmd("CloseSession " .. current_project_name)
    end
    -- * Set kitty os-window CWD to project dir
    -- * Set kitty os-window title to project name
end

function create_nvim_session(next_project_name)
    -- * Start nvim with `SaveSession ${next_project_name}` command
    vim.cmd("SaveSession " .. next_project_name)
end

function open_vim_session(next_project_name)
    -- * Start nvim with `OpenSession ${next_project_name}` command
    vim.cmd("OpenSession " .. next_project_name)
end

-- BELOW WORKS

function open_nvim_with_session_cmd(project_name)
    return "nvim -S " .. u.get_project_session_path(project_name)
end

function get_next_project_name_and_path()
    local selection = action_state.get_selected_entry()
    return unpack(selection.value)
end

function save_current_session(current_project_name)
    if u.has_session(current_project_name) then
        vim.cmd("SaveSession " .. current_project_name)
    end
end

function create_kitty_window_cmd(project_name, project_dir)
    return "kitty @ new-window --window-type os --cwd " .. project_dir .. " --title " .. project_name
end

function browse_projects(opts)
    opts = opts or {}
    pickers.new(opts, {
        prompt_title = "Projects",
        finder = finders.new_table {
            results = u.get_project_dirs(),

            entry_maker = function(entry)
                return {
                    value = entry,
                    display = entry[1],
                    ordinal = entry[1]
                }
            end
        },
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, map)
            -- Open project in new kitty OS window
            -- AKA "Open new project"
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local current_project_name = u.get_current_dir_name()
                local next_project_name, next_project_dir = get_next_project_name_and_path()
                local next_session_path = u.get_project_session_path(next_project_name)
                local new_window_cmd = create_kitty_window_cmd(next_project_name, next_project_dir)

                save_current_session(current_project_name)
                vim.fn.jobstart(new_window_cmd .. " nvim -S " .. next_session_path)

                -- if (u.has_session(next_project_name)) then
                --     vim.fn.jobstart(new_window_cmd .. " " .. open_nvim_with_session_cmd(next_project_name))
                -- else
                --     vim.fn.jobstart(new_window_cmd .. " nvim")
                --     -- TODO: no session yet. It will be created when switching, 
                --     -- but it'd be better if it could be saved on open
                -- end

                -- local send_text_cmd = "kitty @ send-text --match title:" .. next_project_name
                -- local open_vim_session_cmd = ' nvim -c ""OpenSession ""' .. next_project_name .. '"'
                -- -- local open_vim_session_cmd = " ls"
                -- print(vim.inspect("test"))
                -- vim.fn.jobstart(send_text_cmd .. open_vim_session_cmd)

                -- if has_session(next_project_name) then
                --     local send_text_cmd = "kitty @ send-text --match title:" .. next_project_name
                --     -- local open_vim_session_cmd = " nvim \"OpenSession " .. next_project_name .. "\""
                --     local open_vim_session_cmd = " ls"
                --     vim.fn.jobstart(send_text_cmd .. open_vim_session_cmd)
                -- else
                -- create_nvim_session(next_project_name)
                -- end

                -- - Scenario: Current window  | open session
                --     * Close current session
                --     * Set kitty os-window CWD to project dir
                --     * Set kitty os-window title to project name
                --     * Start nvim with `OpenSession ${next_project_name}` command
                -- - Scenario: Current window  | new session
                --     * Close current session
                --     * Set kitty os-window CWD to project dir
                --     * Set kitty os-window title to project name
                --     * Start nvim with `SaveSession ${next_project_name}` command
            end)

            -- Open project in new kitty OS window and close current
            -- AKA "Switch to project"
            map("i", "<M-CR>", function()
                actions.close(prompt_bufnr)
                local current_project_name = u.get_current_dir_name()
                local next_project_name, next_project_dir = get_next_project_name_and_path()

                update_kitty_window()

                if u.has_session(next_project_name) then
                    print(vim.inspect('Open session in current window'))
                else
                    print(vim.inspect('Start session in current window'))
                end

                -- create_kitty_window(next_project_name, next_project_dir)

                -- - Scenario: New window      | new session
                -- * Open new kitty os-window
                -- * Set kitty os-window CWD to project dir
                -- * Set kitty os-window title to project name
                -- * Start nvim with `SaveSession ${next_project_name}` command
                -- - Scenario: New window      | open session
                -- * Open new kitty os-window
                -- * Set kitty os-window CWD to project dir
                -- * Set kitty os-window title to project name
                -- * Start nvim with `OpenSession ${next_project_name}` command

            end)
            return true
        end
    }):find()
end

function search_dotfiles()
    local b = require('telescope.builtin')

    b.find_files({
        prompt_title = 'NeoVim Config files',
        cwd = '~/.config/nvim',
        hidden = false
    })
end

-- Expose custom pickers as globals for `lua_command()`
global.telescope_custom = {
    search_dotfiles = search_dotfiles,
    browse_projects = browse_projects,
    has_session = u.has_session
}

-- Commands for custom functions
u.lua_command("TelescopeTest", "global.telescope_custom.has_session('analytics')")
u.lua_command("TelescopeProjects", "global.telescope_custom.browse_projects()")
u.lua_command("TelescopeDotFiles", "global.telescope_custom.search_dotfiles()")

-- lsp
u.command("LspRef", "Telescope lsp_references")
u.command("LspDef", "Telescope lsp_definitions")
u.command("LspSym", "Telescope lsp_workspace_symbols")
u.command("LspAct", "Telescope lsp_code_actions")
u.command("LspRangeAct", "Telescope lsp_range_code_actions")
