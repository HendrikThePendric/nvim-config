local theme_ok, theme = pcall(require, "theme")

theme = theme_ok and type(theme) == "table" and theme.lualine or "auto" -- fall back to auto if unavailable or unspecified

local gitsigns_diff = function()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
        return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed,
        }
    end
end

-- hide tabline if only 1 tab is open
vim.cmd("autocmd OptionSet showtabline :set showtabline=1")

require("lualine").setup({
    options = {
        section_separators = "", -- disable arrow separators
        component_separators = "",
        theme = theme,
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = {
            -- use gitsigns for diff info
            { "b:gitsigns_head", icon = "" },
            { "diff", source = gitsigns_diff },
        },
        lualine_c = {
            { "filename", file_status = false },
            { "diagnostics", sources = { "nvim_diagnostic" } },
        },
        lualine_x = { "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },
    tabline = {
        lualine_z = {
            {
                "tabs",
                max_length = vim.o.columns, -- expand to viewport size
                mode = 0, -- tab number only
            },
        },
    },
    extensions = { "fugitive" },
})
