local km = require 'nvim.lua.utils.mapper'


-- interactions ----------------------------------------------------------------

km.nnoremap('<leader>ss', ':SessionManager save_current_session<cr>')
km.nnoremap('<leader>sl', ':SessionManager load_last_session<cr>')
km.nnoremap('<leader>sd', ':SessionManager load_current_dir_session<cr>')

