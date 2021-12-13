local utils = require('utils')
local actions = require('telescope.actions')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local action_state = require('telescope.actions.state')

require('telescope').setup {
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
        find_command = {'rg', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case'},
        prompt_prefix = " ",
        selection_caret = " ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        file_sorter = require'telescope.sorters'.get_fzy_sorter,
        file_ignore_patterns = {},
        generic_sorter = require'telescope.sorters'.get_generic_fuzzy_sorter,
        path_display = {},
        winblend = 0,
        border = {},
        borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'},
        color_devicons = true,
        use_less = true,
        set_env = {
            ['COLORTERM'] = 'truecolor'
        }, -- default = nil,
        file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
        grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
        qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
        buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker,
        mappings = {
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                ["<esc>"] = actions.close,
                ["<CR>"] = actions.select_default + actions.center
            },
            n = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist
            }
        },
        extensions = {
            fzy_native = {
                override_generic_sorter = false,
                override_file_sorter = true
            }
        }
    }
}

require('telescope').load_extension('fzy_native')
require("telescope").load_extension('file_browser')

local M = {}

M.search_dotfiles = function()
    require("telescope.builtin").find_files({
        prompt_title = 'NeoVim Config files',
        cwd = '~/.config/nvim',
        hidden = false
    })
end

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

M.project_browser = function(opts)
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
                local cmd = 'kitty @ new-window --window-type os --cwd ' .. full_path .. ' --title ' .. name .. ' nvim'

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
end

return M
