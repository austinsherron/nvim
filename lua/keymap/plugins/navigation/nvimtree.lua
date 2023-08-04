local Leap   = require 'lua.keymap.plugins.motion.leap'
local NvTree = require 'lua.plugins.extensions.nvimtree'
local KM     = require 'lua.utils.core.mapper'


-- TODO: refactor KeyMapper so that it can be instantiated w/ the state present in this
--       function
local function options(desc, bufnr)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, silent = true, nowait = true }
end

-- interactions ----------------------------------------------------------------

KM.nnoremap('<leader>1',  ':NvimTreeToggle<CR>',    options('toggle'))
KM.nnoremap('<leader>F',  ':NvimTreeFindFile<CR>',  options('find file in tree'))
KM.nnoremap('<leader>F!', ':NvimTreeFindFile!<CR>', options('find file in tree!'))

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
  -- key mappings
  KM.nnoremap('<C-]>', api.tree.change_root_to_node,          options('CD', bufnr))
  KM.nnoremap('<C-e>', api.node.open.replace_tree_buffer,     options('Open: In Place', bufnr))
  KM.nnoremap('<C-k>', api.node.show_info_popup,              options('Info', bufnr))
  KM.nnoremap('<C-r>', api.fs.rename_sub,                     options('Rename: Omit Filename', bufnr))
  KM.nnoremap('<C-t>', api.node.open.tab,                     options('Open: New Tab', bufnr))
  KM.nnoremap('<C-v>', api.node.open.vertical,                options('Open: Vertical Split', bufnr))
  -- km.nnoremap('<C-x>', api.node.open.horizontal,              options('Open: Horizontal Split', bufnr))
  KM.nnoremap('<BS>',  api.node.navigate.parent_close,        options('Close Directory', bufnr))
  KM.nnoremap('<CR>',  api.node.open.edit,                    options('Open', bufnr))
  KM.nnoremap('<Tab>', api.node.open.preview,                 options('Open Preview', bufnr))
  KM.nnoremap('>',     api.node.navigate.sibling.next,        options('Next Sibling', bufnr))
  KM.nnoremap('<',     api.node.navigate.sibling.prev,        options('Previous Sibling', bufnr))
  KM.nnoremap('.',     api.node.run.cmd,                      options('Run Command', bufnr))
  -- KM.nnoremap('-',     api.tree.change_root_to_parent,        options('Up', bufnr))
  KM.nnoremap('a',     api.fs.create,                         options('Create', bufnr))
  KM.nnoremap('bd',    api.marks.bulk.delete,                 options('Delete Bookmarked', bufnr))
  KM.nnoremap('bmv',   api.marks.bulk.move,                   options('Move Bookmarked', bufnr))
  KM.nnoremap('B',     api.tree.toggle_no_buffer_filter,      options('Toggle No Buffer', bufnr))
  KM.nnoremap('c',     api.fs.copy.node,                      options('Copy', bufnr))
  KM.nnoremap('C',     api.tree.toggle_git_clean_filter,      options('Toggle Git Clean', bufnr))
  KM.nnoremap('[c',    api.node.navigate.git.prev,            options('Prev Git', bufnr))
  KM.nnoremap(']c',    api.node.navigate.git.next,            options('Next Git', bufnr))
  KM.nnoremap('d',     api.fs.remove,                         options('Delete', bufnr))
  KM.nnoremap('D',     api.fs.trash,                          options('Trash', bufnr))
  KM.nnoremap('E',     api.tree.expand_all,                   options('Expand All', bufnr))
  KM.nnoremap('e',     api.fs.rename_basename,                options('Rename: Basename', bufnr))
  KM.nnoremap(']e',    api.node.navigate.diagnostics.next,    options('Next Diagnostic', bufnr))
  KM.nnoremap('[e',    api.node.navigate.diagnostics.prev,    options('Prev Diagnostic', bufnr))
  KM.nnoremap('F',     api.live_filter.clear,                 options('Clean Filter', bufnr))
  KM.nnoremap('f',     api.live_filter.start,                 options('Filter', bufnr))
  KM.nnoremap('g?',    api.tree.toggle_help,                  options('Help', bufnr))
  KM.nnoremap('gy',    api.fs.copy.absolute_path,             options('Copy Absolute Path', bufnr))
  -- km.nnoremap('H',     api.tree.toggle_hidden_filter,         options('Toggle Dotfiles', bufnr))
  KM.nnoremap('<C-g>', api.tree.toggle_gitignore_filter,      options('Toggle Git Ignore', bufnr))
  KM.nnoremap('J',     api.node.navigate.sibling.last,        options('Last Sibling', bufnr))
  KM.nnoremap('K',     api.node.navigate.sibling.first,       options('First Sibling', bufnr))
  KM.nnoremap('m',     api.marks.toggle,                      options('Toggle Bookmark', bufnr))
  KM.nnoremap('o',     api.node.open.edit,                    options('Open', bufnr))
  KM.nnoremap('O',     api.node.open.no_window_picker,        options('Open: No Window Picker', bufnr))
  KM.nnoremap('p',     api.fs.paste,                          options('Paste', bufnr))
  KM.nnoremap('P',     api.node.navigate.parent,              options('Parent Directory', bufnr))
  -- km.nnoremap('q',     api.tree.close,                        options('Close', bufnr))
  KM.nnoremap('r',     api.fs.rename,                         options('Rename', bufnr))
  KM.nnoremap('R',     api.tree.reload,                       options('Refresh', bufnr))
  -- km.nnoremap('s',     api.node.run.system,                   options('Run System', bufnr))
  -- KM.nnoremap('S',     api.tree.search_node,                  options('Search', bufnr))
  -- km.nnoremap('U',     api.tree.toggle_custom_filter,         options('Toggle Hidden', bufnr))
  KM.nnoremap('W',     api.tree.collapse_all,                 options('Collapse', bufnr))
  KM.nnoremap('x',     api.fs.cut,                            options('Cut', bufnr))
  KM.nnoremap('y',     api.fs.copy.filename,                  options('Copy Name', bufnr))
  KM.nnoremap('Y',     api.fs.copy.relative_path,             options('Copy Relative Path', bufnr))

  -- mouse mappings (I explicitly disable the mouse in vim/nvim, so these are unused at this point)
  KM.nnoremap('<2-LeftMouse>',  api.node.open.edit,           options('Open', bufnr))
  KM.nnoremap('<2-RightMouse>', api.tree.change_root_to_node, options('CD', bufnr))
