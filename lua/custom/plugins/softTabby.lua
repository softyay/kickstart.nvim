-- NOTE: default tabby theme
local default_theme = {
  fill = 'TabLineFill', -- tabline background
  head = 'TabLine', -- head element highlight
  current_tab = 'TabLineSel', -- current tab label highlight
  tab = 'TabLine', -- other tab label highlight
  win = 'TabLine', -- window highlight
  tail = 'TabLine', -- tail element highlight
}

local lualine_theme = {}

-- FIX: This is a gd bonfire disaster from sleep deprivation.
-- Clean up when poss
local get_lualine_colors = function(vim_mode)
  local mode = vim.fn.mode()
  if lualine_theme == nil then
    return default_theme
  elseif mode == 'n' or mode == 'normal' then
    return lualine_theme.normal and lualine_theme.normal or default_theme
  elseif mode == 'i' or mode == 'insert' then
    return lualine_theme.insert and lualine_theme.insert or default_theme
  elseif mode == 'R' or mode == 'Rv' or mode == 'replace' then
    return lualine_theme.replace and lualine_theme.replace or default_theme
  elseif mode == 'c' then
    return lualine_theme.command and lualine_theme.command or default_theme
  else
    print('setting tabby to default theme with mode ' .. vim_mode)
    return default_theme
  end
end

local convert_to_tabby_theme = function(line_colors)
  if line_colors ~= default_theme then
    return {
      fill = line_colors.b,
      head = line_colors.a,
      current_tab = line_colors.a,
      tab = line_colors.b,
      win = line_colors.c,
      tail = line_colors.a,
    }
  end
  return default_theme
end

local setup_internal = function(tabby_theme)
  require('tabby').setup {
    preset = 'active_wins_at_tail',
    option = {
      theme = tabby_theme,
      nerdfont = true, -- whether use nerdfont
      lualine_theme = nil, -- lualine theme name
      tab_name = {
        name_fallback = function(tabid)
          return 'New Tab ' .. tabid
        end,
      },
      buf_name = {
        mode = 'tail',
      },
    },
  }
end

vim.api.nvim_create_autocmd('ModeChanged', {
  pattern = '*',
  callback = function()
    local mode_info = vim.api.nvim_get_mode()
    local prev_mode = vim.v.event.old_mode
    local new_mode = vim.v.event.new_mode

    local new_theme = convert_to_tabby_theme(get_lualine_colors(new_mode))
    setup_internal(new_theme)
    print('mode changed to ' .. new_mode)
  end,
})

return {
  'nanozuki/tabby.nvim',
  -- event = 'VimEnter', -- if you want lazy load, see below
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'nvim-lualine/lualine.nvim',
  },
  config = function()
    local lualine = require 'custom.plugins.softLualine'
    lualine_theme = lualine.lualine_theme
    local current_mode = vim.api.nvim_get_mode()
    local tabby_theme = convert_to_tabby_theme(get_lualine_colors(current_mode))
    setup_internal(tabby_theme)
    vim.cmd 'colorscheme kanagawa'
  end,
}
