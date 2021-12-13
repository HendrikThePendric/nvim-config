local M = {}

M.get_substring_from_end_slash = function(str, level, fallback_str)
    level = level or 1
    fallback_str = fallback_str or 'No output string provided'
    local curr_level = 0
    local outpuStr = ''
    local reversedStr = string.reverse(str)

    for c in reversedStr:gmatch "." do
        if (c == "/") then
            curr_level = curr_level + 1
        end
        if (curr_level > level) then
            break
        end
        outpuStr = c .. outpuStr
    end

    if (outpuStr == '') then
        return fallback_str
    end

    return outpuStr
end

return M
