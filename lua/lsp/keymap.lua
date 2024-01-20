local KeyMapper = require 'utils.core.mapper'
local Lsp = require 'utils.api.vim.lsp'

local KM = KeyMapper.new({ desc_prefix = 'lsp: ' })

--- Contains methods for configuring key bindings for core LSP related functionality.
---
---@class LspKM
local LspKM = {}

local function global_mappings()
  KM:bind({
    { "'d", vim.diagnostic.open_float, { desc = 'open diagnostic hover' } },
    { '[d', Lsp.prev_diagnostic, { desc = 'prev diagnostic' } },
    { ']d', Lsp.next_diagnostic, { desc = 'next diagnostic' } },
    { "'l", vim.diagnostic.setloclist, { desc = 'diagnostics list' } },
  })
end

local function format()
  Lsp.format({ async = true })
end

local function inspect_workspace_folders()
  Lsp.get_workspace_folders(true)
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
      { "'I", Lsp.info, { desc = 'view lsp status' } },
      -- find/go to...
      { 'gD', vim.lsp.buf.declaration, { desc = 'jump to declaration' } },
      { 'gd', vim.lsp.buf.definition, { desc = 'jump to definition' } },
      { 'vd', Lsp.peek_definition, { desc = 'view definition' } },
      { 'gd', Lsp.goto_definition, { desc = 'jump to definition' } },
      { 'gi', vim.lsp.buf.implementation, { desc = 'jump to implementation' } },
      { 'gr', Lsp.finder, { desc = 'show references' } },
      { 'vT', Lsp.peek_type_definition, { desc = 'view declaration' } },
      { 'gT', Lsp.goto_type_definition, { desc = 'jump to declaration' } },
      { "'ci", Lsp.incoming_calls, { desc = 'view incoming calls' } },
      { "'co", Lsp.outgoing_calls, { desc = 'view outgoing calls' } },
      -- semantic info
      { "'h", Lsp.hover_doc, { desc = 'open hover' } },
      { "'s", vim.lsp.buf.signature_help, { desc = 'signature help' } },
      -- workspace inspection/manipulation
      { "'wa", vim.lsp.buf.add_workspace_folder, { desc = 'add workspace dir' } },
      { "'wr", vim.lsp.buf.remove_workspace_folder, { desc = 'rm workspace dir' } },
      { "'wl", inspect_workspace_folders, { desc = 'list workspace dirs' } },
      -- do...
      { "'r", Lsp.rename, { desc = 'rename' } },
      { "'R", Lsp.replace, { desc = 'replace' } },
      { "'f", format, { desc = 'format' } },
      { "'ca", Lsp.code_action, { desc = 'code action' } },
    })
    :done()
end

--- Entry point for configuring global lsp key bindings.
function LspKM.bind_globals()
  global_mappings()
end

return LspKM
