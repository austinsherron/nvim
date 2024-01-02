local Buffer = require 'utils.api.vim.buffer'

local Collectors = Stream.Collectors


--- Contains functions that implement extended (custom) functionality for the neorepl
--- plugin.
---
---@class NeoRepl
local NeoRepl = {}

local function buffer_filter(b)
  return Buffer.getoption(b, Buffer.Option.FILETYPE) == 'neorepl'
end


--- Closes the neorepl buffer and window.
function NeoRepl.close()
  local replbuf = Buffer.find({
    filter    = false,
    query     = buffer_filter,
    collector = Collectors.to_only(false)
  })

  if replbuf == nil then
    return
  end

  -- window closes automatically
  Buffer.close(replbuf)
end

return NeoRepl

