local M = {
    setup = function(on_attach, capabilities)
        local custom_capabilities = vim.lsp.protocol.make_client_capabilities()
        custom_capabilities.textDocument.completion.completionItem.snippetSupport = true

        require'lspconfig'.cssls.setup {
            capabilities = custom_capabilities
        }
    end
}

return M
