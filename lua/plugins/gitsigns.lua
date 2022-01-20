local u = require("utils")

require("gitsigns").setup({
    keymaps = {
        -- Default keymap options
        noremap = true,

        -- Disabled all default keybindings and set them up with which-key
        -- Also, they are grouped together with git fugitive and telescope git actions
        ['n ]c'] = {
            expr = true,
            "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'"
        },
        ['n [c'] = {
            expr = true,
            "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'"
        },

        ['n <leader>gR'] = '<cmd>Gitsigns reset_buffer<CR>',
        ['n <leader>gL'] = '<cmd>Gitsigns toggle_current_line_blame<CR>',
        ['n <leader>gB'] = '<cmd>lua require"gitsigns".blame_line{full=true}<CR>',

        -- Hunks
        ['n <leader>ghs'] = '<cmd>Gitsigns stage_hunk<CR>',
        ['v <leader>ghs'] = ':Gitsigns stage_hunk<CR>',
        ['n <leader>ghu'] = '<cmd>Gitsigns undo_stage_hunk<CR>',
        ['n <leader>ghr'] = '<cmd>Gitsigns reset_hunk<CR>',
        ['v <leader>ghr'] = ':Gitsigns reset_hunk<CR>',
        ['n <leader>ghp'] = '<cmd>Gitsigns preview_hunk<CR>',
        ['n <leader>ghS'] = '<cmd>Gitsigns stage_buffer<CR>',
        ['n <leader>ghU'] = '<cmd>Gitsigns reset_buffer_index<CR>',

        -- Text objects
        ['o ih'] = ':<C-U>Gitsigns select_hunk<CR>',
        ['x ih'] = ':<C-U>Gitsigns select_hunk<CR>'
    }
})

-- u.nmap("<Leader>g", ":tab Git<CR>")
-- u.nmap("<Leader>G", ":Git ", { silent = false })

vim.cmd("autocmd FileType fugitive nmap <buffer> <Tab> =")
