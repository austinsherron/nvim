--- Contain utilities for configuring the chezmoi plugin.
---
---@class Chezmoi
local Chezmoi = {}

--- Configures the chezmoi plugin.
function Chezmoi.config()
  vim.g['chezmoi#use_tmp_buffer'] = true
end

return Chezmoi
