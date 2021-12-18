local telescope = require("telescope")
local utils = require('utils')
local actions = require('telescope.actions')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local action_state = require('telescope.actions.state')

local api = vim.api

local u = require("utils")
local commands = require("commands")

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

function get_project_folders()
    local results = {}
    local p = io.popen('ls -d ~/apps/*') -- Open directory look for files, save data in p. By giving '-type f' as parameter, it returns all direcotires.     
    for folder in p:lines() do -- Loop through all files
        local name = utils.get_substring_from_end_slash(folder, 0)
        table.insert(results, {name, folder})
    end
    return results
end

function get_name_and_full_path(action_state)
    local selection = action_state.get_selected_entry()
    return unpack(selection.value)
end

global.telescope = {
    project_browser = function(opts)
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
                actions.select_default:replace(function()
                    actions.close(prompt_bufnr)

                    local name, full_path = get_name_and_full_path(action_state)
                    local cmd = 'kitty @ new-window --window-type os --cwd ' .. full_path .. ' --title ' .. name ..
                                    ' nvim'

                    vim.fn.jobstart(cmd)
                end)

                -- Switch to new project in current kitty OS window
                map("i", "<C-o>", function()
                    actions.close(prompt_bufnr)

                    local name, full_path = get_name_and_full_path(action_state)

                    -- Clear all buffers
                    for index, buff_nr in ipairs(vim.api.nvim_list_bufs()) do
                        -- Will fail if any dirty buffers are present and that's good
                        vim.api.nvim_buf_delete(buff_nr, {})
                    end

                    -- Set cwd to project path
                    vim.api.nvim_set_current_dir(full_path)

                    -- Update window title
                    vim.fn.jobstart('kitty @ set-window-title ' .. name)
                end)
                return true
            end
        }):find()
    end,
    search_dotfiles = function()
        require("telescope.builtin").find_files({
            prompt_title = 'NeoVim Config files',
            cwd = '~/.config/nvim',
            hidden = false
        })
    end
}

u.lua_command("Projects", "global.telescope.project_browser()")
u.lua_command("DotFiles", "global.telescope.search_dotfiles()")
u.command("Files", "Telescope find_files")
u.command("Rg", "Telescope live_grep")
u.command("BLines", "Telescope current_buffer_fuzzy_find")
u.command("History", "Telescope oldfiles")
u.command("Buffers", "Telescope buffers")
u.command("BCommits", "Telescope git_bcommits")
u.command("Commits", "Telescope git_commits")
u.command("HelpTags", "Telescope help_tags")
u.command("ManPages", "Telescope man_pages")

u.nmap("<Leader>ff", "<cmd>Files<CR>")
u.nmap("<Leader>fs", "<cmd>Rg<CR>")
u.nmap("<Leader>fo", "<cmd>History<CR>")
u.nmap("<Leader>fh", "<cmd>HelpTags<CR>")
u.nmap("<Leader>fl", "<cmd>BLines<CR>")
u.nmap("<Leader>fc", "<cmd>BCommits<CR>")
u.nmap("<leader>fp", "<cmd>Projects<CR>")
u.nmap("<leader>fv", "<cmd>DotFiles<CR>")
u.nmap("<LocalLeader><LocalLeader>", "<cmd>Buffers<CR>")

-- lsp
u.command("LspRef", "Telescope lsp_references")
u.command("LspDef", "Telescope lsp_definitions")
u.command("LspSym", "Telescope lsp_workspace_symbols")
u.command("LspAct", "Telescope lsp_code_actions")
u.command("LspRangeAct", "Telescope lsp_range_code_actions")
