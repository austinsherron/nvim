local km = require 'nvim.lua.utils.mapper'


-- interactions ----------------------------------------------------------------

km.nnoremap('<leader>1',  ':NvimTreeFocus<CR>')
km.nnoremap('<leader>t',  ':NvimTreeToggle<CR>')
km.nnoremap('<leader>F',  ':NvimTreeFindFile<CR>')
km.nnoremap('<leader>F!', ':NvimTreeFindFile!<CR>')

-- on_attach -------------------------------------------------------------------

--[[
    much of the code in this file from this point, or at least the underlying
    structure/logic of it, was automatically generated via :NvimTreeGenerateOnAttach

    see https://github.com/nvim-tree/nvim-tree.lua/wiki/Migrating-To-on_attac for details
--]]


local function options(desc, bufnr)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, silent = true, nowait = true }
end


--[[
    feel free to modify or remove as you wish (note from implementors of nvimtree),
    but (note from me, Austin) make sure to comment out the replaced mapping to keep
    a readily accessible record of the defaults
--]]
local function default_mappings(bufnr, api)
  km.nnoremap('<C-]>', api.tree.change_root_to_node,          options('CD', bufnr))
  km.nnoremap('<C-e>', api.node.open.replace_tree_buffer,     options('Open: In Place', bufnr))
  km.nnoremap('<C-k>', api.node.show_info_popup,              options('Info', bufnr))
  km.nnoremap('<C-r>', api.fs.rename_sub,                     options('Rename: Omit Filename', bufnr))
  km.nnoremap('<C-t>', api.node.open.tab,                     options('Open: New Tab', bufnr))
  km.nnoremap('<C-v>', api.node.open.vertical,                options('Open: Vertical Split', bufnr))
  km.nnoremap('<C-x>', api.node.open.horizontal,              options('Open: Horizontal Split', bufnr))
  km.nnoremap('<BS>',  api.node.navigate.parent_close,        options('Close Directory', bufnr))
  km.nnoremap('<CR>',  api.node.open.edit,                    options('Open', bufnr))
  km.nnoremap('<Tab>', api.node.open.preview,                 options('Open Preview', bufnr))
  km.nnoremap('>',     api.node.navigate.sibling.next,        options('Next Sibling', bufnr))
  km.nnoremap('<',     api.node.navigate.sibling.prev,        options('Previous Sibling', bufnr))
  km.nnoremap('.',     api.node.run.cmd,                      options('Run Command', bufnr))
  km.nnoremap('-',     api.tree.change_root_to_parent,        options('Up', bufnr))
  km.nnoremap('a',     api.fs.create,                         options('Create', bufnr))
  km.nnoremap('bd',    api.marks.bulk.delete,                 options('Delete Bookmarked', bufnr))
  km.nnoremap('bmv',   api.marks.bulk.move,                   options('Move Bookmarked', bufnr))
  km.nnoremap('B',     api.tree.toggle_no_buffer_filter,      options('Toggle No Buffer', bufnr))
  km.nnoremap('c',     api.fs.copy.node,                      options('Copy', bufnr))
  km.nnoremap('C',     api.tree.toggle_git_clean_filter,      options('Toggle Git Clean', bufnr))
  km.nnoremap('[c',    api.node.navigate.git.prev,            options('Prev Git', bufnr))
  km.nnoremap(']c',    api.node.navigate.git.next,            options('Next Git', bufnr))
  km.nnoremap('d',     api.fs.remove,                         options('Delete', bufnr))
  km.nnoremap('D',     api.fs.trash,                          options('Trash', bufnr))
  km.nnoremap('E',     api.tree.expand_all,                   options('Expand All', bufnr))
  km.nnoremap('e',     api.fs.rename_basename,                options('Rename: Basename', bufnr))
  km.nnoremap(']e',    api.node.navigate.diagnostics.next,    options('Next Diagnostic', bufnr))
  km.nnoremap('[e',    api.node.navigate.diagnostics.prev,    options('Prev Diagnostic', bufnr))
  km.nnoremap('F',     api.live_filter.clear,                 options('Clean Filter', bufnr))
  km.nnoremap('f',     api.live_filter.start,                 options('Filter', bufnr))
  km.nnoremap('g?',    api.tree.toggle_help,                  options('Help', bufnr))
  km.nnoremap('gy',    api.fs.copy.absolute_path,             options('Copy Absolute Path', bufnr))
  -- km.nnoremap('H',     api.tree.toggle_hidden_filter,         options('Toggle Dotfiles', bufnr))
  km.nnoremap('<C-g>', api.tree.toggle_gitignore_filter,      options('Toggle Git Ignore', bufnr))
  km.nnoremap('J',     api.node.navigate.sibling.last,        options('Last Sibling', bufnr))
  km.nnoremap('K',     api.node.navigate.sibling.first,       options('First Sibling', bufnr))
  km.nnoremap('m',     api.marks.toggle,                      options('Toggle Bookmark', bufnr))
  km.nnoremap('o',     api.node.open.edit,                    options('Open', bufnr))
  km.nnoremap('O',     api.node.open.no_window_picker,        options('Open: No Window Picker', bufnr))
  km.nnoremap('p',     api.fs.paste,                          options('Paste', bufnr))
  km.nnoremap('P',     api.node.navigate.parent,              options('Parent Directory', bufnr))
  km.nnoremap('q',     api.tree.close,                        options('Close', bufnr))
  km.nnoremap('r',     api.fs.rename,                         options('Rename', bufnr))
  km.nnoremap('R',     api.tree.reload,                       options('Refresh', bufnr))
  km.nnoremap('s',     api.node.run.system,                   options('Run System', bufnr))
  km.nnoremap('S',     api.tree.search_node,                  options('Search', bufnr))
  -- km.nnoremap('U',     api.tree.toggle_custom_filter,         options('Toggle Hidden', bufnr))
  km.nnoremap('W',     api.tree.collapse_all,                 options('Collapse', bufnr))
  km.nnoremap('x',     api.fs.cut,                            options('Cut', bufnr))
  km.nnoremap('y',     api.fs.copy.filename,                  options('Copy Name', bufnr))
  km.nnoremap('Y',     api.fs.copy.relative_path,             options('Copy Relative Path', bufnr))

  km.nnoremap('<2-LeftMouse>',  api.node.open.edit,           options('Open', bufnr))
  km.nnoremap('<2-RightMouse>', api.tree.change_root_to_node, options('CD', bufnr))
end


local function remapped_defaults(bufnr, api)
  km.nnoremap('I', api.tree.toggle_hidden_filter, options('Toggle Dotfiles', bufnr))
end


local function custom_mappings(bufnr, api)
  km.nnoremap('l', api.node.open.edit,             options('Open', bufnr))
  km.nnoremap('L', api.tree.change_root_to_node,   options('CD', bufnr))
  km.nnoremap('h', api.node.navigate.parent_close, options('Close Directory', bufnr))
  km.nnoremap('H', api.tree.change_root_to_parent, options('Up', bufnr))
end


local function on_attach(bufnr)
  local api = require('nvim-tree.api')

  default_mappings(bufnr, api)
  remapped_defaults(bufnr, api)
  custom_mappings(bufnr, api)
end


return {
  on_attach = on_attach,
}

