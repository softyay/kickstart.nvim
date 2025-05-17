-- Main File for wrangling custom configs for plugins

local softKanagawa = require 'custom.configs.softKanagawa'
local softMiniFile = require 'custom.configs.softMiniFile'
local softLuaLine = require 'custom.configs.softLualine'
local softInlineDiag = require 'custom.configs.softInlineDiag'
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
  { softKanagawa },
  { softInlineDiag.config_table },
  { softMiniFile },
  { softLuaLine },

  -- -- you can use the VeryLazy event for things that can
  -- -- load later and are not important for the initial UI
  -- { "stevearc/dressing.nvim", event = "VeryLazy" },
  --
  -- -- local plugins need to be explicitly configured with dir
  -- { dir = "~/projects/secret.nvim" },
  --
  -- -- local plugins can also be configured with the dev option.
  -- -- This will use {config.dev.path}/noice.nvim/ instead of fetching it from GitHub
  -- -- With the dev option, you can easily switch between the local and installed version of a plugin
  -- { "folke/noice.nvim", dev = true },
}
