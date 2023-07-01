
local Nvt = {}

function Nvt.silent_open(node)
  local api = require("nvim-tree.api")

  api.node.open.edit(node)
  api.tree.focus()
end

return Nvt

