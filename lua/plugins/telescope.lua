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
        file_ignore_patterns = {"node_modules"},
        layout_config = {
            horizontal = {
                width = 0.95,
                prompt_position = "top",
                preview_width = 0.55,
                horizontal = {
                    mirror = false
                },
                vertical = {
                    mirror = false
                }
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
        },
        find_files = {
            hidden = true
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

telescope.load_extension("fzf")
telescope.load_extension("file_browser")
telescope.load_extension("session-lens")

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
    search_dotfiles = search_dotfiles
}

-- Commands for custom functions
u.lua_command("TelescopeDotFiles", "global.telescope_custom.search_dotfiles()")

-- lsp
u.command("LspRef", "Telescope lsp_references")
u.command("LspDef", "Telescope lsp_definitions")
u.command("LspSym", "Telescope lsp_workspace_symbols")
u.command("LspAct", "Telescope lsp_code_actions")
u.command("LspRangeAct", "Telescope lsp_range_code_actions")
