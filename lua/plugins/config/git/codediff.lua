--- Contains functions for configuring codediff.
---
---@class CodeDiff
local CodeDiff = {}

---@return table: a table that contains configuration values for the codediff plugin
function CodeDiff.opts()
  return {
    -- NOTE: line_stats/compute_moves are off by default because both add per-file
    -- work; set explorer.untracked = 'no' if large work trees stall the explorer
    diff = {
      layout = 'side-by-side',
      compact = true,
    },
    explorer = {
      view_mode = 'tree',
    },
    keymaps = {
      -- NOTE: these are lists so the ']f'/'[f' defaults stay bound alongside the
      -- tab keys; 'toggle_stage' is already '-' by default, set here to be explicit
      view = {
        next_file = { '<Tab>', ']f' },
        prev_file = { '<S-Tab>', '[f' },
        toggle_stage = '-',
      },
    },
  }
end

return CodeDiff
