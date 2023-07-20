-- WIP

local Table = require 'lib.lua.core.table'

local create_autocmd = vim.api.nvim_create_autocmd


---@alias AutoCmdCallbackParams { id: number, event: string, group: number?, match: string, buf: number, file: string, data: any }
---@alias AutoCmdCallback (fun(p: AutoCmdCallbackParams): r: boolean?)
---@alias AutoCmdParams { group: (string|integer)?, pattern: (string|Array)?, buffer: integer?, desc: string?, callback: (AutoCmdCallback|string)?, command: string?, once: boolean?, nested: boolean? }


local AutoCmd = {}
AutoCmd.__index = AutoCmd

function AutoCmd.new(default_options)
  local this = Table.shallow_copy(default_options)
  setmetatable(this, AutoCmd)
  return this
end


local function make_autocmd(event, opts)

end


local function make_event_fn(event, opts)
  return function()
    make_autocmd(event, opts)
  end
end


function AutoCmd:__index(fn_name)
  return make_event_fn(fn_name)
end

return AutoCmd

