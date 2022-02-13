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

-- -- Custom pickers and their helpers
function get_project_folders()
    local results = {}
    local p = io.popen('ls -d ~/apps/*')

    for folder in p:lines() do
        local name = u.split_string(folder, '/', 0, true)
        table.insert(results, {name, folder})
    end
    return results
end

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

function browse_projects(opts)
    opts = opts or {}
    pickers.new(opts, {
        prompt_title = "Projects",
        finder = finders.new_table {
            results = get_project_folders(),

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
    browse_projects = browse_projects
}

-- Commands for custom functions
u.lua_command("TelescopeProjects", "global.telescope_custom.browse_projects()")
u.lua_command("TelescopeDotFiles", "global.telescope_custom.search_dotfiles()")
u.lua_command("TelescopeTest", "global.telescope_custom.test()")

-- lsp
u.command("LspRef", "Telescope lsp_references")
u.command("LspDef", "Telescope lsp_definitions")
u.command("LspSym", "Telescope lsp_workspace_symbols")
u.command("LspAct", "Telescope lsp_code_actions")
u.command("LspRangeAct", "Telescope lsp_range_code_actions")
