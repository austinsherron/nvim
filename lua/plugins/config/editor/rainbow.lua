--- Contains functions for configuring the rainbow-delimiters plugin.
---
---@class Rainbow
local Rainbow = {}

--- Checks whether the given buffer has a usable treesitter parser. The
--- rainbow-delimiters plugin assumes that `vim.treesitter.get_parser` will
--- either return a parser or raise; in newer Neovim it can also return `nil`,
--- which crashes the plugin's `attach` function for filetypes whose parser
--- is not installed (e.g. `alpha`, `notify`).
---
---@param bufnr integer: the buffer to check
---@return boolean: true if a treesitter parser is available for the buffer
local function has_parser(bufnr)
  local ft = vim.bo[bufnr].filetype
  if ft == nil or ft == '' then
    return false
  end

  local lang = vim.treesitter.language.get_lang(ft)

  if not lang then
    return false
  end

  local ok, parser = pcall(vim.treesitter.get_parser, bufnr, lang)
  return ok and parser ~= nil
end

--- Configures the rainbow-delimiters plugin.
---
--- Installs a `condition` that short-circuits attachment for buffers without a treesitter
--- parser, working around an upstream nil-deref in `rainbow-delimiters/lib.lua`.
function Rainbow.config()
  vim.g.rainbow_delimiters =
    vim.tbl_extend('force', vim.g.rainbow_delimiters or {}, { condition = has_parser })
end

return Rainbow
