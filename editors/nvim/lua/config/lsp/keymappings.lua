local km = require 'nvim.lua.utils.mapper'


local function global_mappings()
  km.nnoremap('<leader>e', vim.diagnostic.open_float)
  km.nnoremap('[d', vim.diagnostic.goto_prev)
  km.nnoremap(']d', vim.diagnostic.goto_next)
  km.nnoremap('<leader>l', vim.diagnostic.setloclist)
end


local function inspect_wkspace_dirs()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end


local function format()
  vim.lsp.buf.format({ async = true })
end


local function after_attach_mappings(ev)
  -- enable completion triggered by <c-x><c-o>
  vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

  km.nnoremap('gD', vim.lsp.buf.declaration, ev.buf)
  km.nnoremap('gd', vim.lsp.buf.definition, ev.buf)
  km.nnoremap('K', vim.lsp.buf.hover, ev.buf)
  km.nnoremap('gi', vim.lsp.buf.implementation, ev.buf)
  km.nnoremap('<C-k>', vim.lsp.buf.signature_help, ev.buf)
  km.nnoremap('<leader>wa', vim.lsp.buf.add_workspace_folder, ev.buf)
  km.nnoremap('<leader>wr', vim.lsp.buf.remove_workspace_folder, ev.buf)
  km.nnoremap('<leader>wl', inspect_wkspace_dirs, ev.buf)
  km.nnoremap('<leader>D', vim.lsp.buf.type_definition, ev.buf)
  km.nnoremap('<leader>rn', vim.lsp.buf.rename, ev.buf)
  km.nnoremap('<leader>ca', vim.lsp.buf.code_action, ev.buf)
  km.vnoremap('<leader>ca', vim.lsp.buf.code_action, ev.buf)
  km.nnoremap('gr', vim.lsp.buf.references, ev.buf)
  km.nnoremap('<leader>f', format, ev.buf)
end


local function after_attach_autocmd()
  -- use LspAttach autocommand to only map the following keys after the language
  -- server attaches to the current buffer
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = after_attach_mappings
  })
end

function lsp_keymappings()
  global_mappings()
  after_attach_autocmd()
end

