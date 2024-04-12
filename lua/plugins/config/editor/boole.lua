--- Contains functions for configuring the boole plugin.
---
---@class Boole
local Boole = {}

---@return table: a table that contains configuration values for the boole plugin
function Boole.opts()
  return {
    mappings = {
      increment = '<C-a>',
      decrement = '<C-x>',
    },
    additions = {
      -- alphabet
      {
        'a',
        'b',
        'c',
        'd',
        'e',
        'f',
        'g',
        'h',
        'i',
        'j',
        'k',
        'l',
        'm',
        'n',
        'o',
        'p',
        'q',
        'r',
        's',
        't',
        'u',
        'v',
        'w',
        'x',
        'y',
        'z',
      },
      {
        'A',
        'B',
        'C',
        'D',
        'E',
        'F',
        'G',
        'H',
        'I',
        'J',
        'K',
        'L',
        'M',
        'N',
        'O',
        'P',
        'Q',
        'R',
        'S',
        'T',
        'U',
        'V',
        'W',
        'X',
        'Y',
        'Z',
      },
      -- days
      { 'sun', 'mon', 'tues', 'wed', 'thu', 'fri', 'sat' },
      { 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday' },
      -- months
      {
        'jan',
        'feb',
        'mar',
        'apr',
        'may',
        'jun',
        'jul',
        'aug',
        'sept',
        'oct',
        'nov',
        'dec',
      },
      {
        'January',
        'February',
        'March',
        'April',
        'May',
        'Jun',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December',
      },
      -- log levels
      { 'TRACE', 'DEBUG', 'INFO', 'WARN', 'ERROR', 'OFF' },
      { 'trace', 'debug', 'info', 'warn', 'error' },
      -- conditional keywords
      { 'if', 'elseif', 'elif', 'else' },
      -- boolean operators
      { 'and', 'or', 'not' },
      { 'pairs', 'ipairs' },
      -- aws regions: us
      { 'us-west-1', 'us-west-2', 'us-east-1', 'us-east-2' },
    },
  }
end

return Boole
