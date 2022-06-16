local u = require("utils")
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require("cmp")
local luasnip = require("luasnip")

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
    snippet = {
        expand = function(args)
            require'luasnip'.lsp_expand(args.body)
        end
    },
    formatting = {
        format = require("lspkind").cmp_format()
    },
    completion = {
        completeopt = "menu,menuone,noinsert",
        get_trigger_characters = function(trigger_characters)
            return vim.tbl_filter(function(char)
                return char ~= " " and char ~= "\t" and char ~= "\n"
            end, trigger_characters)
        end
    },
    mapping = {
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), {"i"}),
        ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort()
        }),
        ["<CR>"] = cmp.mapping.confirm({
            select = true
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, {"i", "s"}),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {"i", "s"})
    },
    sources = {{
        name = "nvim_lsp"
    }, {
        name = "buffer"
    }, {
        name = "path"
    }, {
        name = "nvim_lsp_signature_help"
    }, {
        name = "luasnip"
        -- priority = 9999
    }}
})

local cmp_autopairs_on_confirm_done_cb = cmp_autopairs.on_confirm_done({
    map_char = {
        tex = ''
    }
})

cmp.event:on('confirm_done', function(arg)
    local client_name = nil

    if type(arg) == "table" then
        client_name = arg.entry.source.source.client.name
    end

    if (client_name ~= "cssmodules_ls") then
        cmp_autopairs_on_confirm_done_cb(arg)
    end
end)

require("luasnip.loaders.from_vscode").lazy_load()
