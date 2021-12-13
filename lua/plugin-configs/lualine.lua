local utils = require('utils')

require('lualine').setup {
    sections = {
        lualine_b = {{
            'branch',
            fmt = function(str)
                return str:sub(1, 16) .. '...'
            end
        }, 'diff', {
            'diagnostics',
            diagnostics_color = {
                -- For "ever forest" theme, comment out when switching to other theme
                error = {
                    -- red
                    fg = '#e68183'
                },
                warn = {
                    -- yellow
                    fg = '#d9bb80'
                },
                info = {
                    -- blue
                    fg = '#83b6af'
                },
                hint = {
                    -- greenish (matches gitsigns)
                    fg = '#82c092'
                }
            },
            sources = {'nvim_diagnostic', 'coc'}
        }},
        lualine_c = {{
            'filename',
            fmt = function(fallback_str)
                return utils.get_substring_from_end_slash(vim.api.nvim_buf_get_name(0), 1, fallback_str)
            end
        }},
        lualine_x = {'encoding', 'filetype'}
    }
}
