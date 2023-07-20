local Bool     = require 'lib.lua.core.bool'
local NvTree   = require 'plugins.extensions.nvimtree'
local Builtins = require 'telescope.builtin'


--- Contains functions that implement extended (custom) telescope search functionality.
--
---@class Telescope
local Telescope = {}

--- Executes a search function constrained to the nvimtree dir under the cursor, if any.
--  Otherwise, executes an unconstrained search.
--
---@param f function: telescope picker function to execute
---@return any?: the return value of f
function Telescope.do_contextual_search(f)
  local node = NvTree:get_cursor_node()

  local opts = Bool.ternary(
    NvTree.is_dir(node),
    function() return { cwd = node.absolute_path } end
  )

  return f(opts)
end


--- Calls do_contextual_search w/ the `find_files` telescope builtin.
--
---@see telescope.builtins.find_files
function Telescope.contextual_find_files()
  return Telescope.do_contextual_search(Builtins.find_files)
end


--- Calls do_contextual_search w/ the `live_grep` telescope builtin.
--
---@see telescope.builtins.live_grep
function Telescope.contextual_live_grep()
  return Telescope.do_contextual_search(Builtins.live_grep)
end

return Telescope

