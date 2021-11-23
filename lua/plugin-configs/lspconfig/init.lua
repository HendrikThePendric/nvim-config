local lspconfig = require("lspconfig")
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

lspconfig.html.setup {
    capabilities = capabilities
}

lspconfig.cssls.setup {
    capabilities = capabilities
}

require('plugin-configs.lspconfig.lua-setup')
require('plugin-configs.lspconfig.typescript-setup')
