local KeyMapper = require 'utils.core.mapper'
local TreeGit = require 'plugins.extensions.git.treegit'

local TreeActions = require('plugins.extensions.navigation').NvimTree.Actions
local TreeSearch = require('plugins.extensions.search').Telescope.TreeSearch

local KM = KeyMapper.new({ desc_prefix = 'nvim-tree: ', nowait = true })

-- interactions ----------------------------------------------------------------

KM:bind({
  { '<M-S-T>', ':NvimTreeFocus<CR>', { desc = 'focus' } },
  { '<leader>1', ':NvimTreeToggle<CR>', { desc = 'toggle' } },
  { '<M-t>', ':NvimTreeToggle<CR>', { desc = 'toggle' } },

  { '<leader>F', ':NvimTreeFindFile<CR>', { desc = 'find file in tree' } },
  { '<leader>F!', ':NvimTreeFindFile!<CR>', { desc = 'find file in tree!' } },
})

-- on_attach -------------------------------------------------------------------

--[[
    much of the code in this file from this point, or at least the underlying
    structure/logic of it, was automatically generated via :NvimTreeGenerateOnAttach

    see https://github.com/nvim-tree/nvim-tree.lua/wiki/Migrating-To-on_attach for details
--]]

--[[
    feel free to modify or remove as you wish (note from implementors of nvimtree),
    but (note from me, Austin) make sure to comment out the replaced mapping to keep
    a readily accessible record of the defaults
--]]

local function default_mappings(bufnr, api)
  KM:with({ buffer = bufnr })
    :bind({
      -- key mappings
      { '<C-]>', api.tree.change_root_to_node, { desc = 'CD' } },
      { '<C-e>', api.node.open.replace_tree_buffer, { desc = 'Open: In Place' } },
      { '<C-k>', api.node.show_info_popup, { desc = 'Info' } },
      { '<C-r>', api.fs.rename_sub, { desc = 'Rename: Omit Filename' } },
      { '<C-t>', api.node.open.tab, { desc = 'Open: New Tab' } },
      { '<C-v>', api.node.open.vertical, { desc = 'Open: Vertical Split' } },
      { '<C-x>', api.node.open.horizontal, { desc = 'Open: Horizontal Split' } },
      { '<BS>', api.node.navigate.parent_close, { desc = 'Close Directory' } },
      { '<CR>', api.node.open.edit, { desc = 'Open' } },
      { '<Tab>', api.node.open.preview, { desc = 'Open Preview' } },
      { '>', api.node.navigate.sibling.next, { desc = 'Next Sibling' } },
      { '<', api.node.navigate.sibling.prev, { desc = 'Previous Sibling' } },
      { '.', api.node.run.cmd, { desc = 'Run Command' } },
      -- { '-', api.tree.change_root_to_parent, { desc = 'Up' } },
      { 'a', api.fs.create, { desc = 'Create' } },
      { 'bd', api.marks.bulk.delete, { desc = 'Delete Bookmarked' } },
      { 'bmv', api.marks.bulk.move, { desc = 'Move Bookmarked' } },
      { 'B', api.tree.toggle_no_buffer_filter, { desc = 'Toggle No Buffer' } },
      { 'c', api.fs.copy.node, { desc = 'Copy' } },
      -- { 'C', api.tree.toggle_git_clean_filter, { desc = 'Toggle Git Clean' } },
      { '[c', api.node.navigate.git.prev, { desc = 'Prev Git' } },
      { ']c', api.node.navigate.git.next, { desc = 'Next Git' } },
      { 'd', api.fs.remove, { desc = 'Delete' } },
      -- { 'D', api.fs.trash, { desc = 'Trash' } },
      { 'E', api.tree.expand_all, { desc = 'Expand All' } },
      { 'e', api.fs.rename_basename, { desc = 'Rename: Basename' } },
      { ']e', api.node.navigate.diagnostics.next, { desc = 'Next Diagnostic' } },
      { '[e', api.node.navigate.diagnostics.prev, { desc = 'Prev Diagnostic' } },
      -- { 'F', api.live_filter.clear, { desc = 'Clean Filter' } },
      -- { 'f', api.live_filter.start, { desc = 'Filter' } },
      { 'g?', api.tree.toggle_help, { desc = 'Help' } },
      { 'gy', api.fs.copy.absolute_path, { desc = 'Copy Absolute Path' } },
      -- { 'H', api.tree.toggle_hidden_filter, { desc = 'Toggle Dotfiles' } },
      { '<C-g>', api.tree.toggle_gitignore_filter, { desc = 'Toggle Git Ignore' } },
      { 'J', api.node.navigate.sibling.last, { desc = 'Last Sibling' } },
      { 'K', api.node.navigate.sibling.first, { desc = 'First Sibling' } },
      { 'm', api.marks.toggle, { desc = 'Toggle Bookmark' } },
      { 'o', api.node.open.edit, { desc = 'Open' } },
      { 'O', api.node.open.no_window_picker, { desc = 'Open: No Window Picker' } },
      { 'p', api.fs.paste, { desc = 'Paste' } },
      { 'P', api.node.navigate.parent, { desc = 'Parent Directory' } },
      -- { 'q', api.tree.close, { desc = 'Close' } },
      { 'r', api.fs.rename, { desc = 'Rename' } },
      { 'R', api.tree.reload, { desc = 'Refresh' } },
      -- { 's', api.node.run.system, { desc = 'Run System' } },
      -- { 'S', api.tree.search_node, { desc = 'Search' } },
      -- { 'U', api.tree.toggle_custom_filter, { desc = 'Toggle Hidden' } },
      { 'W', api.tree.collapse_all, { desc = 'Collapse' } },
      { 'x', api.fs.cut, { desc = 'Cut' } },
      { 'y', api.fs.copy.filename, { desc = 'Copy Name' } },
      { 'Y', api.fs.copy.relative_path, { desc = 'Copy Relative Path' } },

      -- mouse mappings (I explicitly disable the mouse in vim/nvim, so these are unused
      -- at this point)
      { '<2-LeftMouse>', api.node.open.edit, { desc = 'Open' } },
      { '<2-RightMouse>', api.tree.change_root_to_node, { desc = 'CD' } },
    })
    :done()
