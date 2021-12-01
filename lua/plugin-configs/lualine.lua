function file_name_with_parent_dir(fallbackStr)
    local str = vim.api.nvim_buf_get_name(0)
    local level = 0
    local outpuStr = ''
    local reversedStr = string.reverse(str)

    for c in reversedStr:gmatch "." do
        if (c == "/") then
            level = level + 1
        end
        if (level > 1) then
            break
        end
        outpuStr = outpuStr .. c
    end

    if (outpuStr == '') then
        return fallbackStr
    end

    return string.reverse(outpuStr)
end

require('lualine').setup {
    sections = {
        lualine_b = {{
            'branch',
            fmt = function(str)
                return str:sub(1, 16) .. '...'
            end
        }},
        lualine_c = {{
            'filename',
            fmt = file_name_with_parent_dir
        }},
        lualine_x = {'encoding', 'filetype'}
    }
}
