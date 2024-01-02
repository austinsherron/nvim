local Validate = require 'toolbox.utils.validate'
local TMerge   = require 'utils.api.vim.tablemerge'


---@alias AutoCommandCallbackParams { id: number, event: string, group: number?, match: string, buf: number, file: string, data: any }
---@alias AutoCommandCallback fun(p: AutoCommandCallbackParams): r: boolean|nil

--- Wrapper around vim.api autocommand functions.
---
---@see vim.api.nvim_create_autocmd
---@see vim.api.nvim_del_autocmd
---@class AutoCommand
---@field private id number?: the id of an autocommand; required for deletion
---@field private group (integer)?: the name or id of an autocommand's group
---@field private pattern string[]?: file name pattern(s) that determine(s) for which files an
--- autocommand should run
---@field private buffer integer?: buffer id for buffer-local autocommands
---@field private event string[]?: the event(s) for which (an) autocommand(s) should run;
--- required for creation
---@field private desc string?: a string that describes an autocommand
---@field private callback AutoCommandCallback: callback to execute when an autocommand
--- is triggered; either this or command (set via opts) is required for creation
---@field private opts table: additional opts to pass to an autocommand CRUD call
local AutoCommand = {}
AutoCommand.__index = AutoCommand

--- Constructor
---
---@param config table?: configures the autocommand; see class definition for field
--- descriptions
---@return AutoCommand: new autocommand instance
function AutoCommand.new(config)
  config = config or {}
  config.opts = config.opts or {}

  return setmetatable(config, AutoCommand)
end


--- Adds id to instance.
---
---@param id number: id to add to instance
---@return AutoCommand: self
function AutoCommand:withId(id)
  self.id = id
  return self
end


--- Adds event to instance.
---
---@param event string: event to add to instance
---@return AutoCommand: self
function AutoCommand:withEvent(event)
  self.event = self.event or {}
  table.insert(self.event, event)
  return self
end


--- Adds events to instance.
---
---@param events string[]: events to add to instance
---@return AutoCommand: self
function AutoCommand:withEvents(events)
  self.event = Table.concat({ self.event or {}, events })
  return self
end


local function create_or_get_group(group_name, options)
  return Safe.call(function()
    return vim.api.nvim_create_augroup(group_name, options or {})
  end)
end


--- Adds group to instance.
---
--- Note: if a group w/ name == group doesn't already exist, this method will create it.
---
---@param group string|integer: group to add to instance
---@param options { clear: boolean? }|nil: options for creation/retrieving the augroup
--- see vim.api.nvim_create_augroup
---@return AutoCommand: self
function AutoCommand:withGroup(group, options)
  self.group = create_or_get_group(group, options)
  Debug('Created augroup="%s"', { group })
  return self
end


--- Adds pattern to instance.
---
---@param pattern string: pattern to add to instance
---@return AutoCommand: self
function AutoCommand:withPattern(pattern)
  self.pattern = self.pattern or {}
  table.insert(self.pattern, pattern)
  return self
end


--- Adds patterns to instance.
---
---@param patterns string[]: patterns to add to instance
---@return AutoCommand: self
function AutoCommand:withPatterns(patterns)
  self.pattern = Table.concat({ self.pattern or {}, patterns })
  return self
end


--- Adds buffer id to instance.
---
---@param buffer integer: buffer id to add to instance
---@return AutoCommand: self
function AutoCommand:withBuffer(buffer)
  self.buffer = buffer
  return self
end


--- Adds description to instance.
---
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
  self.callback = function(...)
    Debug(self:log_msg(self.id, 'Running'))
    return callback(...)
  end

  return self
end


--- Adds opts to instance.
---
---@param opts table: opts to add to instance
---@return AutoCommand: self
function AutoCommand:withOpts(opts)
  self.opts = opts or {}
  return self
end


--- Adds individual opt to instance.
---
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
  Validate.required(required, config, op .. ' autocommand(s)')
end


---@private
function AutoCommand:_create(config)
  config = TMerge.mergeleft(self, config or {})

  local options, rest = Table.split_one(config, 'opts')
  config = TMerge.mergeleft(options, rest)

  validate({ 'event', { 'callback', 'command' }}, config, 'create')

  local event, opts = Table.split_one(config, 'event')
  Debug('Creating autocmd for event="%s" with opts=%s', { event, opts })

  self.id = vim.api.nvim_create_autocmd(event, opts)
  return self.id
end


---@private
function AutoCommand:log_msg(id, action)
  return fmt(
    '%s autocmd (id=%d, desc=%s)',
    action,
    (id or '?'),
    (self.desc or '?')
  )
end


--- Creates an autocommand.
---
--- Note: this method sets this instance's "id" attribute as the id of the created
--- autocommand.
---
---@param config table?: configures the autocommand; merged w/ config that
--- exists in the instance, w/ values in config overriding instance config if collisions
--- are encountered
---@return number: the id of the created autocommand
---@error if event and callback or command don't exist in config or in this instance
function AutoCommand:create(config)
  local id = Safe.call(function() return self:_create(config) end)

  if id ~= nil then
    Debug(self:log_msg(id, 'Created'))
  end

  return id
end


---@private
function AutoCommand:_delete(config)
  config = TMerge.mergeleft(self, config or {})

  validate({ 'id' }, config, 'deleted')

  vim.api.nvim_del_autocmd(config.id)
  return config.id
end


--- Deletes an autocommand.
---
---@param config table?: configures the autocommand; merged w/ config that
---exists in the instance, w/ values in config overriding instance config if collisions
---are encountered
---@error if id doesn't exist in config or in this instance
function AutoCommand:delete(config)
  local id = Safe.call(function() return self:_delete(config) end)

  if id ~= nil then
    Debug(self:log_msg(id, 'Deleted'))
  end

  return id
end

return AutoCommand

