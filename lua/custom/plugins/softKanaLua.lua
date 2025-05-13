local kana = require('kanagawa.colors').setup({ theme = 'wave' }).palette

-- local colors = {
--   fujiWhite = kana.fujiWhite,
--   oldWhite = kana.oldWhite,
--
--   dragonBlk0 = kana.dragonBlack0,
--   dragonBlk2 = kana.dragonBlack2,
--   dragonBlk5 = kana.dragonBlack5,
--
--   ash = kana.dragonAsh,
--
--   waveBlue1 = kana.waveBlue1,
--   waveBlue2 = kana.waveBlue2,
--
--   sumi0 = kana.sumiInk0,
--   sumi2 = kana.sumiInk2,
--   sumi4 = kana.sumiInk4,
--   sumi6 = kana.sumiInk6,
--
--   black = '#282828',
--   white = '#ebdbb2',
--   red = '#fb4934',
--   green = '#b8bb26',
--   blue = '#83a598',
--   yellow = '#fe8019',
--   gray = '#a89984',
--   darkgray = '#3c3836',
--   lightgray = '#504945',
--   inactivegray = '#7c6f64',
-- }

return {
  normal = {
    a = { bg = kana.waveBlue2, fg = kana.dragonBlack2, gui = 'bold' },
    b = { bg = kana.dragonBlack4, fg = kana.waveBlue2 },
    c = { bg = kana.dragonAsh, fg = kana.oldWhite },
  },
  insert = {
    a = { bg = kana.springGreen, fg = kana.dragonBlack2, gui = 'bold' },
    b = { bg = kana.dragonBlack4, fg = kana.springGreen },
    c = { bg = kana.dragonAsh, fg = kana.oldWhite },
  },
  visual = {
    a = { bg = kana.autumnRed, fg = kana.dragonBlack2, gui = 'bold' },
    b = { bg = kana.sumiInk2, fg = kana.autumnRed },
    c = { bg = kana.dragonAsh, fg = kana.oldWhite },
  },
  replace = {
    a = { bg = kana.oniViolet, fg = kana.dragonBlack2, gui = 'bold' },
    b = { bg = kana.sumiInk2, fg = kana.oniViolet },
    c = { bg = kana.dragonAsh, fg = kana.oldWhite },
  },
  command = {
    a = { bg = kana.roninYellow, fg = kana.dragonBlack2, gui = 'bold' },
    b = { bg = kana.sumiInk2, fg = kana.roninYellow },
    c = { bg = kana.dragonAsh, fg = kana.oldWhite },
  },
  inactive = {
    a = { bg = kana.dragonBlack0, fg = kana.dragonAsh, gui = 'italic' },
    b = { bg = kana.sumiInk2, fg = kana.waveBlue2 },
    c = { bg = kana.dragonBlack0, fg = kana.dragonAsh },
  },
}
