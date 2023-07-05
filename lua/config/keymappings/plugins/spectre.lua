local bool = require 'lib.lua.core.bool'
local km = require 'nvim.lua.utils.mapper'


-- TODO: refactor KeyMapper so that it can be instantiated w/ the state present in this
--       function
local function options(desc)
  return { desc = 'spectre: ' .. desc, nowait = true, silent = true }
end


local function spectre_cmd(cmd, select_word, prepend)
  local select_word_str = bool.ternary(select_word, '{select_word=true}', '')
  prepend = prepend or ''

  return prepend .. '<cmd>lua require("spectre").' .. cmd .. '(' .. select_word_str .. ')<CR>'
end

-- interactions ----------------------------------------------------------------

-- TODO: consider a more complete remapping of available actions:
--       https://github.com/nvim-pack/nvim-spectre
km.nmap('<leader>S',  spectre_cmd('open', false),                 options('open'))
km.nmap('<leader>sx', spectre_cmd('close', false),                options('close'))
km.nmap('<leader>sw', spectre_cmd('open_visual', true),           options('search current word'))
km.vmap('<leader>sw', spectre_cmd('open_visual', false, '<esc>'), options('search current word'))
km.nmap('<leader>sp', spectre_cmd('open_file_search', true),      options('search on current file'))
