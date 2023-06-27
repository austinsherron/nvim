require 'lib.lua.bool'

local km = require 'nvim.lua.utils.mapper'


local function options(desc)
  return { desc = 'spectre: ' .. desc, nowait = true, silent = true }
end


local function spectre_cmd(cmd, select_word, prepend)
    local select_word_str = ternary(select_word, '{select_word=true}', '')
    local prepend = prepend or ''

    return prepend .. '<cmd>lua require("spectre").' .. cmd .. '(' .. select_word_str .. ')<CR>'
end

-- interactions ----------------------------------------------------------------

km.nmap('<leader>s',  spectre_cmd('open', false),                 options('Open Spectre'))
km.nmap('<leader>sw', spectre_cmd('open_visual', true),           options('Search current word'))
km.vmap('<leader>sw', spectre_cmd('open_visual', false, '<esc>'), options('Search current word'))
km.nmap('<leader>sp', spectre_cmd('open_file_search', true),      options('Search on current file'))

