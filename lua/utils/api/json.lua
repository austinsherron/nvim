
--- Nearly non-existent wrapper around nvim json api.
--
---@class Json
return {
  ---@see vim.json.decode
  decode = vim.json.decode,
  ---@see vim.json.encode
  encode = vim.json.encode,
}

