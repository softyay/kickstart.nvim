local core = require 'softLualine.core'
local lualine_ext = nil --require 'softKanagawa.extensions.lualine'

local style = 'round'

return {
  'nvim-lualine/lualine.nvim',
  -- event = 'VimEnter',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    -- require 'softKanagawa.spec',
  },
  priority = 10,
  config = function()
    local lualine = require 'lualine'
    core.cache_plugin(lualine)
    core.set_style(style)
    core.config_fn()
  end,
}
