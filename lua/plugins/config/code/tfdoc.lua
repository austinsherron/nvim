--- Contains functions for configuring the terraform-doc plugin.
---
---@class TFDoc
local TFDoc = {}

local TF_DOC_CMD_NAME = 'TFDoc'

---@return string: name of the user command that activates the plugin
function TFDoc.cmd_name()
  return TF_DOC_CMD_NAME
end

---@return table: a table that contains configuration values for the terraform-doc plugin
function TFDoc.opts()
  return {
    command_name = TF_DOC_CMD_NAME,
  }
end

return TFDoc
