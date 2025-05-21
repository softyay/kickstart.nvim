local kanagawa_theme_builder = require 'custom.utils.softKanaLua'
local lualine_theme = {}
local lualine_separator_style = 'round'
local standalone_separator_component = function(component_color, num_spaces)
  return {
    function()
      local str = ''
      for i in 1, num_spaces, 1 do
        str = str .. ' '
      end
      return str
    end,
    color = component_color,
    draw_empty = true,
  }
end

-- Local fns
-- ============================================================================
local win_num = function()
  return 'win: ' .. vim.api.nvim_get_current_win()
end

local buff_id = function()
  return 'buf: ' .. vim.api.nvim_get_current_buf()
end

local get_name_input = function()
  return vim.fn.input 'New tab name: '
end

local rename_wrapper = function(new_name)
  if vim.fn.exists ':LualineRename' == 1 then
    vim.cmd.LualineRename(new_name)
  end
end

local new_tab_wrapper = function(new_name)
  vim.cmd 'tabnew'
  rename_wrapper(new_name)
end

local invert = function(sep_table)
  return {
    left = sep_table.right,
    right = sep_table.left,
  }
end
-- ============================================================================

-- Separators
-- ============================================================================
-- stylua: ignore start
local section_sep = function(style)
  if      style == 'slash'      then return { left = '', right = '' }
  elseif  style == 'backslash'  then return { left = '', right = '' }
  elseif  style == 'round'      then return { left = '', right = '' }
  elseif  style == 'angled'     then return { left = '', right = '' }
  elseif  style == 'negative'   then return { left = '', right = '' }
  elseif  style == 'cut'        then return { left = '', right = '' }
  elseif  style == 'ice'        then return { left = '', right = '' }
  else -- default
    return { left = '', right = '' }
  end
end

local component_sep = function(style)
  if      style == 'slash'      then return { left = '', right = '' }
  elseif  style == 'backslash'  then return { left = '', right = '' }
  elseif  style == 'round'      then return { left = '', right = '' }
  elseif  style == 'angled'     then return { left = '', right = '' }
  elseif  style == 'negative'   then return { left = '', right = '' }
  elseif  style == 'neg-cut'    then return { left = '', right = '' }
  -- elseif  style == 'ice'        then return { left = '', right = '' }
  else -- default
    return { left = '', right = '' }
  end
end
-- stylua: ignore end
-- ============================================================================

-- Config function
-- ============================================================================
local config_fn = function()
  -- local kana = require('kanagawa.colors').setup({ 'wave' }).palette
  lualine_theme = kanagawa_theme_builder.get_lualine_theme {}

  require('lualine').setup {
    options = {
      theme = lualine_theme,
      icons_enabled = true,
      component_separators = component_sep(lualine_separator_style),
      section_separators = section_sep(lualine_separator_style),
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      always_show_tabline = true,
      globalstatus = false,
      refresh = {
        statusline = 100,
        tabline = 100,
        winbar = 100,
      },
    },
    sections = {
      lualine_a = {
        {
          'mode',
        },
      },
      lualine_b = {
        {
          'branch',
        },
        {
          'diff',
        },
      },
      lualine_c = {
        {
          'filename',
          fmt = function(str)
            return str:match '(.+)%..+$' or str
          end,
        },
      },
      lualine_x = {
        {
          'filetype',
        },
      },
      lualine_y = {
        {
          'progress',
        },
      },
      lualine_z = {
        {
          'location',
        },
      },
    },
    inactive_sections = {
      lualine_a = {
        {
          'mode',
        },
      },
      lualine_b = {
        {
          'branch',
        },
        {
          'diff',
        },
      },
      lualine_c = {
        {
          'filename',
          fmt = function(str)
            return str:match '(.+)%..+$' or str
          end,
        },
      },
      lualine_x = {
        standalone_separator_component(nil, 0),
        {
          'filetype',
        },
      },
      lualine_y = {
        {
          'progress',
        },
      },
      lualine_z = {
        {
          'location',
        },
      },
    },
    tabline = {
      lualine_a = {
        {
          'tabs',
          mode = 2,
          tabs_color = {
            active = kanagawa_theme_builder.get_tab_colors().active,
            inactive = kanagawa_theme_builder.get_tab_colors().inactive,
          },
        },
      },
      lualine_y = {
        {
          'windows',
          use_mode_colors = true,
          windows_color = {
            active = kanagawa_theme_builder.get_tab_colors().active,
            inactive = kanagawa_theme_builder.get_tab_colors().inactive,
          },
        },
      },
      lualine_z = {
        {
          'datetime',
          color = lualine_theme.inactive.c,
        },
      },
    },
    winbar = {
      lualine_a = {
        {
          'filename',
        },
      },
      lualine_b = {
        {
          'lsp_status',
        },
      },
      lualine_c = {
        {
          'diagnostics',
          always_visible = true,
        },
      },
      lualine_x = {
        {
          win_num,
        },
        {
          buff_id,
        },
      },
      lualine_y = {
        {
          'progress',
        },
      },
      lualine_z = {
        {
          'location',
        },
      },
    },
    inactive_winbar = {
      lualine_a = {
        {
          'filename',
        },
      },
      lualine_b = {
        {
          'lsp_status',
        },
      },
      lualine_c = {
        {
          'diagnostics',
          colored = false,
          always_visible = true,
        },
      },
      lualine_x = {
        {
          win_num,
        },
        {
          buff_id,
        },
      },
      lualine_y = {
        {
          'progress',
        },
      },
      lualine_z = {
        {
          'location',
        },
      },
    },
    extensions = {
      'fzf',
      'lazy',
      'nvim-dap-ui',
      'mason',
      'quickfix',
    },
  }

  -- New empty tab named to input from cmd
  vim.keymap.set('n', '<leader>bnn', function()
    local new_name = get_name_input()
    new_tab_wrapper(new_name)
  end, { desc = 'Ta[b] [n]ew with [n]ame' })

  -- Rename tab to input from cmd
  vim.keymap.set('n', '<leader>brn', function()
    local new_name = get_name_input()
    rename_wrapper(new_name)
  end, { desc = 'Ta[b] [r]e[n]ame' })

  local wk = require 'which-key'
  wk.add {
    { '<leader>b', group = 'Ta[b]s', mode = { 'n' } },
  }
end
-- ============================================================================

return {
  'nvim-lualine/lualine.nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    require 'custom.configs.softKanagawa',
  },
  config = config_fn,
}
