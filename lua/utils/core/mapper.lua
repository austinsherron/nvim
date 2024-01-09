local Lambda = require 'toolbox.functional.lambda'
local Lazy = require 'toolbox.utils.lazy'
local Stack = require 'toolbox.extensions.stack'

local Constants = require('plugins.extensions.interface.hydra').Constants

local Hydra = Lazy.require 'hydra'

local LOGGER = GetLogger 'KEYMAP'
local DEFAULT_MODES = { 'n' }
-- WARN: this is effectively duplicated in this file's unit tests
local DEFAULT_OPTIONS = { noremap = true }
local DEFAULT_HYDRA_CONFIG = { invoke_on_body = true }

---@alias BindingOptions { desc_prefix: string|nil, desc: string|nil, nowait: boolean|nil, silent: boolean|nil }
---@alias Binding { lhs: string|nil, rhs: string|function|nil, options: BindingOptions|nil, modes: string[]|nil }
---@alias ConfigRemovalOpts { count: integer|nil, purge: 'current'|'all'|nil }

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
---@field private hydra_config Stack
local KeyMapper = {}
KeyMapper.__index = KeyMapper

--- Constructor
---
---@param options BindingOptions|nil:
---@return KeyMapper: a new instance
function KeyMapper.new(options)
  local this = {
    hydrda = nil,
    options = Stack.new(),
    hydra_config = Stack.new(DEFAULT_HYDRA_CONFIG),
  }
  this.options:push(DEFAULT_OPTIONS)

  if
    Table.not_nil_or_empty(options --[[@as table]])
  then
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
  if self.hydra ~= nil then
    self.hydra_config:push(options)
  else
    self.options:push(options)
  end

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

local function get_merged_options(options, stk)
  -- create a single array (stack, based on precedence) w/ all options
  local all_options = Table.concat({ stk:peekall(), { options or {} } })
  -- merge all options into single dict
  return Table.combine_many(all_options)
end

---@private
function KeyMapper:get_options(options)
  -- merge individual binding options, if any, w/ instance level options, if any
  options = get_merged_options(options, self.options)

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

  LOGGER:debug('Binding lhs="%s" to rhs="%s"', { lhs, rhs })
  LOGGER:trace('Binding opts=%s, modes=%s', { options, modes })
  vim.keymap.set(modes, lhs, rhs, options)
  LOGGER:debug 'Binding processed successfully'
end

---@private
function KeyMapper:handle_esc(bindings)
  local esc = Table.safeget(self.hydra, { 'config', 'esc' })
  Table.safeset(self.hydra, { 'config', 'esc' }, nil)

  if esc ~= true then
    return
  end

  Array.append(bindings, Constants.ESC_BINDING)
end

---@private
function KeyMapper:handle_fmttr(bindings)
  local fmttr = Table.safeget(self.hydra, { 'config', 'hint', 'fmttr' })

  if fmttr == nil then
    return bindings
  end

  -- if there is a hint formatter, clear it out of the "hint" table before passing it
  -- through to hydra, use it to create a formatted hint from bindings, and set each
  -- binding's "desc" to false, to prevent hydra from including default hints
  self.hydra.config.hint.fmttr = nil
  self.hydra.hint = fmttr(bindings, Table.safeget(self.hydra, 'name'))

  bindings = filter(bindings, Lambda.NOT(Lambda.EQUALS_THIS(Constants.VERTICAL_BREAK)))
  foreach(bindings, function(b)
    Table.safeset(b, { 3, 'desc' }, false)
  end)

  return bindings
end

---@private
---@return HydraBinding
function KeyMapper:get_hydra(bindings)
  self.hydra.config = get_merged_options({}, self.hydra_config)

  self:handle_esc(bindings)
  bindings = self:handle_fmttr(bindings)

  return Table.combine({ heads = bindings }, self.hydra)
end

---@private
function KeyMapper:do_hydra_binding(bindings)
  local hydra = self:get_hydra(bindings)

  LOGGER:debug('Binding hydra=%s', { hydra.name })
  LOGGER:trace('Hydra binding=%s', { hydra })
  Hydra(hydra)
  LOGGER:debug 'Hydra bindings processed successfully'
end

---@private
function KeyMapper:pop_options()
  if self.hydra ~= nil and not self.hydra_config:empty() then
    self.hydra_config:pop()
  elseif self.hydra ~= nil then
    self.hydra = nil
  else
    self.options:pop()
  end
end

---@private
function KeyMapper:purge_context(purge)
  if (purge == 'current' and self.hydra == nil) or purge == 'all' then
    self.options = Stack.new()
  end

  if (purge == 'current' and self.hydra ~= nil) or purge == 'all' then
    self.hydra = nil
    self.hydra_config = Stack.new()
  end

  return self
end

--- Removes contextual configuration based on the provided context. Config is removed from
--- the instance in LIFO order. Configuration from all sources is eligible for removal,
--- including config added during instantiation, via KeyMapper.with, or via hydra binding.

--- TODO: test
---
---@param opts ConfigRemovalOpts|nil: optional, defaults to { count = 1 }; parameterizes
--- config removal; count specifies the number of contexts to remove; purge indicates that
--- either the 'current' context's configuration should be purged (i.e.: all of vim or all
--- of hydra), or that 'all' contextual config from all sources should be purged
---@return KeyMapper: self
function KeyMapper:done(opts)
  opts = opts or { count = 1 }

  if opts.purge ~= nil then
    return self:purge_context(opts.purge)
  end

  local count = opts.count or 1

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
  LOGGER:debug('Processing %s %s key binding(s) for %s', { #bindings, type, self:get_desc() })

  if self.hydra ~= nil then
    self:do_hydra_binding(bindings)
  else
    foreach(bindings, function(b)
      self:do_vim_binding(Table.unpack(b))
    end)
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
  return self:bind({ { lhs, rhs, options, modes } })
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
