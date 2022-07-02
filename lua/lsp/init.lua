local u = require("utils")
local lsp_utils = require("lsp.utils")

local lsp = vim.lsp
local api = vim.api

local border_opts = {
    border = "single",
    focusable = false,
    scope = "line"
}

vim.diagnostic.config({
    virtual_text = false,
    float = border_opts
})

local on_attach = function(client, bufnr)
    vim.keymap.set('n', '<leader>Lr', lsp_utils.nui_lsp_rename,
        u.create_buf_keymap_opt_with_desc(bufnr, "rename symbol"))

    -- commands
    -- u.lua_command("LspFormatting", "vim.lsp.buf.formatting()")
    -- u.lua_command("LspHover", "vim.lsp.buf.hover()")
    -- u.lua_command("LspRename", "vim.lsp.buf.rename()")
    -- u.lua_command("LspDiagPrev", "vim.diagnostic.goto_prev()")
    -- u.lua_command("LspDiagNext", "vim.diagnostic.goto_next()")
    -- u.lua_command("LspDiagLine", "vim.diagnostic.open_float(nil, global.lsp.border_opts)")
    -- u.lua_command("LspDiagQuickfix", "vim.diagnostic.setqflist()")
    -- u.lua_command("LspSignatureHelp", "vim.lsp.buf.signature_help()")
    -- u.lua_command("LspTypeDef", "vim.lsp.buf.type_definition()")

    -- bindings
    -- u.buf_map(bufnr, "n", "gi", ":LspRename<CR>")
    -- u.buf_map(bufnr, "n", "gy", ":LspTypeDef<CR>")
    -- u.buf_map(bufnr, "n", "K", ":LspHover<CR>")
    -- u.buf_map(bufnr, "n", "[a", ":LspDiagPrev<CR>")
    -- u.buf_map(bufnr, "n", "]a", ":LspDiagNext<CR>")
    -- u.buf_map(bufnr, "n", "<Leader>a", ":LspDiagLine<CR>")
    -- u.buf_map(bufnr, "n", "<Leader>q", ":LspDiagQuickfix<CR>")
    -- u.buf_map(bufnr, "i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>")

    -- telescope
    -- u.buf_map(bufnr, "n", "gr", ":LspRef<CR>")
    -- u.buf_map(bufnr, "n", "gd", ":LspDef<CR>")
    -- u.buf_map(bufnr, "n", "ga", ":LspAct<CR>")
    -- u.buf_map(bufnr, "v", "ga", "<Esc><cmd> LspRangeAct<CR>")

    if client.resolved_capabilities.document_formatting and client.name == "null-ls" then
        vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
    end

    if client.resolved_capabilities.signature_help then
        vim.cmd("autocmd CursorHoldI <buffer> lua vim.lsp.buf.signature_help()")
    end

    require("illuminate").on_attach(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

for _, server in ipairs({"bashls", "denols", "eslint", "jsonls", "null-ls", "sumneko_lua", "tsserver", "html", "css",
                         "css_modules"}) do
    require("lsp." .. server).setup(on_attach, capabilities)
end

local signs = {
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " "
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {
        text = icon,
        texthl = hl,
        numhl = ""
    })
end
