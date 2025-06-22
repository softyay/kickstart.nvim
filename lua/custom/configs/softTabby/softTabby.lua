-- NOTE: default tabby theme
local default_theme = {
  fill = 'TabLineFill', -- tabline background
  head = 'TabLine', -- head element highlight
  current_tab = 'TabLineSel', -- current tab label highlight
  tab = 'TabLine', -- other tab label highlight
  win = 'TabLine', -- window highlight
  tail = 'TabLine', -- tail element highlight
}

local log = '[TabbyLog]: // '

local lualine_theme = default_theme

-- FIX: This is a gd bonfire disaster from sleep deprivation.
-- Clean up when poss
local get_lualine_colors = function(vim_mode)
  local mode = vim.fn.mode()
  if lualine_theme == nil then
    log = log .. 'no lualine theme // '
    return default_theme
  elseif mode == 'n' or mode == 'normal' then
    if lualine_theme.normal then
      log = log .. 'found normal colors // '
      return lualine_theme.normal
    end
  elseif mode == 'i' or mode == 'insert' then
    if lualine_theme.insert then
      log = log .. 'found insert colors // '
      return lualine_theme.insert
    end
  elseif mode == 'R' or mode == 'Rv' or mode == 'replace' then
    if lualine_theme.replace then
      log = log .. 'found replace colors // '
      return lualine_theme.replace
    end
  elseif mode == 'c' then
    if lualine_theme.command then
      log = log .. 'found command colors // '
      return lualine_theme.command
    end
  end

  log = log .. 'no colors for [' .. vim_mode .. '], set def // '
  return default_theme
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
  else
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
    local prev_mode = vim.v.event.old_mode
    local new_mode = vim.v.event.new_mode

    local new_theme = convert_to_tabby_theme(get_lualine_colors(new_mode))
    setup_internal(new_theme)
    print(log)
    log = '[TabbyLog]: // '
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
    local ll_colors = get_lualine_colors(current_mode)
    local theme = convert_to_tabby_theme(ll_colors)
    setup_internal(theme)
    vim.cmd 'colorscheme kanagawa'
  end,
}
