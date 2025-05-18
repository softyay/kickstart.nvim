local M = {}

M.get_tab_colors = function()
  local kana = require('kanagawa.colors').setup({ 'wave' }).palette
  return {
    active = { bg = kana.oldWhite, fg = kana.dragonBlack2 },
    inactive = { bg = kana.dragonBlack4, fg = kana.dragonAsh },
  }
end

M.get_lualine_theme = function(palette)
  local kana = require('kanagawa.colors').setup({ 'wave' }).palette
  -- local kana = palette
  return {
    -- NOTE: this style with the ash in the center still looks cool as hell...
    -- just need to figure out how to make the tabline not need to obey it.
    --
    -- normal = {
    --   a = { bg = kana.springBlue, fg = kana.dragonBlack2 },
    --   b = { bg = kana.dragonBlack4, fg = kana.springBlue },
    --   c = { bg = kana.dragonAsh, fg = kana.dragonBlack4 },
    --   x = { bg = kana.dragonAsh, fg = kana.dragonBlack4 },
    --   y = { bg = kana.dragonBlack4, fg = kana.springBlue },
    --   z = { bg = kana.springBlue, fg = kana.dragonBlack2 },
    -- },
    -- command = {
    --   a = { bg = kana.roninYellow, fg = kana.dragonBlack2 },
    --   b = { bg = kana.dragonBlack4, fg = kana.roninYellow },
    --   c = { bg = kana.dragonAsh, fg = kana.dragonBlack4 },
    --   x = { bg = kana.dragonAsh, fg = kana.dragonBlack4 },
    --   y = { bg = kana.dragonBlack4, fg = kana.roninYellow },
    --   z = { bg = kana.roninYellow, fg = kana.dragonBlack2 },
    -- },
    normal = {
      a = { bg = kana.springBlue, fg = kana.dragonBlack2 },
      b = { bg = kana.dragonBlack4, fg = kana.springBlue },
      c = { bg = kana.dragonBlack2, fg = kana.springBlue },
      x = { bg = kana.dragonBlack2, fg = kana.dragonAsh },
      y = { bg = kana.dragonBlack4, fg = kana.springBlue },
      z = { bg = kana.dragonBlack5, fg = kana.springBlue },
    },
    insert = {
      a = { bg = kana.springGreen, fg = kana.dragonBlack2 },
      b = { bg = kana.dragonBlack4, fg = kana.springGreen },
      c = { bg = kana.dragonBlack2, fg = kana.springGreen },
      x = { bg = kana.dragonBlack2, fg = kana.dragonAsh },
      y = { bg = kana.dragonBlack4, fg = kana.springGreen },
      z = { bg = kana.dragonBlack5, fg = kana.springGreen },
    },
    visual = {
      a = { bg = kana.autumnRed, fg = kana.dragonBlack2 },
      b = { bg = kana.dragonBlack4, fg = kana.autumnRed },
      c = { bg = kana.dragonBlack2, fg = kana.autumnRed },
      x = { bg = kana.dragonBlack2, fg = kana.dragonAsh },
      y = { bg = kana.dragonBlack4, fg = kana.autumnRed },
      z = { bg = kana.dragonBlack5, fg = kana.autumnRed },
    },
    replace = {
      a = { bg = kana.oniViolet, fg = kana.dragonBlack2 },
      b = { bg = kana.dragonBlack4, fg = kana.oniViolet },
      c = { bg = kana.dragonBlack2, fg = kana.oniViolet },
      x = { bg = kana.dragonBlack2, fg = kana.dragonAsh },
      y = { bg = kana.dragonBlack4, fg = kana.oniViolet },
      z = { bg = kana.dragonBlack5, fg = kana.oniViolet },
    },
    command = {
      a = { bg = kana.roninYellow, fg = kana.dragonBlack2 },
      b = { bg = kana.dragonBlack4, fg = kana.roninYellow },
      c = { bg = kana.dragonBlack2, fg = kana.roninYellow },
      x = { bg = kana.dragonBlack2, fg = kana.dragonAsh },
      y = { bg = kana.dragonBlack4, fg = kana.roninYellow },
      z = { bg = kana.dragonBlack5, fg = kana.roninYellow },
    },
    terminal = {
      a = { bg = kana.fujiWhite, fg = kana.dragonBlack2 },
      b = { bg = kana.dragonBlack4, fg = kana.fujiWhite },
      c = { bg = kana.dragonBlack2, fg = kana.fujiWhite },
      x = { bg = kana.dragonBlack2, fg = kana.dragonAsh },
      y = { bg = kana.dragonBlack4, fg = kana.fujiWhite },
      z = { bg = kana.dragonBlack5, fg = kana.fujiWhite },
    },
    inactive = {
      a = { bg = kana.dragonBlack5, fg = kana.dragonAsh, gui = 'italic' },
      b = { bg = kana.dragonBlack4, fg = kana.dragonAsh, gui = 'italic' },
      c = { bg = kana.dragonBlack2, fg = kana.dragonAsh, gui = 'italic' },
      x = { bg = kana.dragonBlack2, fg = kana.dragonAsh, gui = 'italic' },
      y = { bg = kana.dragonBlack4, fg = kana.dragonAsh, gui = 'italic' },
      z = { bg = kana.dragonBlack5, fg = kana.dragonAsh, gui = 'italic' },
    },
  }
end

M.get_indentline_rainbow = function()
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
