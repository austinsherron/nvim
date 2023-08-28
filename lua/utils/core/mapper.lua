local String = require 'toolbox.core.string'
local Table  = require 'toolbox.core.table'
local Stack  = require 'toolbox.extensions.stack'
local Stream = require 'toolbox.extensions.stream'


local DEFAULT_MODES = { 'n' }
-- WARN: this is effectively duplicated in this file's unit tests
local DEFAULT_OPTIONS = { noremap = true }

---@alias BindingOptions { desc_prefix: string|nil, desc: string|nil, nowait: boolean|nil, silent: boolean|nil }
---@alias Binding { lhs: string|nil, rhs: string|function|nil, options: BindingOptions|nil, modes: string[]|nil }

--- Utility for binding key sequences to actions/commands.
---
---@class KeyMapper
---@field private options Stack
local KeyMapper = {}
KeyMapper.__index = KeyMapper

--- Constructor
---
---@param options BindingOptions|nil:
---@return KeyMapper: a new instance
function KeyMapper.new(options)
  local this = { options = Stack.new() }
  this.options:push(DEFAULT_OPTIONS)

  if Table.not_nil_or_empty(options --[[@as table]]) then
    this.options:push(options or {})
  end

  return setmetatable(this, KeyMapper)
end


--- Adds a set of binding options to use w/ all subsequent bind calls until KeyMapper.done
--- is called. Multiple calls to KeyMapper.with will add options to the instance in last
--- in, first-out order.
---
---@param options BindingOptions: the options to use
---@return KeyMapper: self
function KeyMapper:with(options)
  self.options:push(options)
  return self
end


---@private
function KeyMapper:get_merged_options(options)
  -- create a single array (stack, based on precedence) w/ all options
  local all_options = Table.concat({ self.options:peekall(), { options or {}}})
  -- merge all options into single dict
  return Table.combine_many(all_options)
end


---@private
function KeyMapper:get_options(options)
  -- merge individual binding options, if any, w/ instance level options, if any
  options = self:get_merged_options(options)

  if Table.nil_or_empty(options) then
    return {}
  end

  -- if there's a description prefix, pick it out and combine it w/ the binding's
  -- description, if any
  local desc_prefix, final_opts = Table.split_one(options, 'desc_prefix')
  local desc = (desc_prefix or '') .. (final_opts.desc or '')

  -- if there is a description, set it in options
  if String.not_nil_or_empty(desc) then
    final_opts.desc = desc
  end

  -- return processed options
  return final_opts
end


-- more or less sourced from https://github.com/brainfucksec/neovim-lua/blob/main/nvim.lua.keymaps.lua
---@private
function KeyMapper:do_binding(lhs, rhs, options, modes)
  options = self:get_options(options)
  modes = modes or DEFAULT_MODES

  DebugQuietly({ 'Binding lhs="', lhs, '" to rhs="', rhs, '" (opts=', options, ', modes=', modes, ')' })
  vim.keymap.set(modes, lhs, rhs, options)
  DebugQuietly({ 'Binding processed successfully' })
end


--- Signals that we should no longer use the options most recently added from any source,
--- including from the last call to KeyMapper.with or provided during instantiation.
---
---@return KeyMapper: self
function KeyMapper:done()
  self.options:pop()
  return self
end


--- Binds the provided key bindings.
---
---@param bindings Binding[]: the key bindings to bind
---@return KeyMapper: self
function KeyMapper:bind(bindings)
  InfoQuietly({ 'Processing ', #bindings, ' key bindings' })

  Stream(bindings)
    :foreach(function(b) self:do_binding(Table.unpack(b)) end)

  return self
end


--- Binds a single key binding.
---
---@param lhs string: the key sequence to bind to an action
---@param rhs string|function: the action to bind to a key sequence
---@param options BindingOptions|nil: parameterizes key binding
---@param modes string[]|nil: the vim modes in which the binding should take effect
---@return KeyMapper: self
function KeyMapper:bind_one(lhs, rhs, options, modes)
  return self:bind({{ lhs, rhs, options, modes }})
end


--- Binds a single key binding w/out an instantiated key mapper. Note that this functions
--- is not intended for repeated calls in the same general location.
---
---@see KeyMapper.bind_one for argument descriptions
function KeyMapper.quick_bind(lhs, rhs, options, modes)
  KeyMapper.new():bind_one(lhs, rhs, options, modes)
end


---@note: exposed primarily for testing, though I don't think there's any harm in exposing
--- them
KeyMapper.DEFAULT_MODES = DEFAULT_MODES
KeyMapper.DEFAULT_OPTIONS = DEFAULT_OPTIONS

return KeyMapper

