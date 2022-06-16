local M = {
    setup = function(on_attach, capabilities)
        require'lspconfig'.cssmodules_ls.setup {
            on_attach = function(client)
                -- avoid accepting `go-to-definition` responses from this LSP
                client.resolved_capabilities.goto_definition = false
                on_attach(client)
            end
        }
    end

}

return M
