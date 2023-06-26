-- TODO: stub

local AutoCmd = {}
AutoCmd.__index = AutoCmd

function AutoCmd.new()
  this = {}

  setmetatable(this, AutoCmd)

  return this
end


return AutoCmd