end


local function silent_open(node)
  NvTree:silent_open(node)
end


local function remapped_defaults(bufnr, api)
  KM.nnoremap('<C-h>', api.node.open.horizontal,      options('Open: Horizontal Split', bufnr))
  KM.nnoremap('I',     api.tree.toggle_hidden_filter, options('Toggle Dotfiles', bufnr))
  KM.nnoremap('<C-s>', silent_open,                   options('Open silently', bufnr))

  -- note: important to know that this is 'q' at the time of writing: we need to remove
  -- the 'q' default mapping above
  KM.nnoremap(Leap.bidirectional_leap_key(), Leap.bidirectional_leap, options('Leap', bufnr))
end


local function stage()
  NvTree:stage()
end


local function stage_all()
  NvTree:stage(true)
end


local function unstage()
  NvTree:unstage()
end


local function unstage_all()
  NvTree:unstage(true)
end


local function custom_mappings(bufnr, api)
  KM.nnoremap('l', api.node.open.edit,             options('Open', bufnr))
  KM.nnoremap('L', api.tree.change_root_to_node,   options('CD', bufnr))
  KM.nnoremap('h', api.node.navigate.parent_close, options('Close Directory', bufnr))
  KM.nnoremap('H', api.tree.change_root_to_parent, options('Up', bufnr))

  -- bindings for git ops
  KM.nnoremap('s', stage,       options('stage node', bufnr))
  -- remapped default, not in the remapped_defaults so it can be grouped w/ other git bindings
  KM.nnoremap('S', stage_all,   options('stage repo', bufnr))
  KM.nnoremap('u', unstage,     options('unstage node', bufnr))
  KM.nnoremap('U', unstage_all, options('unstage repo', bufnr))
end

--- Contains methods for configuring key bindings for nvimtree.
---
---@class NvimTree
local NvimTree = {}

--- Function that's called when gitsigns "attaches" to a buffer. Calls keymapping functions.
function NvimTree.on_attach(bufnr)
  local api = require('nvim-tree.api')

  default_mappings(bufnr, api)
  remapped_defaults(bufnr, api)
  custom_mappings(bufnr, api)
end

return NvimTree

