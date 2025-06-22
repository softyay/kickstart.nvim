local M = {}

M.PRIORITY = 999
M.TRANSPARENT_BKG = false

M.default_wave_palette = {}

M.config_table = {
  'rebelot/kanagawa.nvim',
  lazy = false,
  priority = M.PRIORITY, -- Make sure to load this before all the other start plugins.
  config = function()
    M.default_wave_palette = require('kanagawa.colors').setup({ theme = 'wave' }).palette
    require('kanagawa').setup {
      compile = false,
      undercurl = true,
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = M.TRANSPARENT_BKG,
      dimInactive = false,
      terminalColors = false,
      colors = {
        theme = {
          wave = {
            ui = {
              -- NOTE: EDITOR BACKGROUND
              bg = M.default_wave_palette.sumiInk0,

              -- CURRENT LINE HIGHLIGHT
              bg_p2 = M.default_wave_palette.sumiInk4,

              -- VISUAL HIGHLIGHT
              bg_visual = M.default_wave_palette.winterRed,

              -- DEFAULT TEXT
              fg = M.default_wave_palette.fujiWhite,

              -- normal mode status bar TEXT and UNFOCUSED status bar bkg
              bg_m3 = M.default_wave_palette.dragonBlack2,

              -- UNKNOWN A
              special = M.default_wave_palette.dragonBlack5,

              -- UNKNOWN B
              bg_dim = 'yellow',

              -- STATUS BAR FILE TEXT FOCUSED
              fg_dim = M.default_wave_palette.oldWhite,
              -- STATUS BAR FILE BKG FOCUSED
              bg_p1 = M.default_wave_palette.dragonAsh,

              -- SEARCH TEXT
              fg_reverse = M.default_wave_palette.dragonBlack0,
              -- SEARCH BACKGROUND
              bg_search = M.default_wave_palette.waveBlue1,

              -- SIDE TEXT
              nontext = M.default_wave_palette.sumiInk6,

              -- SIDE BACKGROUND and NORMAL MODE STATUS BKG
              bg_gutter = M.default_wave_palette.sumiInk2,

              -- UNKNOWN C
              bg_m2 = 'cyan',
              -- UNKNOWN D
              bg_m1 = 'magenta',

              -- WHITESPACE
              whitespace = M.default_wave_palette.sumiInk6,

              -- AUTO COMPLETE
              pmenu = {
                fg = M.default_wave_palette.fujiWhite,
                fg_sel = 'none', -- This is important to make highlights pass-through
                bg = M.default_wave_palette.waveBlue1,
                bg_sel = M.default_wave_palette.waveBlue2,
                bg_sbar = M.default_wave_palette.waveBlue1,
                bg_thumb = M.default_wave_palette.waveBlue2,
              },

              -- Popup Windows (i.e. MiniFiles)
              float = {
                fg = M.default_wave_palette.oldWhite,
                bg = M.default_wave_palette.sumiInk0,
                fg_border = M.default_wave_palette.sumiInk6,
                bg_border = M.default_wave_palette.sumiInk0,
              },
            },
          },
        },
      },
      overrides = function(colors)
        return {
          Folded = { fg = M.default_wave_palette.autumnYellow, bg = M.default_wave_palette.sumiInk2 },
        }
      end,
      theme = 'wave',
      background = {
        dark = 'wave',
        light = 'lotus',
      },
    }
    vim.cmd 'colorscheme kanagawa'
  end,
}

return M

-- NOTE: FOR REFERENCE
--
--[[
  ---@param palette PaletteColors
  ---@return ThemeColors
  wave = function(palette)
      return {
          ui = {
              fg         = palette.fujiWhite,
              fg_dim     = palette.oldWhite,
              fg_reverse = palette.waveBlue1,

              bg_dim     = palette.sumiInk1,
              bg_gutter  = palette.sumiInk4,

              bg_m3      = palette.sumiInk0,
              bg_m2      = palette.sumiInk1,
              bg_m1      = palette.sumiInk2,
              bg         = palette.sumiInk3,
              bg_p1      = palette.sumiInk4,
              bg_p2      = palette.sumiInk5,

              special    = palette.springViolet1,
              nontext    = palette.sumiInk6,
              whitespace = palette.sumiInk6,

              bg_search  = palette.waveBlue2,
              bg_visual  = palette.waveBlue1,

              pmenu      = {
                  fg       = palette.fujiWhite,
                  fg_sel   = "none", -- This is important to make highlights pass-through
                  bg       = palette.waveBlue1,
                  bg_sel   = palette.waveBlue2,
                  bg_sbar  = palette.waveBlue1,
                  bg_thumb = palette.waveBlue2,
              },
              float      = {
                  fg        = palette.oldWhite,
                  bg        = palette.sumiInk0,
                  fg_border = palette.sumiInk6,
                  bg_border = palette.sumiInk0,
              }
          },
          syn = {
              string     = palette.springGreen,
              variable   = "none",
              number     = palette.sakuraPink,
              constant   = palette.surimiOrange,
              identifier = palette.carpYellow,
              -- parameter  = "#C3B1B1",
              -- parameter  = "#B1ADC8",
              -- parameter  = "#b8b4d0",
              parameter  = palette.oniViolet2,
              -- parameter = "#d5a4a6",
              -- parameter  = "#C8ADAD",
              -- parameter  = "#d7a8a8",
              fun        = palette.crystalBlue,
              statement  = palette.oniViolet,
              keyword    = palette.oniViolet,
              operator   = palette.boatYellow2,
              preproc    = palette.waveRed, --lightBlue? deserves its own color
              type       = palette.waveAqua2,
              regex      = palette.boatYellow2,
              deprecated = palette.katanaGray,
              comment    = palette.fujiGray,
              punct      = palette.springViolet2,
              special1   = palette.springBlue,
              special2   = palette.waveRed,
              special3   = palette.peachRed,
          },
          vcs = {
              added   = palette.autumnGreen,
              removed = palette.autumnRed,
              changed = palette.autumnYellow,
          },
          diff = {
              add    = palette.winterGreen,
              delete = palette.winterRed,
              change = palette.winterBlue,
              text   = palette.winterYellow,
          },
          diag = {
              ok      = palette.springGreen,
              error   = palette.samuraiRed,
              warning = palette.roninYellow,
              info    = palette.dragonBlue,
              hint    = palette.waveAqua1,
          },
          term = {
              palette.sumiInk0, -- black
              palette.autumnRed, -- red
              palette.autumnGreen, -- green
              palette.boatYellow2, -- yellow
              palette.crystalBlue, -- blue
              palette.oniViolet, -- magenta
              palette.waveAqua1, -- cyan
              palette.oldWhite, -- white
              palette.fujiGray, -- bright black
              palette.samuraiRed, -- bright red
              palette.springGreen, -- bright green
              palette.carpYellow, -- bright yellow
              palette.springBlue, -- bright blue
              palette.springViolet1, -- bright magenta
              palette.waveAqua2, -- bright cyan
              palette.fujiWhite, -- bright white
              palette.surimiOrange, -- extended color 1
              palette.peachRed, -- extended color 2
          },
      }
  end,
--]]
