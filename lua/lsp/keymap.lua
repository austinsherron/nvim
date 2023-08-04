local KM = require 'lua.utils.core.mapper'

local create_autocmd = vim.api.nvim_create_autocmd
local create_augroup = vim.api.nvim_create_augroup


-- TODO: refactor KeyMapper so that it can be instantiated w/ the state present in this
--       function
local function options(desc, bufnr)
    return { desc = 'lsp: ' .. desc, buffer = bufnr }
end


local function global_mappings()
  KM.nnoremap("'e", vim.diagnostic.open_float, options('open diagnostic hover'))
  KM.nnoremap('[d', vim.diagnostic.goto_prev,  options('prev diagnostic'))
  KM.nnoremap(']d', vim.diagnostic.goto_next,  options('next diagnostic'))
  KM.nnoremap("'l", vim.diagnostic.setloclist, options('diagnostics list'))
end


local function inspect_wkspace_dirs()
  vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end


local function format()
  vim.lsp.buf.format({ async = true })
end


local function after_attach_mappings(ev)
  -- enable completion triggered by <c-x><c-o>
  vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

  -- find/go to...
  KM.nnoremap('gD', vim.lsp.buf.declaration,     options('jump to declaration', ev.buf))
  KM.nnoremap('gd', vim.lsp.buf.definition,      options('jump to definition', ev.buf))
  KM.nnoremap('gi', vim.lsp.buf.implementation,  options('jump to implementation', ev.buf))
  KM.nnoremap('gr', vim.lsp.buf.references,      options('show references', ev.buf))
  KM.nnoremap("gT", vim.lsp.buf.type_definition, options('type definition', ev.buf))

  -- semantic info
  KM.nnoremap("'h", vim.lsp.buf.hover,          options('open hover', ev.buf))
  KM.nnoremap("'s", vim.lsp.buf.signature_help, options('signature help', ev.buf))

  -- workspace manipulation
  KM.nnoremap("'wa", vim.lsp.buf.add_workspace_folder,    options('add wkspce dir', ev.buf))
  KM.nnoremap("'wr", vim.lsp.buf.remove_workspace_folder, options('rm wkspce dir', ev.buf))
  KM.nnoremap("'wl", inspect_wkspace_dirs,                options('list wkspce dirs', ev.buf))

  -- do...
  KM.nnoremap("'r",  vim.lsp.buf.rename,      options('rename', ev.buf))
  KM.nnoremap("'f",  format,                  options('format', ev.buf))
  KM.nnoremap("'ca", vim.lsp.buf.code_action, options('code action', ev.buf))
end


local function after_attach_autocmd()
  -- use LspAttach autocommand to only map the following keys after the language
  -- server attaches to the current buffer
  create_autocmd('LspAttach', {
    group    = create_augroup('UserLspConfig', {}),
    callback = after_attach_mappings
  })
end

--- Contains methods for configuring key bindings for core LSP related functionality.
---
---@class Lsp
local Lsp = {}

--- Entry point for configuring key bindings for core LSP related functionality.
function Lsp.keymap()
  global_mappings()
  after_attach_autocmd()
end

return Lsp

