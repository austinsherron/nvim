-- TODO: stub

local AutoCmd = {}
AutoCmd.__index = AutoCmd

function AutoCmd.new()
  local this = {}

  setmetatable(this, AutoCmd)

  return this
end


return AutoCmd

