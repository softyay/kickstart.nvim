local M = {}

M.standalone_separator_component = function(component_color, num_spaces)
  return {
    function()
      local str = ''
      for i = 1, num_spaces do
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
M.win_num = function()
  return 'win: ' .. vim.api.nvim_get_current_win()
end

M.buff_id = function()
  return 'buf: ' .. vim.api.nvim_get_current_buf()
end

M.get_name_input = function()
  return vim.fn.input 'New tab name: '
end

M.rename_wrapper = function(new_name)
  if vim.fn.exists ':LualineRename' == 1 then
    vim.cmd.LualineRename(new_name)
  end
end

M.new_tab_wrapper = function(new_name)
  vim.cmd 'tabnew'
  M.rename_wrapper(new_name)
end

M.invert = function(sep_table)
  return {
    left = sep_table.right,
    right = sep_table.left,
  }
end

M.trim_path_to_filename = function(path)
  return path:match '(.+)%..+$' or path
end

M.get_day = function()
  return os.date '%a'
end

M.get_date = function()
  return os.date '%b %d'
end

M.get_time = function()
  return os.date '%I:%M %p'
end
-- ============================================================================

-- Separators
-- ============================================================================
-- stylua: ignore start
M.section_sep = function(style)
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

M.component_sep = function(style)
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

-- with color
M.get_default_opts = function(visual_theme)
  local fuck = 'fuckdsafkjklsadf'
  return {
    options = {
      icons_enabled = true,
      component_separators = M.component_sep(visual_theme),
      section_separators = M.section_sep(visual_theme),
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
          fmt = M.trim_path_to_filename,
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
          fmt = M.trim_path_to_filename,
        },
      },
      lualine_x = {
        M.standalone_separator_component(nil, 0),
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
        },
      },
      lualine_x = {
        {
          function()
            return ' '
          end,
        },
        {
          M.get_day,
        },
      },
      lualine_y = {
        {
          M.get_date,
        },
        -- {
        --   'windows',
        --   use_mode_colors = true,
        --   windows_color = {
        --     active = tab_theme.active,
        --     inactive = tab_theme.inactive,
        --   },
        -- },
      },
      lualine_z = {
        {
          M.get_time,
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
          M.win_num,
        },
        {
          M.buff_id,
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
          M.win_num,
        },
        {
          M.buff_id,
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
end
return M
