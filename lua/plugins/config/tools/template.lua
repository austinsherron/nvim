
--- Contains functions for configuring the template plugin.
---
---@class Template
local Template = {}

---@return table: a table that contains configuration values for the template plugin
function Template.opts()
  return {
    -- TODO: I should probably see if I can source these from the environment, or
    --       something like that
    name     = 'Austin Sherron',
    email    = 'dev@pryv.us',
    temp_dir = vim.fn.stdpath('config') .. '/templates',
  }
end

return Template

