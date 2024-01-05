
--- Contains functions for configuring the lspsaga plugin.
---
---@class LspSaga
local LspSaga = {}

---@return table: a table that contains configuration values for the lspsaga plugin
function LspSaga.opts()
  return {
    definition = {
      keys = {
        close  = '<M-q>',
        edit   = '<M-o>',
        split  = '<M-h>',
        vsplit = '<M-v>',
        tab    = '<M-t>',
      },
    },
    finder = {
      keys = {
        shuttle        = { 'L', 'H' },
        split          = 'h',
        toggle_or_open = { 'o', '<Enter>' },
        vsplit         = 'v'
      }
    },
    lightbulb = {
      virtual_text = false,
    },
    rename = {
      keys = {
        quit = 'q',
      },
    },
    symbol_in_winbar = {
      delay = 1000,
    },
  }
end

return LspSaga

