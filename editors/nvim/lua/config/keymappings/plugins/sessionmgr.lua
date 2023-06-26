local km = require 'nvim.lua.utils.mapper'


-- interactions ----------------------------------------------------------------

km.nnoremap('<leader>ss', ':SessionManager save_current_session<CR>')
km.nnoremap('<leader>sl', ':SessionManager load_last_session<CR>')
km.nnoremap('<leader>sd', ':SessionManager load_current_dir_session<CR>')

