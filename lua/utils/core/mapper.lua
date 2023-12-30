local String = require 'toolbox.core.string'
local Table  = require 'toolbox.core.table'
local Stack  = require 'toolbox.extensions.stack'
local Lazy   = require 'toolbox.utils.lazy'

local ternary = require('toolbox.core.bool').ternary
local foreach = require('toolbox.utils.map').foreach

local Hydra = Lazy.require('hydra')


local DEFAULT_MODES = { 'n' }
-- WARN: this is effectively duplicated in this file's unit tests
local DEFAULT_OPTIONS = { noremap = true }
local ESC_BINDING = {'<Esc>', nil, { desc = 'Exit' }}

---@alias BindingOptions { desc_prefix: string|nil, desc: string|nil, nowait: boolean|nil, silent: boolean|nil }
---@alias Binding { lhs: string|nil, rhs: string|function|nil, options: BindingOptions|nil, modes: string[]|nil }

--- Type definition for a hydra binding.
---
--- WARN: this class's fields are dependent on the impl of hydra.nvim; unfortunately,
--- hydra doesn't define a type that maps cleanly to this construct.
---
---@class HydraBinding
---@field name string: the name of the hydra binding
---@field body string: the leader that "summons" a hydra key binding
---@field hint HydraHint|nil: optional; a long-form string hint/description for the hydra
--- binding
---@field config table|nil: optional; configures the hydra binding; see :h hydra-config
---@field mode string|string[]|nil: optional, defaults to "n"; the modes in which this
--- hydra binding exists

--- Utility for binding key sequences to actions/commands.
---
---@class KeyMapper
---@field private hydra HydraBinding|nil
---@field private options Stack
local KeyMapper = {}
KeyMapper.__index = KeyMapper

--- Constructor
---
---@param options BindingOptions|nil:
---@return KeyMapper: a new instance
function KeyMapper.new(options)
  local this = {
    hydrda  = nil,
    options = Stack.new(),
  }
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


--- Adds hydra binding config to the instance, or combines hydra w/ self.hydra if
--- self.hydra ~= nil. Calling this method signals to the mapper that subsequent calls to
--- "bind" should create a hydra mapping, as opposed to a standard vim key binding.
---
---@param hydra HydraBinding
---@return KeyMapper: self
function KeyMapper:with_hydra(hydra)
  self.hydra = Table.combine(self.hydra or {}, hydra)
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


---@private
function KeyMapper:get_desc()
  return String.alphanum(self:get_options().desc or '')
end


-- more or less sourced from https://github.com/brainfucksec/neovim-lua/blob/main/nvim.lua.keymaps.lua
---@private
function KeyMapper:do_vim_binding(lhs, rhs, options, modes)
  options = self:get_options(options)
  modes = modes or DEFAULT_MODES

  Trace('Binding lhs="%s" to rhs="%s" (opts=%s, modes=%s)', { lhs, rhs, options, modes })
  vim.keymap.set(modes, lhs, rhs, options)
  Trace('Binding processed successfully')
end


---@private
function KeyMapper:handle_esc(bindings)
  local esc = Table.safeget(self.hydra, { 'config', 'esc' })
  Table.safeset(self.hydra, { 'config', 'esc' }, nil)

  if esc ~= true then
    return
  end

  Array.append(bindings, ESC_BINDING)
end


---@private
---@return HydraBinding
function KeyMapper:get_hydra(bindings)
  self:handle_esc(bindings)

  local fmttr = Table.safeget(self.hydra, { 'config', 'hint', 'fmttr' })

  if fmttr == nil then
    Debug('No hydra formatter found')
    return self.hydra
  end

  -- if there is a hint formatter, clear it out of the "hint" table before passing it
  -- through to hydra, use it to create a formatted hint from bindings, and set each
  -- binding's "desc" to false, to prevent hydra from including default hints
  self.hydra.config.hint.fmtter = nil
  self.hydra.hint = fmttr(bindings, Table.safeget(self.hydra, 'name'))

  foreach(bindings, function(b) Table.safeset(b, { 3, 'desc' }, false) end)
  return self.hydra
end


---@private
function KeyMapper:do_hydra_binding(bindings)
  local hydra = Table.combine({ heads = bindings }, self:get_hydra(bindings))

  Debug('Binding hydra=%s', { hydra })
  Hydra(hydra)
  Debug('Hydra bindings processed successfully')
end


---@private
function KeyMapper:pop_options()
  if self.hydra ~= nil then
    self.hydra = nil
  else
    self.options:pop()
  end
end


--- Signals that we should no longer use the context most recently added from any source.
--- This includes options from the last call to KeyMapper.with or provided during
--- instantiation, or hydra binding context.
---
---@param count integer|nil: optional, defaults to 1; the number of contexts to remove
---@return KeyMapper: self
function KeyMapper:done(count)
  count = count or 1

  for _ = count - 1, 0, -1 do
    self:pop_options()
  end

  return self
end


--- Binds the provided key bindings.
---
---@param bindings Binding[]: the key bindings to bind
---@return KeyMapper: self
function KeyMapper:bind(bindings)
  local type = ternary(self.hydra == nil, 'vim', 'hydra')
  Debug('Processing %s %s key binding(s) for %s', { #bindings, type, self:get_desc() })

  if self.hydra ~= nil then
    self:do_hydra_binding(bindings)
  else
    foreach(bindings, function(b) self:do_vim_binding(Table.unpack(b)) end)
  end

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


--- Checks if binding == the escape binding.
---
---@param binding Binding: the binding to check
---@return boolean: true if binding == the escape binding, false otherwise
function KeyMapper.is_esc_binding(binding)
  return Array.equals(binding, ESC_BINDING)
end


---@note: exposed primarily for testing, though I don't think there's any harm in exposing
--- them
KeyMapper.DEFAULT_MODES = DEFAULT_MODES
KeyMapper.DEFAULT_OPTIONS = DEFAULT_OPTIONS

return KeyMapper

