local KM = require 'lua.utils.core.mapper'


-- TODO: refactor KeyMapper so that it can be instantiated w/ the state present in this
--       function
local function options(desc)
  return { desc = 'spectre: ' .. desc, nowait = true, silent = true }
end


local function spectre_cmd(cmd, select_word, prepend)
  local select_word_str = ternary(select_word, '{select_word=true}', '')
  prepend = prepend or ''

  return prepend .. '<cmd>lua require("spectre").' .. cmd .. '(' .. select_word_str .. ')<CR>'
end

-- interactions ----------------------------------------------------------------

-- TODO: consider a more complete remapping of available actions:
--       https://github.com/nvim-pack/nvim-spectre
KM.nmap('<leader>S',  spectre_cmd('open', false),                 options('open'))
KM.nmap('<leader>sx', spectre_cmd('close', false),                options('close'))
KM.nmap('<leader>sw', spectre_cmd('open_visual', true),           options('search current word'))
KM.vmap('<leader>sw', spectre_cmd('open_visual', false, '<esc>'), options('search current word'))
KM.nmap('<leader>sp', spectre_cmd('open_file_search', true),      options('search on current file'))

