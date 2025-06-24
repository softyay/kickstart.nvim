local M = {}

local lualine = nil
local cache_count = 0

M.scheme_name = ''

local extension = nil
M.set_extension = function(ext)
  extension = ext
end

local colors = { 'none' }
M.get_colors = function()
  return colors
end
M.set_colors = function(colors_tbl)
  if type(colors_tbl) == 'table' then
    colors = colors_tbl
  end
end

local component_colors = { 'none' }
M.get_component_colors = function()
  return component_colors
end
M.set_component_colors = function(component_colors_tbl)
  if type(component_colors_tbl) == 'table' then
    component_colors = component_colors_tbl
  end
end

local style = 'none'
M.get_style = function()
  return style
end
M.set_style = function(style_str)
  if type(style_str) == 'string' then
    style = style_str
  end
end

M.apply_extension = function(config)
  if extension ~= nil and extension.colors ~= nil then
    colors = extension.colors
  end
  if extension ~= nil and extension.component_colors ~= nil then
    component_colors = extension.component_colors
  end
  if extension ~= nil and extension.style ~= nil then
    style = extension.style
  end

  if config == true then
    M.config_fn()
  end
end

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

-- Local fns | TODO:
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
local section_sep = function(style_selector)
  if      style_selector == 'slash'      then return { left = '', right = '' }
  elseif  style_selector == 'backslash'  then return { left = '', right = '' }
  elseif  style_selector == 'round'      then return { left = '', right = '' }
  elseif  style_selector == 'angled'     then return { left = '', right = '' }
  elseif  style_selector == 'negative'   then return { left = '', right = '' }
  elseif  style_selector == 'cut'        then return { left = '', right = '' }
  elseif  style_selector == 'ice'        then return { left = '', right = '' }
  else -- default
    return { left = '', right = '' }
  end
end

local component_sep = function(style_selector)
  if      style_selector == 'slash'      then return { left = '', right = '' }
  elseif  style_selector == 'backslash'  then return { left = '', right = '' }
  elseif  style_selector == 'round'      then return { left = '', right = '' }
  elseif  style_selector == 'angled'     then return { left = '', right = '' }
  elseif  style_selector == 'negative'   then return { left = '', right = '' }
  elseif  style_selector == 'neg-cut'    then return { left = '', right = '' }
  -- elseif  style_selector == 'ice'        then return { left = '', right = '' }
  else -- default
    return { left = '', right = '' }
  end
end
-- stylua: ignore end

M.sep_section = function()
  -- local msg = 'returning section separator for ' .. style .. '.'
  -- msg = msg .. '\n\t' .. 'separator: ' .. vim.inspect(section_sep(style))
  -- msg = msg .. '\n'
  -- print(msg)
  return section_sep(style)
end
M.sep_component = function()
  -- local msg = 'returning component separator for ' .. style .. '.'
  -- msg = msg .. '\n\t' .. 'separator: ' .. vim.inspect(component_sep(style))
  -- msg = msg .. '\n'
  -- print(msg)
  return component_sep(style)
end
-- ============================================================================

-- Default Component Tables
-- ============================================================================

M.component_mode = function()
  if component_colors.mode == nil then
    return {
      'mode',
      fmt = function(str)
        return string.lower(str)
      end,
    }
  else
    return {
      'mode',
      color = component_colors.mode,
    }
  end
end
M.component_diff = function()
  if component_colors.diff == nil then
    return {
      'diff',
    }
  else
    return {
      'diff',
      color = component_colors.diff,
    }
  end
end
M.component_branch = function()
  if component_colors.branch == nil then
    return {
      'branch',
    }
  else
    return {
      'branch',
      color = component_colors.branch,
    }
  end
end
M.component_filename = function()
  if component_colors.filename == nil then
    return {
      'filename',
      fmt = M.trim_path_to_filename,
    }
  else
    return {
      'filename',
      fmt = M.trim_path_to_filename,
      color = component_colors.filename,
    }
  end
end
M.component_filename_ext = function()
  if component_colors.filename_ext == nil then
    return {
      'filename',
    }
  else
    return {
      'filename',
      color = component_colors.filename_ext,
    }
  end
end
M.component_filetype = function()
  if component_colors.filetype == nil then
    return {
      'filetype',
    }
  else
    return {
      'filetype',
      color = component_colors.filetype,
    }
  end
end
M.component_progress = function()
  if component_colors.progress == nil then
    return {
      'progress',
    }
  else
    return {
      'progress',
      color = component_colors.progress,
    }
  end
end
M.component_location = function()
  if component_colors.location == nil then
    return {
      'location',
    }
  else
    return {
      'location',
      color = component_colors.location,
    }
  end
end
M.component_tabs = function()
  if component_colors.tabs == nil then
    return {
      'tabs',
      mode = 2,
      max_length = vim.o.columns * (4 / 5),
    }
  else
    return {
      'tabs',
      mode = 2,
      max_length = vim.o.columns * (4 / 5),
      tabs_color = component_colors.tabs,
    }
  end
end
M.component_windows = function()
  if component_colors.windows == nil then
    return {
      'windows',
      use_mode_colors = false,
    }
  else
    return {
      'windows',
      use_mode_colors = true,
      windows_color = component_colors.windows,
    }
  end
end
M.component_lsp_status = function()
  if component_colors.lsp_status == nil then
    return {
      'lsp_status',
    }
  else
    return {
      'lsp_status',
      color = component_colors.lsp_status,
    }
  end
end
M.component_diagnostics = function()
  if component_colors.diagnostics == nil then
    return {
      'diagnostics',
      always_visible = true,
    }
  else
    return {
      'diagnostics',
      always_visible = true,
      color = component_colors.diagnostics,
    }
  end
