local refactoring = Lazy.require 'refactoring' ---@module 'refactoring'

--- Api for refactoring functionality.
---
---@class Refactor
local Refactor = {}

local function extract(what, tofile)
  local cmd = 'Extract ' .. String.capitalize(what)

  if tofile == true then
    cmd = cmd .. ' To File'
  end

  refactoring.refactor(cmd)
end

local function inline(what)
  local cmd = 'Inline ' .. String.capitalize(what)
  refactoring.refactor(cmd)
end

--- Extracts selection to a function.
---
---@param tofile boolean|nil: if true, the function will be extracted to a new file
function Refactor.extractfn(tofile)
  extract('function', tofile)
end

--- Inlines the function under the cursor.
function Refactor.inlinefn()
  inline 'function'
end

--- Extracts selection to a variable.
function Refactor.extractvar()
  extract 'variable'
end

--- Inlines the selection or variable under the cursor.
function Refactor.inlinevar()
  inline 'variable'
end

--- Extracts to a function the block under cursor.
---
---@param tofile boolean|nil: if true, the block will be extracted to a new file
function Refactor.extractblock(tofile)
  extract('block', tofile)
end

return Refactor
