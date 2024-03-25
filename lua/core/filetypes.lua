local Path = require 'toolbox.system.path'

local ft = vim.filetype

local TMPL_EXT = '.tmpl'
local CHEZMOI_PFXS = { dot_ = '.', executable_ = '', external_ = '' }

local function remove_chezmoi_prefix(filename)
  local processed = filename

  for pfx, repl in pairs(CHEZMOI_PFXS) do
    if String.startswith(processed, pfx) then
      processed = String.replace(processed, pfx, repl, 1)
    end
  end

  return processed
end

local function remove_tmpl_suffix(filename)
  if String.endswith(filename, TMPL_EXT) then
    return Path.trim_extension(filename) or filename
  end

  return filename
end

local function check_for_ft_override(path, _)
  local filename = Path.basename(path)
  filename = remove_tmpl_suffix(filename)
  filename = remove_chezmoi_prefix(filename)

  return ft.match({ filename = filename })
end

ft.add({
  filename = {
    ['.chezmoiignore'] = 'gitignore',
  },
  pattern = {
    ['.*gitconfig.*'] = 'gitconfig',
    ['.*.tmpl'] = check_for_ft_override,
    ['dot_.*'] = check_for_ft_override,
    ['executable_.*'] = check_for_ft_override,
    ['external_.*'] = check_for_ft_override,
  },
})
