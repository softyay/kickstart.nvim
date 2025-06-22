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

return M