end

local function remapped_defaults(bufnr, api)
  KM:with({ buffer = bufnr })
    :bind({
      { 'I', api.tree.toggle_hidden_filter, { desc = 'Toggle Dotfiles' } },
      { '<C-s>', TreeActions.silent_open, { desc = 'Open silently' } },
      { 'f', TreeSearch.contextual_find_files, { desc = 'Contexual find files' } },
      {
        'F',
        TreeSearch.contextual_find_all_files,
        { desc = 'Contexual find all files' },
      },
      -- note: group 'w' w/ other search bindings instead of custom mappings
      { 'w', TreeSearch.contextual_live_grep, { desc = 'Contexual find words' } },
    })
    :done()
end

local function custom_mappings(bufnr, api)
  KM:with({ buffer = bufnr })
    :bind({
      -- natural continuation of vim-like key-bindings
      { 'l', api.node.open.edit, { desc = 'Open' } },
      { 'L', api.tree.change_root_to_node, { desc = 'CD' } },
      { 'h', api.node.navigate.parent_close, { desc = 'Close Directory' } },
      { 'H', api.tree.change_root_to_parent, { desc = 'Up' } },

      -- bindings for git ops
      { 's', TreeGit.stage, { desc = 'Stage node' } },
      -- note: group '-', 'u', and 'D' w/ git bindings instead of remapped defaults
      { '-', TreeGit.toggle_stage, { desc = 'Toggle node stageing' } },
      { 'u', TreeGit.unstage, { desc = 'Unstage node' } },
      {
        'S',
        function()
          TreeGit.stage(true)
        end,
        { desc = 'Stage repo' },
      },
      {
        'U',
        function()
          TreeGit.unstage(true)
        end,
        { desc = 'Unstage repo' },
      },
      { 'D', TreeGit.diffview, { desc = 'View diff' } },

      -- misc bindings
      { 'C', TreeActions.copy_cursor_node_content, { desc = 'Copy file content' } },
      { '<C-C>', TreeActions.copy_cursor_node_path, { desc = 'Copy file path' } },
      { 'X', TreeActions.chmod_x, { desc = 'chmod +x' } },
    })
    :done()
end

--- Contains functions for configuring key bindings for nvimtree.
---
---@class NvimTree
local NvimTree = {}

--- Function that's called when gitsigns "attaches" to a buffer. Calls keymapping functions.
function NvimTree.on_attach(bufnr)
  local api = require 'nvim-tree.api'

  default_mappings(bufnr, api)
  remapped_defaults(bufnr, api)
  custom_mappings(bufnr, api)
end

return NvimTree
