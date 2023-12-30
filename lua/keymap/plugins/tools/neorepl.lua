local KeyMapper = require 'utils.core.mapper'


local KM = KeyMapper.new({ desc_prefix = 'neorepl: ', silent = true, nowait = true })

-- interactions ----------------------------------------------------------------

KM:bind({
    { '<leader>rf', ':Repl e<CR>',      { desc = 'open'           }},
    { '<leader>rh', ':Repl split<CR>',  { desc = 'open in split'  }},
    { '<leader>rv', ':Repl vsplit<CR>', { desc = 'open in vsplit' }},
}):done()

-- on_init ---------------------------------------------------------------------

--- Contains functions for configuring key bindings for the neorepl plugin.
---
---@class NeoRepl
local NeoRepl = {}

--- Function that's called when neorepl "attaches" to a buffer. Calls keymapping
--- functions.
---
---@param bufnr integer: the id of the repl buffer (to which key bindings are local)
function NeoRepl.bind_on_init(bufnr)
  KM:with({ buffer = bufnr })
    :bind({
      { '<CR>',   '<Plug>(neorepl-eval-line)',  { desc = 'evaluate line'            }, { 'n', 'i' }},
      { '<M-;>',  '<Plug>(neorepl-break-line)', { desc = 'break line'               }, { 'i'      }},
      { '<BS>',   '<Plug>(neorepl-backspace)',  { desc = 'backspace (+line breaks)' }, { 'i'      }},
      { '<Up>',   '<Plug>(neorepl-hist-prev)',  { desc = 'get previous cmd(s)'      }, { 'n', 'i' }},
      { '<Down>', '<Plug>(neorepl-hist-next)',  { desc = 'get next cmd(s)'          }, { 'n', 'i' }},
      -- TODO
      -- { '<leader>re', '<Plug>(neorepl-complete)',  { desc = 'function docstring' }},
  }):done()
end

return NeoRepl

