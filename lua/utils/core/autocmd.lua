local Table    = require 'lib.lua.core.table'
local Set      = require 'lib.lua.extensions.set'
local Validate = require 'lib.lua.utils.validate'
local TMerge   = require 'utils.api.tablemerge'


---@alias AutoCommandCallbackParams { id: number, event: string, group: number?, match: string, buf: number, file: string, data: any }
---@alias AutoCommandCallback fun(p: AutoCommandCallbackParams): r: boolean|nil

--- Wrapper around vim.api auto command functions.
--
---@class AutoCommand
---@field private id number?: the id of an autocommand
---@field private group (string|integer)?: the name or id of an autocommand's groups
---@field private pattern string[]?: file name pattern(s) that determine(s) for which files an
-- autocommand should run
---@field private buffer integer?: buffer id for buffer-local autocommands
---@field private event string[]?: the event(s) for which (an) autocommand(s) should run
---@field private desc string?: a string that describes an autocommand
---@field private callback AutoCommandCallback: callback to execute when an autocommand is
-- triggered
---@field private opts table: additional opts to pass to an autocommand CRUD call
local AutoCommand = {}
AutoCommand.__index = AutoCommand

--- Constructor
--
---@param config table?: configures the auto command; see class definition for field
-- descriptions
---@return AutoCommand: new auto command instance
function AutoCommand.new(config)
  return setmetatable(config or {}, AutoCommand)
end


-- Adds id to instance.
--
---@param id number: id to add to instance
---@return AutoCommand: self
function AutoCommand:withId(id)
  self.id = id
  return self
end


-- Adds event to instance.
--
---@param event string: event to add to instance
---@return AutoCommand: self
function AutoCommand:withEvent(event)
  self.event = self.event or {}
  table.insert(self.event, event)
  return self
end


-- Adds events to instance.
--
---@param events string[]: events to add to instance
---@return AutoCommand: self
function AutoCommand:withEvents(events)
  self.event = Table.concat({ self.event or {}, events })
  return self
end


-- Adds group to instance.
--
---@param group string|integer: group to add to instance
---@return AutoCommand: self
function AutoCommand:withGroup(group)
  self.group = group
  return self
end


-- Adds pattern to instance.
--
---@param pattern string: pattern to add to instance
---@return AutoCommand: self
function AutoCommand:withPattern(pattern)
  self.pattern = self.pattern or {}
  table.insert(self.pattern, pattern)
  return self
end


-- Adds patterns to instance.
--
---@param patterns string[]: patterns to add to instance
---@return AutoCommand: self
function AutoCommand:withPatterns(patterns)
  self.pattern = Table.concat({ self.pattern or {}, patterns })
  return self
end


-- Adds buffer id to instance.
--
---@param buffer integer: buffer id to add to instance
---@return AutoCommand: self
function AutoCommand:withBuffer(buffer)
  self.buffer = buffer
  return self
end


-- Adds description to instance.
--
---@param desc string: desc to add to instance
---@return AutoCommand: self
function AutoCommand:withDesc(desc)
  self.desc = desc
  return self
end


-- Adds callback to instance.
--
---@param callback AutoCommandCallback: callback to add to instance
---@return AutoCommand: self
function AutoCommand:withCallback(callback)
  self.callback = callback
  return self
end


-- Adds opts to instance.
--
---@param opts table: opts to add to instance
---@return AutoCommand: self
function AutoCommand:withOpts(opts)
  self.opts = opts
  return self
end


-- Adds individual opt to instance.
--
---@generic T
---@param key string: the key of the opt
---@param opt T: individual opt to add to instance
---@return AutoCommand: self
function AutoCommand:withOpt(key, opt)
  self.opts = self.opts or {}
  self.opts[key] = opt

  return self
end


local function validate(required, config, op)
  Validate.required(required, config, op .. ' auto command(s)')
end


--- Creates an auto command.
--
--  Note: this method sets this instance's "id" attribute as the id of the created auto
--  command.
--
---@param config table?: configures the auto command; merged w/ config that
-- exists in the instance, w/ values in config overriding instance config if collisions
-- are encountered
---@return number: the id of the created auto command
---@error if event and callback or command don't exist in config or in this instance
function AutoCommand:create(config)
  config = TMerge.mergeleft(self, config)

  validate({ 'event', { 'callback', 'command' }}, config, 'create')

  local event = config.event
  local opts = config.opts

  config = Table.pick_out(config, Set.new({ 'event', 'opts' }))
  config = TMerge.mergeleft(opts, config)

  self.id = vim.api.nvim_create_autocmd(event, config)
  return self.id
end


--- Deletes an auto command.
--
---@param config table?: configures the auto command; merged w/ config that
-- exists in the instance, w/ values in config overriding instance config if collisions
-- are encountered
---@error if id doesn't exist in config or in this instance
function AutoCommand:delete(config)
  config = TMerge.mergeleft(self, config)

  validate({ 'id' }, config, 'delete')

  vim.api.nvim_del_autocmd(config.id)
end

return AutoCommand

