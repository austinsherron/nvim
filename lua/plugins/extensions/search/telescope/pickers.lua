local ActionUtils = require 'plugins.extensions.search.telescope.actionutils'
local EntryUtils = require 'plugins.extensions.search.telescope.entryutils'
local Env = require 'toolbox.system.env'
local File = require 'toolbox.system.file'
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

local function make_search_package_files(all)
  local opts = ternary(all == true, ActionUtils.Constants.FIND_ALL_FILES_OPTS, {})

  return function(selection, _)
    local plugin_path = selection[1]

    builtins.find_files(Table.combine({
      cwd = plugin_path,
      prompt_title = 'Search ' .. Path.basename(plugin_path) .. ' plugin files',
    }, opts))

    return true
  end
end

local function make_keymap()
  return {
    { 'i', '<C-g>', live_grep_packages },
    { 'n', 'fw', live_grep_packages },
    { 'i', '<C-h>', make_search_package_files(true) },
    { 'n', 'F', make_search_package_files(true) },
    { 'i', '<C-w>', cd_into_package },
    { 'n', 'cd', cd_into_package },
  }
end

local function make_attachment_action()
  return ActionUtils.replace_default_action(
    Safe.ify(make_search_package_files()),
    make_keymap()
  )
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

local function make_display_name(path)
  local first_line = File.read_n(path, 1)
  return (first_line and #first_line > 0 and #first_line[1] > 0)
    and String.trim_before(first_line[1], '# ')
end

--- Custom telescope picker for search Claude plans.
function Pickers.search_claude_plans()
  local plans_dir = Env.claude_config_dir() .. '/plans'

  builtins.find_files({
    cwd = plans_dir,
    find_command = { 'find', '.', '-maxdepth', '1', '-type', 'f' },
    entry_maker = EntryUtils.make_entry_maker(make_display_name, plans_dir),
    prompt_title = 'Search Claude Plans',
  })
end

return Pickers