end
M.component_diagnostics_colorless = function()
  if component_colors.diagnostics_colorless == nil then
    return {
      'diagnostics',
      colored = false,
      always_visible = true,
    }
  else
    return {
      'diagnostics',
      colored = false,
      always_visible = true,
      color = component_colors.diagnostics_colorless,
    }
  end
end
M.component_day = function()
  if component_colors.day == nil then
    return {
      M.get_day,
      separator = { left = M.sep_section().right, right = '' },
    }
  else
    return {
      M.get_day,
      color = component_colors.day,
      separator = { left = M.sep_section().right, right = '' },
    }
  end
end
M.component_date = function()
  if component_colors.date == nil then
    return {
      M.get_date,
    }
  else
    return {
      M.get_date,
      color = component_colors.date,
    }
  end
end
M.component_time = function()
  if component_colors.time == nil then
    return {
      M.get_time,
    }
  else
    return {
      M.get_time,
      color = component_colors.time,
    }
  end
end

-- ============================================================================

-- Default Section Tables
-- ============================================================================

M.section_mode = function()
  return {
    M.component_mode(),
  }
end
M.section_git = function()
  return {
    M.component_branch(),
    M.component_diff(),
  }
end
M.section_filename = function()
  return {
    M.component_filename(),
  }
end
M.section_filename_ext = function()
  return {
    M.component_filename_ext(),
  }
end
M.section_filetype = function()
  return {
    M.standalone_separator_component(nil, 0),
    M.component_filetype(),
  }
end
M.section_progress = function()
  return {
    M.component_progress(),
  }
end
M.section_cursor_pos = function()
  return {
    M.component_location(),
  }
end
M.section_tabs = function()
  return {
    M.component_tabs(),
  }
end
M.section_day = function()
  return {
    -- {
    --   function()
    --     return '---'
    --   end,
    -- },
    M.component_day(),
  }
end
M.section_date = function()
  return {
    M.component_date(),
  }
end
M.section_time = function()
  return {
    M.component_time(),
  }
end
M.section_windows = function()
  return {
    M.component_windows(),
  }
end
M.section_lsp = function()
  return {
    M.component_lsp_status(),
  }
end
M.section_diagnostic = function()
  return {
    M.component_diagnostics(),
  }
end
M.section_diagnostic_colorless = function()
  return {
    M.component_diagnostics_colorless(),
  }
end
M.section_winbuf = function()
  return {
    {
      M.win_num,
    },
    {
      M.buff_id,
    },
  }
end

-- ============================================================================

-- Opts tables
-- ============================================================================
local opts_color = function()
  return {
    theme = colors,
    icons_enabled = true,
    component_separators = M.sep_component(),
    section_separators = M.sep_section(),
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
  }
end

local opts_colorless = function()
  return {
    icons_enabled = true,
    component_separators = M.sep_component(),
    section_separators = M.sep_section(),
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
  }
end

local opts = function()
  if colors[1] ~= nil then
    return opts_colorless()
  elseif colors[1] == 'none' then
    return opts_colorless()
  else
    return opts_color()
  end
end

-- ============================================================================

local setup_table = function()
  return {
    options = opts(),
    sections = {
      lualine_a = M.section_mode(),
      lualine_b = M.section_git(),
      lualine_c = M.section_filename(),
      lualine_x = M.section_filetype(),
      lualine_y = M.section_progress(),
      lualine_z = M.section_cursor_pos(),
    },
    inactive_sections = {
      lualine_a = M.section_mode(),
      lualine_b = M.section_git(),
      lualine_c = M.section_filename(),
      lualine_x = M.section_filetype(),
      lualine_y = M.section_progress(),
      lualine_z = M.section_cursor_pos(),
    },
    tabline = {
      lualine_a = M.section_tabs(),
      lualine_x = M.section_day(),
      lualine_y = M.section_date(),
      lualine_z = M.section_time(),
    },
    winbar = {
      lualine_a = M.section_filename_ext(),
      lualine_b = M.section_lsp(),
      lualine_c = M.section_diagnostic(),
      lualine_x = M.section_winbuf(),
      lualine_y = M.section_progress(),
      lualine_z = M.section_cursor_pos(),
    },
    inactive_winbar = {
      lualine_a = M.section_filename(),
      lualine_b = M.section_lsp(),
      lualine_c = M.section_diagnostic_colorless(),
      lualine_x = M.section_winbuf(),
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

M.config_fn = function()
  -- print '>> starting config fn...\n'
  if lualine == nil then
    print 'lualine was nil'
    return
  end

  local ext = require(M.scheme_name .. '.extension')
  M.set_extension(ext)
  M.apply_extension(false)
  -- print(vim.inspect(colors))
  lualine.setup(setup_table())

  -- New empty tab named to input from cmd
  vim.keymap.set('n', '<leader>bnn', function()
    local new_name = M.get_name_input()
    M.new_tab_wrapper(new_name)
  end, { desc = 'Ta[b] [n]ew with [n]ame' })

  -- Rename tab to input from cmd
  vim.keymap.set('n', '<leader>brn', function()
    local new_name = M.get_name_input()
    M.rename_wrapper(new_name)
  end, { desc = 'Ta[b] [r]e[n]ame' })

  local wk = require 'which-key'
  wk.add {
    { '<leader>b', group = 'Ta[b]s', mode = { 'n' } },
  }
  -- print '>> ending config fn\n'
end

M.cache_plugin = function(instance)
  lualine = instance
  cache_count = cache_count + 1
  -- print('lualine was cached. (Been cached ' .. cache_count .. ' times)')
end

return M
