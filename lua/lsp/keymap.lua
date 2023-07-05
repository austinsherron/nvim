local km = require 'nvim.lua.utils.mapper'


-- TODO: refactor KeyMapper so that it can be instantiated w/ the state present in this
--       function
local function options(desc, bufnr)
    return { desc = 'lsp: ' .. desc, buffer = bufnr }
end


local function global_mappings()
  km.nnoremap("'e", vim.diagnostic.open_float, options('open diagnostic hover'))
  km.nnoremap('[d', vim.diagnostic.goto_prev,  options('prev diagnostic'))
  km.nnoremap(']d', vim.diagnostic.goto_next,  options('next diagnostic'))
  km.nnoremap("'l", vim.diagnostic.setloclist, options('diagnostics list'))
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

  -- go to...
  km.nnoremap('gD', vim.lsp.buf.declaration,     options('jump to declaration', ev.buf))
  km.nnoremap('gd', vim.lsp.buf.definition,      options('jump to definition', ev.buf))
  km.nnoremap('gi', vim.lsp.buf.implementation,  options('jump to implementation', ev.buf))
  km.nnoremap('gr', vim.lsp.buf.references,      options('show references', ev.buf))
  km.nnoremap("gT", vim.lsp.buf.type_definition, options('type definition', ev.buf))

  -- semantic info
  km.nnoremap("'h", vim.lsp.buf.hover,          options('open hover', ev.buf))
  km.nnoremap("'S", vim.lsp.buf.signature_help, options('signature help', ev.buf))

  -- workspace manipulation
  km.nnoremap("'wa", vim.lsp.buf.add_workspace_folder,    options('add wkspce dir', ev.buf))
  km.nnoremap("'wr", vim.lsp.buf.remove_workspace_folder, options('rm wkspce dir', ev.buf))
  km.nnoremap("'wl", inspect_wkspace_dirs,                options('list wkspce dirs', ev.buf))

  -- do...
  km.nnoremap("'r",  vim.lsp.buf.rename,      options('rename', ev.buf))
  km.nnoremap("'f",  format,                  options('format', ev.buf))
  km.nnoremap("'ca", vim.lsp.buf.code_action, options('code action', ev.buf))
end


local function after_attach_autocmd()
  -- use LspAttach autocommand to only map the following keys after the language
  -- server attaches to the current buffer
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = after_attach_mappings
  })
end

local Lsp = {}

function Lsp.keymap()
  global_mappings()
  after_attach_autocmd()
end

return Lsp

