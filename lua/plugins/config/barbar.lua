
local Bb = {}

function Bb.opts()
  return {
    -- visual
    animation = true,
    clickable = false,

    -- behavior
    focus_on_close = 'previous',
    no_name_title  = 'unnamed'
  }
end

return Bb

