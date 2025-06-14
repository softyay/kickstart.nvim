local PRIORITY = 1000
local TRANSPARENT_BKG = false

local SoftColorScheme = require 'custom.colors.SoftColorScheme'

-- Type is "Colors"
local wave = {}

local config_fn = function()
  wave = require('kanagawa.colors').setup { theme = 'wave' }
  require('kanagawa').setup {
    compile = false,
    undercurl = true,
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true },
    statementStyle = { bold = true },
    typeStyle = {},
    transparent = TRANSPARENT_BKG,
    dimInactive = false,
    terminalColors = false,
    colors = {
      theme = {
        wave = {
          ui = {
            -- NOTE: EDITOR BACKGROUND
            bg = wave.palette.sumiInk0,

            -- CURRENT LINE HIGHLIGHT
            bg_p2 = wave.palette.sumiInk4,

            -- VISUAL HIGHLIGHT
            bg_visual = wave.palette.winterRed,

            -- DEFAULT TEXT
            fg = wave.palette.fujiWhite,

            -- normal mode status bar TEXT and UNFOCUSED status bar bkg
            bg_m3 = wave.palette.dragonBlack2,

            -- UNKNOWN A
            special = wave.palette.dragonBlack5,

            -- UNKNOWN B
            bg_dim = 'yellow',

            -- STATUS BAR FILE TEXT FOCUSED
            fg_dim = wave.palette.oldWhite,
            -- STATUS BAR FILE BKG FOCUSED
            bg_p1 = wave.palette.dragonAsh,

            -- SEARCH TEXT
            fg_reverse = wave.palette.dragonBlack0,
            -- SEARCH BACKGROUND
            bg_search = wave.palette.waveBlue1,

            -- SIDE TEXT
            nontext = wave.palette.sumiInk6,

            -- SIDE BACKGROUND and NORMAL MODE STATUS BKG
            bg_gutter = wave.palette.sumiInk2,

            -- UNKNOWN C
            bg_m2 = 'cyan',
            -- UNKNOWN D
            bg_m1 = 'magenta',

            -- WHITESPACE
            whitespace = wave.palette.sumiInk6,

            -- AUTO COMPLETE
            pmenu = {
              fg = wave.palette.fujiWhite,
              fg_sel = 'none', -- This is important to make highlights pass-through
              bg = wave.palette.waveBlue1,
              bg_sel = wave.palette.waveBlue2,
              bg_sbar = wave.palette.waveBlue1,
              bg_thumb = wave.palette.waveBlue2,
            },

            -- Popup Windows (i.e. MiniFiles)
            float = {
              fg = wave.palette.oldWhite,
              bg = wave.palette.sumiInk0,
              fg_border = wave.palette.sumiInk6,
              bg_border = wave.palette.sumiInk0,
            },
          },
        },
      },
    },
    overrides = function(colors)
      return {
        Folded = { fg = wave.palette.dragonAsh, bg = wave.palette.sumiInk2 },
      }
    end,
    theme = 'wave',
    background = {
      dark = 'wave',
      light = 'lotus',
    },
  }
end

local get_name_to_set = function()
  return 'kanagawa'
end

-- A LazyPluginSpec (? i think ?)
local get_base_config_table = function()
  return {
    'rebelot/kanagawa.nvim',
    event = 'VimEnter',
    config = config_fn,
  }
end

local get_lualine_theme = function()
  local kana = require('kanagawa.colors').setup({ theme = 'wave' }).palette
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

local get_lualine_tab_colors = function()
  return {
    active = { bg = wave.palette.oldWhite, fg = wave.palette.dragonBlack2 },
    inactive = { bg = wave.palette.dragonBlack4, fg = wave.palette.dragonAsh },
  }
end

local get_indentline_rainbow = function()
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

-- stylua: ignore start
return SoftColorScheme.new(
  get_name_to_set(),
  get_base_config_table,
  get_lualine_theme,
  get_lualine_tab_colors,
  get_indentline_rainbow
)
-- stylua: ignore end

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
