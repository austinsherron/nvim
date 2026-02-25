local Colors = require 'utils.api.vim.interface.__colors'
local Constants = require 'utils.api.vim.interface.__constants'
local Highlight = require 'utils.api.vim.interface.__highlight'

--- Namespace for custom highlight overrides; takes precedence over namespace 0 (where
--- colorschemes and plugins define highlights) when activated via nvim_set_hl_ns.
---
---@type integer
local CUSTOM_NS = vim.api.nvim_create_namespace 'custom_highlights'

--- Contains utilities for interacting w/ nvim ui elements.
---
---@class Interface
local Interface = {}

---@note: so Highlight is publicly accessible
Interface.Highlight = Highlight
---@note: so Colors is publicly accessible
Interface.Colors = Colors
---@note: so Constants is publicly accessible
Interface.Constants = Constants

--- Models params for setting highlights. See Interface.set_highlight.
---
---@class HighlightParams
---@field ns integer|nil: optional, defaults to 0 (global); the namespace in which to
--- define the highlight
---@field name string|nil: optional, acts as a name override for a highlight

--- Sets a highlight group using the provided opts.
---
---@param highlight Highlight: the highlight's definition
---@param opts HighlightParams|nil: optional, params used to set the provided highlight
---
function Interface.set_highlight(highlight, opts)
  opts = opts or {}

  local ns = opts.ns or 0
  local name = opts.name or highlight.name

  local hg = highlight:build()
  vim.api.nvim_set_hl(ns, name, hg)

  GetLogger('UI'):debug('Highlight=%s created for ns=%s; def=%s', { name, ns, hg })
end

--- Sets the provided highlights groups using the provided opts.
---
---@param highlights Highlight[]: the highlight definitions
---@param opts HighlightParams|nil: optional, params used to set all provided highlights
---
function Interface.set_highlights(highlights, opts)
  opts = opts or {}

  foreach(highlights, function(hl)
    Interface.set_highlight(hl, opts)
  end)
end

--- Sets custom highlight groups and activates custom highlights namespace.
---
--- See Interface.Constants.HIGHLIGHTS.
function Interface.set_custom_highlights()
  -- INFO: set active custom highlight namespace so it takes precedence over namespace 0
  vim.api.nvim_set_hl_ns(CUSTOM_NS)
  Interface.set_highlights(Interface.Constants.HIGHLIGHTS, { ns = CUSTOM_NS })
end

local function set_diagnostic_signs()
  -- INFO: set custom diagnostic signs
  vim.diagnostic.config({
    signs = { text = Constants.DIAGNOSTIC_SIGNS },
  })
end

--- Initializes interface customizations.
function Interface.init()
  set_diagnostic_signs()
  Interface.set_custom_highlights()
end

return Interface
