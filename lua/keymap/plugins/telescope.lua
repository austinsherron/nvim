local km = require 'nvim.lua.utils.core.mapper'
local tsc = require 'telescope.builtin'


-- TODO: refactor KeyMapper so that it can be instantiated w/ the state present in this
--       function
local function options(desc)
  return { desc = 'telescope: ' .. desc, nowait = true, silent = true }
end


-- interactions ----------------------------------------------------------------

km.nmap('<leader>ff', tsc.find_files,     options('search files'))
km.nmap('<leader>fg', tsc.live_grep,      options('grep in files'))
km.nmap('<leader>fb', tsc.buffers,        options('search buffers'))
km.nmap('<leader>fh', tsc.help_tags,      options('search help tags'))
km.nmap('<leader>fu', tsc.lsp_references, options('search lsp references'))

-- extensions ------------------------------------------------------------------

km.nnoremap('<leader>fc', '<cmd>Telescope aerial<CR>',   options('search code symbols'))
km.nnoremap('<leader>fe', '<cmd>Telescope emoji<CR>',    options('search emojis'))
km.nnoremap('<leader>fp', '<cmd>Telescope projects<CR>', options('search projects'))
km.nnoremap('<leader>fr', '<cmd>Telescope frecency<CR>', options('search "frecent"'))
km.nnoremap('<leader>fn', '<cmd>Telescope undo<CR>',     options('search undo history'))

