local M = {}

M.get_lualine_theme = function(palette)
  local kana = palette
  return {
    -- normal = {
    --   a = { bg = kana.springBlue, fg = kana.dragonBlack2 },
    --   b = { bg = kana.dragonBlack4, fg = kana.springBlue },
    --   c = { bg = kana.dragonAsh, fg = kana.dragonBlack4 },
    --   x = { bg = kana.dragonAsh, fg = kana.dragonBlack4 },
    --   y = { bg = kana.dragonBlack4, fg = kana.springBlue },
    --   z = { bg = kana.springBlue, fg = kana.dragonBlack2 },
    -- },
    normal = {
      a = { bg = kana.springBlue, fg = kana.dragonBlack2 },
      b = { bg = kana.dragonBlack4, fg = kana.springBlue },
      c = { bg = kana.dragonBlack2, fg = kana.dragonAsh },
      x = { bg = kana.dragonBlack2, fg = kana.dragonAsh },
      y = { bg = kana.dragonBlack4, fg = kana.dragonAsh },
      z = { bg = kana.dragonBlack5, fg = kana.dragonAsh },
    },
    insert = {
      a = { bg = kana.springGreen, fg = kana.dragonBlack2 },
      b = { bg = kana.dragonBlack4, fg = kana.springGreen },
      c = { bg = kana.dragonBlack2, fg = kana.dragonAsh },
      x = { bg = kana.dragonBlack2, fg = kana.dragonAsh },
      y = { bg = kana.dragonBlack4, fg = kana.dragonAsh },
      z = { bg = kana.dragonBlack5, fg = kana.dragonAsh },
    },
    visual = {
      a = { bg = kana.autumnRed, fg = kana.dragonBlack2 },
      b = { bg = kana.dragonBlack4, fg = kana.autumnRed },
      c = { bg = kana.dragonAsh, fg = kana.dragonBlack4 },
      x = { bg = kana.dragonAsh, fg = kana.dragonBlack4 },
      y = { bg = kana.dragonBlack4, fg = kana.springGreen },
      z = { bg = kana.springGreen, fg = kana.dragonBlack2 },
    },
    replace = {
      a = { bg = kana.oniViolet, fg = kana.dragonBlack2 },
      b = { bg = kana.dragonBlack4, fg = kana.oniViolet },
      c = { bg = kana.dragonAsh, fg = kana.dragonBlack4 },
      x = { bg = kana.dragonAsh, fg = kana.dragonBlack4 },
      y = { bg = kana.dragonBlack4, fg = kana.autumnRed },
      z = { bg = kana.autumnRed, fg = kana.dragonBlack2 },
    },
    command = {
      a = { bg = kana.roninYellow, fg = kana.dragonBlack2 },
      b = { bg = kana.dragonBlack4, fg = kana.roninYellow },
      c = { bg = kana.dragonAsh, fg = kana.dragonBlack4 },
      x = { bg = kana.dragonAsh, fg = kana.dragonBlack4 },
      y = { bg = kana.dragonBlack4, fg = kana.roninYellow },
      z = { bg = kana.roninYellow, fg = kana.dragonBlack2 },
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

return M
