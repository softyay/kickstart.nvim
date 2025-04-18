-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
--

local PRIORITY = 999
local TRANSPARENT_BKG = false
local KANAGAWA_DARK_BLUE = '#16161D'
local KANAGAWA_SIDEBAR = '#27272e'
local KANAGAWA_SIDEBAR_SLIGHT = '#191920'

return {
  -- the colorscheme should be available when starting Neovim
  --[[
  {
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd.colorscheme 'tokyonight'
    end,
  },
  --]]
  {
    'rebelot/kanagawa.nvim',
    priority = PRIORITY, -- Make sure to load this before all the other start plugins.
    config = function()
      local df = require('kanagawa.colors').setup({ theme = 'wave' }).palette
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
        terminalColors = true,
        colors = {
          palette = {},
          theme = {
            wave = {
              ui = {
                -- normal text
                fg = df.fujiWhite,

                -- status bar text
                fg_dim = df.dragonAsh,

                -- Search text
                fg_reverse = df.dragonBlack0,
                -- Search background
                bg_search = df.waveBlue1,

                -- status bar file bg
                bg_dim = df.dragonBlack0,

                -- side bg
                bg_gutter = df.sumiInk2,

                -- normal mode text status bar & background between buffer windows??
                bg_m3 = df.dragonBlack4,

                -- ?
                bg_m2 = 'cyan',

                -- idk
                bg_m1 = 'magenta',

                -- NOTE: actual editor background
                bg = df.sumiInk0,

                -- statusbar right and left bg
                bg_p1 = df.dragonBlack2,

                -- current line highlight bg
                bg_p2 = df.sumiInk4,

                special = df.springViolet1,

                -- side nums
                nontext = df.sumiInk6,

                whitespace = df.sumiInk6,

                bg_visual = df.winterRed,

                pmenu = {
                  fg = df.fujiWhite,
                  fg_sel = 'none', -- This is important to make highlights pass-through
                  bg = df.waveBlue1,
                  bg_sel = df.waveBlue2,
                  bg_sbar = df.waveBlue1,
                  bg_thumb = df.waveBlue2,
                },

                float = {
                  fg = df.oldWhite,
                  bg = df.sumiInk0,
                  fg_border = df.sumiInk6,
                  bg_border = df.sumiInk1,
                },
              },
            },
          },
        },
        overrides = function(colors)
          local ts = require 'telescope'
          return {}
        end,
        theme = 'wave',
        background = {
          dark = 'wave',
          light = 'lotus',
        },
      }
      vim.cmd 'colorscheme kanagawa'
      -- vim.cmd('hi Normal guibg=' .. KANAGAWA_DARK_BLUE)
      -- vim.cmd('hi LineNr guibg=' .. KANAGAWA_SIDEBAR_SLIGHT)
      -- vim.cmd('hi SignColumn guibg=' .. KANAGAWA_SIDEBAR_SLIGHT)
      -- vim.cmd('hi FloatBorder guibg=' .. KANAGAWA_DARK_BLUE)
    end,
  },
  {
    'echasnovski/mini.files',
    config = function()
      local minifiles = require 'mini.files'
      minifiles.setup {
        -- Customization of shown content
        content = {
          -- Predicate for which file system entries to show
          filter = nil,
          -- What prefix to show to the left of file system entry
          prefix = nil,
          -- In which order to show file system entries
          sort = nil,
        },

        -- Module mappings created only inside explorer.
        -- Use `''` (empty string) to not create one.
        mappings = {
          close = 'q',
          go_in = 'l',
          go_in_plus = 'L',
          go_out = 'h',
          go_out_plus = 'H',
          mark_goto = "'",
          mark_set = 'm',
          reset = '<BS>',
          reveal_cwd = '@',
          show_help = 'g?',
          synchronize = '=',
          trim_left = '<',
          trim_right = '>',
        },

        -- General options
        options = {
          -- Whether to delete permanently or move into module-specific trash
          permanent_delete = true,
          -- Whether to use for editing directories
          use_as_default_explorer = true,
        },

        -- Customization of explorer windows
        windows = {
          -- Maximum number of windows to show side by side
          max_number = 3,
          -- Whether to show preview of file/directory under cursor
          preview = true,
          -- Width of focused window
          width_focus = 25,
          -- Width of non-focused window
          width_nofocus = 25,
          -- Width of preview window
          width_preview = 70,
        },
      }
      vim.keymap.set('n', '<leader>ec', function()
        minifiles.open(nil, false)
      end, { desc = 'File [e]xplore ([c]urrent dir)' })
      vim.keymap.set('n', '<leader>er', function()
        minifiles.open()
      end, { desc = 'File [e]xplore ([r]esume)' })
      vim.keymap.set('n', '<leader>ef', function()
        minifiles.open(vim.fn.getreg '%', false)
      end, { desc = 'File [e]xplore (this [f]ile)' })

      -- TODO: Make a keymap to find the current directory under the cursor
      -- possibly check for a git repo first.
      --
      -- vim.keymap.set('n', '<leader>es', function()
      --   minifiles.open(vim.fn.chdir(vim.fn.getreg '%'), false)
      -- end, { desc = '[S]et this as current dir' })
    end,
  },
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

  -- NOTE: Commenting all of this out for sanity, but it is copied
  -- directly from `:help lazy.nvim-🔌-plugin-spec`
  --
  -- -- I have a separate config.mappings file where I require which-key.
  -- -- With lazy the plugin will be automatically loaded when it is required somewhere
  -- { "folke/which-key.nvim", lazy = true },
  --
  -- {
  --   "nvim-neorg/neorg",
  --   -- lazy-load on filetype
  --   ft = "norg",
  --   -- options for neorg. This will automatically call `require("neorg").setup(opts)`
  --   opts = {
  --     load = {
  --       ["core.defaults"] = {},
  --     },
  --   },
  -- },
  --
  -- {
  --   "dstein64/vim-startuptime",
  --   -- lazy-load on a command
  --   cmd = "StartupTime",
  --   -- init is called during startup. Configuration for vim plugins typically should be set in an init function
  --   init = function()
  --     vim.g.startuptime_tries = 10
  --   end,
  -- },
  --
  -- {
  --   "hrsh7th/nvim-cmp",
  --   -- load cmp on InsertEnter
  --   event = "InsertEnter",
  --   -- these dependencies will only be loaded when cmp loads
  --   -- dependencies are always lazy-loaded unless specified otherwise
  --   dependencies = {
  --     "hrsh7th/cmp-nvim-lsp",
  --     "hrsh7th/cmp-buffer",
  --   },
  --   config = function()
  --     -- ...
  --   end,
  -- },
  --
  -- -- if some code requires a module from an unloaded plugin, it will be automatically loaded.
  -- -- So for api plugins like devicons, we can always set lazy=true
  -- { "nvim-tree/nvim-web-devicons", lazy = true },
  --
  -- -- you can use the VeryLazy event for things that can
  -- -- load later and are not important for the initial UI
  -- { "stevearc/dressing.nvim", event = "VeryLazy" },
  --
  -- {
  --   "Wansmer/treesj",
  --   keys = {
  --     { "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
  --   },
  --   opts = { use_default_keymaps = false, max_join_length = 150 },
  -- },
  --
  -- {
  --   "monaqa/dial.nvim",
  --   -- lazy-load on keys
  --   -- mode is `n` by default. For more advanced options, check the section on key mappings
  --   keys = { "<C-a>", { "<C-x>", mode = "n" } },
  -- },
  --
  -- -- local plugins need to be explicitly configured with dir
  -- { dir = "~/projects/secret.nvim" },
  --
  -- -- you can use a custom url to fetch a plugin
  -- { url = "git@github.com:folke/noice.nvim.git" },
  --
  -- -- local plugins can also be configured with the dev option.
  -- -- This will use {config.dev.path}/noice.nvim/ instead of fetching it from GitHub
  -- -- With the dev option, you can easily switch between the local and installed version of a plugin
  -- { "folke/noice.nvim", dev = true },
}
