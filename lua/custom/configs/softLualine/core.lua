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
-- TODO:
-- FIX: Make sure that this is extracting properly. Use the
-- "colors" table and then the returned table to determine which highlights
-- to use in the theme definition.
M.get_default_theme = function()
  local auto_copy = require 'softLualine.auto_copy'
end

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

-- Default Component Tables
-- ============================================================================
M.component_mode = function(opts)
  return (opts == nil or opts.color == nil) and {
    'mode',
  } or {
    'mode',
    color = opts.color,
  }
end
M.component_diff = function(opts)
  return (opts == nil or opts.color == nil) and {
    'diff',
  } or {
    'diff',
    color = opts.color,
  }
end
M.component_branch = function(opts)
  return (opts == nil or opts.color == nil) and {
    'branch',
  } or {
    'branch',
    color = opts.color,
  }
end
M.component_filename = function(opts)
  return (opts == nil or opts.color == nil) and {
    'filename',
    fmt = M.trim_path_to_filename,
  } or {
    'filename',
    fmt = M.trim_path_to_filename,
    color = opts.color,
  }
end
M.component_filename_ext = function(opts)
  return (opts == nil or opts.color == nil) and {
    'filename',
  } or {
    'filename',
    color = opts.color,
  }
end
M.component_filetype = function(opts)
  return (opts == nil or opts.color == nil) and {
    'filetype',
  } or {
    'filetype',
    color = opts.color,
  }
end
M.component_progress = function(opts)
  return (opts == nil or opts.color == nil) and {
    'progress',
  } or {
    'progress',
    color = opts.color,
  }
end
M.component_location = function(opts)
  return (opts == nil or opts.color == nil) and {
    'location',
  } or {
    'location',
    color = opts.color,
  }
end
M.component_tabs = function(opts)
  return (opts == nil or opts.color == nil) and {
    'tabs',
    mode = 2,
  } or {
    'tabs',
    mode = 2,
    color = opts.color,
  }
end
M.component_windows = function(opts)
  return (opts == nil or opts.color == nil)
      and {
        'windows',
        use_mode_colors = true,
        -- windows_color = {
        --   active = tab_theme.active,
        --   inactive = tab_theme.inactive,
        -- },
      }
    or {
      'windows',
      use_mode_colors = true,
      -- windows_color = {
      --   active = tab_theme.active,
      --   inactive = tab_theme.inactive,
      -- },
      --color = opts.color,
    }
end
M.component_lsp_status = function(opts)
  return (opts == nil or opts.color == nil) and {
    'lsp_status',
  } or {
    'lsp_status',
    color = opts.color,
  }
end
M.component_diagnostics = function(opts)
  return (opts == nil or opts.color == nil) and {
    'diagnostics',
    always_visible = true,
  } or {
    'diagnostics',
    always_visible = true,
    color = opts.color,
  }
end
M.component_diagnostics_colorless = function(opts)
  return (opts == nil or opts.color == nil) and {
    'diagnostics',
    colored = false,
    always_visible = true,
  } or {
    'diagnostics',
    colored = false,
    always_visible = true,
    color = opts.color,
  }
end
-- ============================================================================

-- Default Section Tables
-- ============================================================================
M.section_mode = {
  M.component_mode {},
}
M.section_git = {
  M.component_branch {},
  M.component_diff {},
}
M.section_filename = {
  M.component_filename {},
}
M.section_filename_ext = {
  M.component_filename_ext {},
}
M.section_filetype = {
  M.standalone_separator_component(nil, 0),
  M.component_filetype {},
}
M.section_progress = {
  M.component_progress {},
}
M.section_cursor_pos = {
  M.component_location {},
}
M.section_tabs = {
  M.component_tabs {},
}
M.section_day = {
  {
    function()
      return ' '
    end,
  },
  {
    M.get_day,
  },
}
M.section_date = {
  {
    M.get_date,
  },
}
M.section_time = {
  {
    M.get_time,
  },
}
M.section_windows = {
  M.component_windows {},
}
M.section_lsp = {
  M.component_lsp_status {},
}
M.section_diagnostic = {
  M.component_diagnostics {},
}
M.section_diagnostic_colorless = {
  M.component_diagnostics_colorless {},
}
M.section_winbuf = {
  {
    M.win_num,
  },
  {
    M.buff_id,
  },
}
-- ============================================================================

-- with color
M.get_default_opts = function(visual_theme)
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
      lualine_a = M.section_mode,
      lualine_b = M.section_git,
      lualine_c = M.section_filename,
      lualine_x = M.section_filetype,
      lualine_y = M.section_progress,
      lualine_z = M.section_cursor_pos,
    },
    inactive_sections = {
      lualine_a = M.section_mode,
      lualine_b = M.section_git,
      lualine_c = M.section_filename,
      lualine_x = M.section_filetype,
      lualine_y = M.section_progress,
      lualine_z = M.section_cursor_pos,
    },
    tabline = {
      lualine_a = M.section_tabs,
      lualine_x = M.section_day,
      lualine_y = M.section_date,
      lualine_z = M.section_time,
    },
    winbar = {
      lualine_a = M.section_filename_ext,
      lualine_b = M.section_lsp,
      lualine_c = M.section_diagnostic,
      lualine_x = M.section_winbuf,
      lualine_y = M.section_progress,
      lualine_z = M.section_cursor_pos,
    },
    inactive_winbar = {
      lualine_a = M.section_filename,
      lualine_b = M.section_lsp,
      lualine_c = M.section_diagnostic_colorless,
      lualine_x = M.section_winbuf,
      -- lualine_y = M.section_progress,
      -- lualine_z = M.section_cursor_pos,
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
