return {
  'nanozuki/tabby.nvim',
  -- event = 'VimEnter', -- if you want lazy load, see below
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    -- configs...
    local tabby = require('tabby').setup {
      preset = 'active_tab_with_wins',
      nerdfont = true,
      buf_name = {
        mode = 'tail',
      },
    }
  end,
}
