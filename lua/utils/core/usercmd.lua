local Validate = require 'toolbox.utils.validate'
local TMerge   = require 'utils.api.vim.tablemerge'


---@alias UserCommandConfig { name: string?, cmd: (string|function)?, bufnum: integer?, opts: table? }

--- Wrapper around vim.api user command functions.
---
---@class UserCommand
---@field name string?: name of the user command (how it's invoked)
---@field cmd (string|function)?: string command or lua function to invoke for command
---@field bufnum integer?: id of buffer to which to attach command; if present, command is
--- considered local to buffer
---@field opts table?: parameterizes command creation
local UserCommand = {}
UserCommand.__index = UserCommand

--- Constructor
---
---@param config UserCommandConfig?: configures the user command
---@return UserCommand: new user command instance
function UserCommand.new(config)
  return setmetatable(config or {}, UserCommand)
end


--- Adds name to instance.
---
---@param name string: name to add to instance
---@return UserCommand: self
function UserCommand:withName(name)
  self.name = name
  return self
end


--- Adds bufnum to instance. Causes user command to be created as buffer local. Calling w/
--- nil will reset that behavior.
---
---@param bufnum integer?: buffer number to add to instance, or nil to reset the bufnum
---@return UserCommand: self
function UserCommand:withBufnum(bufnum)
  self.bufnum = bufnum
  return self
end


--- Adds cmd to instance.
---
---@param cmd string|function: cmd to add to instance
---@param nargs integer|string|nil: the number of parameters the command accepts; use "?" for
--- variable # of params, or omit if no parameters
---@return UserCommand: self
function UserCommand:withCmd(cmd, nargs)
  self.cmd = cmd

  if nargs ~= nil then
    self:withOpt('nargs', nargs)
  end

  return self
end


--- Adds description to instance.
---
---@param desc string: desc to add to instance
---@return UserCommand: self
function UserCommand:withDesc(desc)
  self:withOpt('desc', desc)
  return self
end


--- Adds opts to instance.
---
---@param opts table: opts to add to instance
---@return UserCommand: self
function UserCommand:withOpts(opts)
  self.opts = opts
  return self
end


--- Adds individual opt to instance.
---
---@generic T
---@param key string: the key of the opt
---@param opt T: individual opt to add to instance
---@return UserCommand: self
function UserCommand:withOpt(key, opt)
  self.opts = self.opts or {}
  self.opts[key] = opt

  return self
end


local function validate(required, config, op)
  Validate.required(required, config, op .. ' user command(s)')
end


local function create_buf_cmd(config)
  vim.api.nvim_buf_create_user_command(
    config.bufnum,
    config.name,
    config.cmd,
    config.opts
  )
end


local function create_cmd(config)
  vim.api.nvim_create_user_command(config.name, config.cmd, config.opts)
end


--- Creates a user command. Command is buffer local if bufnum is in config or exists in
--- this instance.
---
---@see vim.api.nvim_create_user_command
---@see vim.api.nvim_buf_create_user_command
---
---@param config UserCommandConfig?: configures the user command; merged w/ config that
--- exists in the instance, w/ values in config overriding instance config if collisions
--- are encountered
---@error if name or cmd don't exist in config or in this instance
function UserCommand:create(config)
  config = TMerge.mergeleft(self, config or {})
  config.opts = config.opts or {}

  validate({ 'name', 'cmd' }, config, 'create')

  if config.bufnum ~= nil then
    create_buf_cmd(config)
  else
    create_cmd(config)
  end

  InfoQuietly('Created usercmd (name=%s)', { config.name })
end


--- Deletes a user command. Command is considered buffer local if bufnum is in config or
--- exists in this instance.
---
---@see vim.api.nvim_del_user_command
---@see vim.api.nvim_buf_del_user_command
---
---@param config UserCommandConfig?: configures the user command; merged w/ config that
--- exists in the instance, w/ values in config overriding instance config if collisions
--- are encountered
---@error if name doesn't exist in config or in this instance
function UserCommand:delete(config)
  config = TMerge.mergeleft(self, config or {})

  validate({ 'name' }, config, 'delete')

  if config.bufnum ~= nil then
    vim.api.nvim_buf_del_user_command(config.bufnum, config.name)
  else
    vim.api.nvim_del_user_command(config.name)
  end

  InfoQuietly('Deleted usercmd (name=%s)', { config.name })
end

return UserCommand

