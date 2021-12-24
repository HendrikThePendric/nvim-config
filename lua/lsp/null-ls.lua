local null_ls = require("null-ls")
local b = null_ls.builtins

local sources = {b.formatting.prettier.with({
    disabled_filetypes = {"typescript", "typescriptreact"}
}), b.code_actions.gitsigns, b.code_actions.gitrebase, b.hover.dictionary, b.diagnostics.tsc}

local M = {}
M.setup = function(on_attach)
    null_ls.setup({
        -- debug = true,
        sources = sources,
        on_attach = on_attach
    })
end

return M
