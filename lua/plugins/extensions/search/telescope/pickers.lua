local ActionUtils = require 'plugins.extensions.search.telescope.actionutils'
local Env = require 'toolbox.system.env'
local Path = require 'toolbox.system.path'
local System = require 'utils.api.vim.system'
local Tab = require 'utils.api.vim.tab'

local actions = require 'telescope.actions'
local builtins = require 'telescope.builtin'

--- Contains functions that implement custom telescope pickers. Current pickers include:
---
---   * A custom picker that searches for nvim plugin packages and enables drill-down file
---     search on them
---
---@class Pickers
local Pickers = {}

local function live_grep_packages(selection, _)
  local plugin_path = selection[1]

  builtins.live_grep({
    cwd = plugin_path,
    prompt_title = 'Live Grep in ' .. Path.basename(plugin_path) .. ' plugin files',
  })

  return true
end

local function cd_into_package(selection, prompt_buffer)
  local plugin_path = selection[1]
  actions.close(prompt_buffer)

  GetLogger('EXT'):debug('Chaging cwd to plugin dir=%s', { plugin_path })

  Tab.open()
  System.cd(plugin_path)

  builtins.find_files({
    cwd = plugin_path,
    prompt_title = 'Search ' .. Path.basename(plugin_path) .. ' plugin files',
  })

  return true
end

local function make_keymap()
  return {
    { 'i', '<C-g>', live_grep_packages },
    { 'n', 'fw', live_grep_packages },
    { 'i', '<C-w>', cd_into_package },
    { 'n', 'cd', cd_into_package },
  }
end

local function search_package_files(selection, _)
  local plugin_path = selection[1]

  builtins.find_files({
    cwd = plugin_path,
    prompt_title = 'Search ' .. Path.basename(plugin_path) .. ' plugin files',
  })

  return true
end

local function make_attachment_action()
  return ActionUtils.replace_default_action(Safe.ify(search_package_files), make_keymap())
end

--- Custom telescope picker for searching "nvundle" (i.e.: plugin directories).
function Pickers.search_packages()
  local find_command = { 'find', Env.nvundle(), '-maxdepth', '1', '-type', 'd' }

  builtins.find_files({
    attach_mappings = make_attachment_action(),
    find_command = find_command,
    path_display = function(_, path)
      return Path.basename(path)
    end,
    prompt_title = 'Search Plugins',
  })
end

return Pickers
