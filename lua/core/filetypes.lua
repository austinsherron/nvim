local Path = require 'toolbox.system.path'

local ft = vim.filetype

local function get_tmpl_ft(path, _)
  local filename = Path.basename(path)
  return ft.match({ filename = Path.trim_extension(filename or path) })
end

ft.add({
  filename = {
    ['.chezmoiignore'] = 'gitignore',
  },
  pattern = {
    ['.*gitconfig'] = 'gitconfig',
    ['.*.tmpl'] = get_tmpl_ft,
  },
})
