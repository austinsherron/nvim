--- Thin wrapper around nvim json api.
---
---@class Json
local Json = {}

---@see vim.json.decode
function Json.decode(str)
  return vim.json.decode(str, { luanil = { array = true, object = true } })
end

---@see vim.json.encode
function Json.encode(obj)
  return vim.json.encode(obj)
end

return Json
