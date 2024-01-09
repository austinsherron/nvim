--- Contains functions for configuring the noice plugin.
---
---@class Noice
local Noice = {}

---@return table: a table that contains configuration values for the noice plugin
function Noice.opts()
  return {
    lsp = {
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true,
      },
    },
  }
end

return Noice
