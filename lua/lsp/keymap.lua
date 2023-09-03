local Autocmd   = require 'utils.core.autocmd'
local KeyMapper = require 'utils.core.mapper'


local KM = KeyMapper.new({ desc_prefix = 'lsp: ' })


local function global_mappings()
  KM:bind({
    { "'e", vim.diagnostic.open_float, { desc = 'open diagnostic hover' }},
    { '[d', vim.diagnostic.goto_prev,  { desc = 'prev diagnostic'       }},
    { ']d', vim.diagnostic.goto_next,  { desc = 'next diagnostic'       }},
    { "'l", vim.diagnostic.setloclist, { desc = 'diagnostics list'      }},
  })
end


local function inspect_wkspace_dirs()
  -- TODO: make this a bit more user friendly/prettier
  Info(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end


local function format()
  vim.lsp.buf.format({ async = true })
end


local function after_attach_mappings(ev)
  -- enable completion triggered by <c-x><c-o>
  vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

  KM:with({ buffer = ev.buf })
    :bind({
      -- find/go to...
      { 'gD', vim.lsp.buf.declaration,     { desc = 'jump to declaration'    }},
      { 'gd', vim.lsp.buf.definition,      { desc = 'jump to definition'     }},
      { 'gi', vim.lsp.buf.implementation,  { desc = 'jump to implementation' }},
      { 'gr', vim.lsp.buf.references,      { desc = 'show references'        }},
      { 'gT', vim.lsp.buf.type_definition, { desc = 'type definition'        }},
      -- semantic info
      { "'h", vim.lsp.buf.hover,          { desc = 'open hover'     }},
      { "'s", vim.lsp.buf.signature_help, { desc = 'signature help' }},
      -- workspace inspection/manipulation
      { "'wa", vim.lsp.buf.add_workspace_folder,    { desc = 'add wkspce dir'   }},
      { "'wr", vim.lsp.buf.remove_workspace_folder, { desc = 'rm wkspce dir'    }},
      { "'wl", inspect_wkspace_dirs,                { desc = 'list wkspce dirs' }},
      -- do...
      { "'r",  vim.lsp.buf.rename,      { desc = 'rename'      }},
      { "'f",  format,                  { desc = 'format'      }},
      { "'ca", vim.lsp.buf.code_action, { desc = 'code action' }},
  })
  :done()
end


local function after_attach_autocmd()
  -- use LspAttach autocommand to only map the following keys after the language
  -- server attaches to the current buffer

  Autocmd.new()
    :withDesc('Binds lsp keymap after the lsp actually attaches to the relevant buffer')
    :withEvent('LspAttach')
    :withGroup('UserLspConfig')
    :withCallback(after_attach_mappings)
    :create()
end

--- Contains methods for configuring key bindings for core LSP related functionality.
---
---@class LspKM
local LspKM = {}

--- Entry point for configuring key bindings for core LSP related functionality.
function LspKM.add_keymap()
  global_mappings()
  after_attach_autocmd()
end

return LspKM

