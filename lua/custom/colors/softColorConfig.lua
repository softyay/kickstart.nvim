local M = {}
local SoftColorScheme = require 'custom.colors.SoftColorScheme'
local os = require 'custom.utils.osFinder'
local sep = os.get_path_separator()

-- Require Colorscheme configs
local kanagawa = require 'custom.colors.schemes.softKanagawa'

local default_scheme = SoftColorScheme.new('default', nil, nil, nil)

local schemes = {
  default_scheme,
  kanagawa,
}

local current_scheme_index = 1

local find_scheme_index = function(arg)
  if arg == nil then
    return nil
  end

  local arg_type = type(arg)
  for ind, scheme in ipairs(schemes) do
    if (arg_type == 'string') and arg == scheme.name then
      return ind
    elseif (arg_type == 'table') and (getmetatable(arg) == SoftColorScheme) and (scheme.name == arg.name) then
      return ind
    elseif arg == ind then
      return ind
    end
  end
  return nil
end

local is_in_schemes = function(to_check)
  for ind, scheme in ipairs(schemes) do
    if getmetatable(to_check) == SoftColorScheme then
      return to_check == scheme
    elseif to_check == scheme.name then
      return true
    end
  end
end

local find_scheme_index = function(arg)
  if not is_in_schemes(arg) then
    return nil
  else
    for ind, scheme in ipairs(schemes) do
      if getmetatable(arg) == SoftColorScheme then
        if arg == scheme or arg == scheme.name then
          return ind
        end
      end
    end
  end
end

local try_add_scheme = function(to_add, overwrite)
  if getmetatable(to_add) == SoftColorScheme then
    if is_in_schemes(to_add) == true then
      if overwrite == true then
        schemes[#schemes + 1] = to_add
        return true
      else
        return false
      end
    else
      schemes[#schemes + 1] = to_add
      return true
    end
  end
  return false
end

M.GetScheme = function()
  return schemes[current_scheme_index]
end

M.UpdateScheme = function()
  schemes[current_scheme_index].base_config_table.config()
  vim.cmd('colorscheme ' .. schemes[current_scheme_index].name)
end

M.SetScheme = function(arg)
  local index = find_scheme_index(arg)
  if index == nil then
    return
  end

  if schemes[index] then
    current_scheme_index = index
  elseif try_add_scheme(arg, false) then
    current_scheme_index = index
  end
  M.UpdateScheme()
end

M.NextScheme = function()
  current_scheme_index = current_scheme_index + 1
end

M.PrevScheme = function()
  current_scheme_index = current_scheme_index - 1
end

M.GetConfigTable = function()
  return {
    -- stylua: ignore
    dir = vim.fn.fnamemodify(vim.fn.expand '$MYVIMRC', ':p:h') .. sep ..
      'custom' .. sep .. 'colors' .. sep,
    priority = 1000,
    event = 'VimEnter',
    config = function()
      current_scheme_index = 1
      print(vim.inspect(schemes))
      print(vim.inspect(schemes[current_scheme_index]))
      print(M.GetScheme())
      vim.fn.input('in color config. Scheme: ' .. M.GetScheme().name .. '. Enter to continue')
      M.UpdateScheme()
    end,
  }
end

return M
