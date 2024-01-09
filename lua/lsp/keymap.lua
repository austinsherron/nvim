local KeyMapper = require 'utils.core.mapper'
local Lsp = require 'utils.api.vim.lsp'

local KM = KeyMapper.new({ desc_prefix = 'lsp: ' })

--- Contains methods for configuring key bindings for core LSP related functionality.
---
---@class LspKM
local LspKM = {}

local function lspsaga(cmd)
  return fmt(':Lspsaga %s<CR>', cmd)
end

local function global_mappings()
  KM:bind({
    { "'e", vim.diagnostic.open_float, { desc = 'open diagnostic hover' } },
    { '[d', ':Lspsaga diagnostic_jump_prev<CR>', { desc = 'prev diagnostic' } },
    { ']d', ':Lspsaga diagnostic_jump_next<CR>', { desc = 'next diagnostic' } },
    { "'l", vim.diagnostic.setloclist, { desc = 'diagnostics list' } },
  })
end

local function inspect_wkspace_dirs()
  -- TODO: make this a bit more user friendly/prettier
  Notify.info(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end

local function format()
  Lsp.format({ async = true })
end

---Entry point for configuring lsp key bindings that should be added only after a
---language server attaches to a buffer. Intended to be used w/ an autocommand that uses
---the LspAttach event.
---
---@param bufnr integer: the buffer to which to add key bindings
function LspKM.bind_after_attach(bufnr)
  KM:with({ buffer = bufnr })
    :bind({
      -- info/inspect
      { "'i", ':LspInfo<CR>', { desc = 'view lsp status' } },
      -- find/go to...
      { 'gD', vim.lsp.buf.declaration, { desc = 'jump to declaration' } },
      { 'gd', vim.lsp.buf.definition, { desc = 'jump to definition' } },
      { 'vd', lspsaga 'peek_definition', { desc = 'view definition' } },
      { 'gd', lspsaga 'goto_definition', { desc = 'jump to definition' } },
      { 'gi', vim.lsp.buf.implementation, { desc = 'jump to implementation' } },
      { 'gr', lspsaga 'finder', { desc = 'show references' } },
      { 'vT', lspsaga 'peek_type_definition', { desc = 'view declaration' } },
      { 'gT', lspsaga 'goto_type_definition', { desc = 'jump to declaration' } },
      { "'ci", lspsaga 'incoming_calls', { desc = 'view incoming calls' } },
      { "'co", lspsaga 'outgoing_calls', { desc = 'view outgoing calls' } },
      -- semantic info
      { "'h", lspsaga 'hover_doc', { desc = 'open hover' } },
      { "'s", vim.lsp.buf.signature_help, { desc = 'signature help' } },
      -- workspace inspection/manipulation
      { "'wa", vim.lsp.buf.add_workspace_folder, { desc = 'add wkspce dir' } },
      { "'wr", vim.lsp.buf.remove_workspace_folder, { desc = 'rm wkspce dir' } },
      { "'wl", inspect_wkspace_dirs, { desc = 'list wkspce dirs' } },
      -- do...
      { "'r", ':Lspsaga rename<CR>', { desc = 'rename' } },
      -- TODO: implement w/ popup for args
      -- { "'R",  ':Lspsaga project_replace<CR>', { desc = 'replace'     }},
      { "'f", format, { desc = 'format' } },
      { "'ca", lspsaga 'code_action', { desc = 'code action' } },
    })
    :done()
end

--- Entry point for configuring global lsp key bindings.
function LspKM.bind_globals()
  global_mappings()
end

return LspKM
