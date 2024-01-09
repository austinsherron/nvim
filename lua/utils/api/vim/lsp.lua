local LOGGER = GetLogger 'LSP'

--- Parameterizes lsp formatting.
---
---@class LspFormatOpts
---@field name string|nil: optional, defaults to all attached clients; specifies the lsp
--- server to use to format
---@field async boolean|nil: optional, defaults to false; if true, formatting will run
--- asynchronously
---@field bufnr integer|nil: optional, defaults to current buffer; the buffer to format

--- Api wrapper for lsp related vim functionality.
---
---@class Lsp
local Lsp = {}

--- Checks if the provided lsp server is active in buffer w/ id == bufnr.
---
---@param server string: the name of the lsp server to check
---@param bufnr integer: the id of the buffer to check
---@return boolean: true if the provided lsp server is active in buffer w/ id == bufnr,
--- false otherwise
function Lsp.isactive(server, bufnr)
  local lsp = vim.lsp.get_active_clients({
    name = server,
    bufnr = bufnr,
  })

  local isactive = Table.not_nil_or_empty(lsp)
  local is_or_not = ternary(isactive, '', 'not')

  LOGGER:trace('Server=%s is%s active in buffer=%s', { server, is_or_not, bufnr })
  return isactive
end

--- Formats the current buffer according to opts.
---
---@param opts LspFormatOpts|nil: optional; name specifies the lsp
--- server to use to format; async == true will cause formatting to run asynchronously
function Lsp.format(opts)
  opts = opts or {}

  LOGGER:debug('Running lsp formatting w/ opts=%s', { opts })
  Safe.call(vim.lsp.buf.format, { prefix = 'LSP' }, opts)
end

return Lsp
