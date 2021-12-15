local autopairs = require("nvim-autopairs")
local u = require("utils")

autopairs.setup({
    check_ts = true,
    map_cr = true,
})

local disabled = false
local enable = function()
    autopairs.enable()
    disabled = false
end
local disable = function()
    autopairs.disable()
    disabled = true
end

global.toggle_autopairs = function()
    if disabled then
        enable()
        return
    end
    disable()
end

global.reset_autopairs = function()
    if disabled then
        enable()
    end
end

-- toggle pair completion on <C-l>
u.imap("<C-l>", "<cmd> lua global.toggle_autopairs()<CR>")
-- automatically reset when leaving insert mode
vim.cmd("autocmd InsertLeave * lua global.reset_autopairs()")
