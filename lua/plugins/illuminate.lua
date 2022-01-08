local u = require("utils")

-- These keybindings only work if the terminal emulator / OS can use the alt key in a terminal emulator
-- For Kitty this means setting `macos_option_as_alt yes`
u.nmap("<M-n>", '<cmd> lua require"illuminate".next_reference{wrap=true}<CR>')
u.nmap("<M-p>", '<cmd> lua require"illuminate".next_reference{reverse=true,wrap=true}<CR>')
