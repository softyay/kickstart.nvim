local M = {}

M.get_rainbow = function()
  local kana = require('kanagawa.colors').setup({ 'wave' }).palette

  -- stylua: ignore start
  return {
    RainbowRed =    { fg = kana.winterRed     },
    RainbowYellow = { fg = kana.winterYellow  },
    RainbowBlue =   { fg = kana.winterBlue    },
    RainbowGreen =  { fg = kana.winterGreen   },
    RainbowOrange = { fg = kana.boatYellow1   },
    RainbowViolet = { fg = kana.sumiInk5      },
    RainbowCyan =   { fg = kana.waveBlue1     },
  }
  -- stylua: ignore end
end

return M
