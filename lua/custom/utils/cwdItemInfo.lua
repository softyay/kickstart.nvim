local M = {}

local element_head = function(index)
  return index .. '|  '
end

local dir_token = function(is_dir)
  return is_dir == 1 and '<dir> ' or ' '
end

local item_info = function(path, name)
  local result = {
    failbit = true,
    name = 'error: no name provided',
    is_dir = false,
    fullpath = 'error: no name provided',
  }

  if name == nil or name == '' then
    return result
  end

  name = name:gsub('\r', '')

  result.failbit = false
  result.name = name
  result.fullpath = path .. '\\' .. name
  print('assigning result shit: ', result.fullpath)
  result.is_dir = vim.fn.isdirectory(result.fullpath)

  return result
end

local print_data = function(verbosity, item_data)
  if verbosity == 'verbose' then
    print(element_head(item_data.index) .. dir_token(item_data.is_dir) .. item_data.name .. '\n' .. '\t' .. item_data.fullpath)
  elseif verbosity == 'partial' then
    print(element_head(item_data.index) .. dir_token(item_data.is_dir) .. item_data.fullpath)
  elseif verbosity == 'none' then
    print(element_head(item_data.index) .. dir_token(item_data.is_dir) .. item_data.name)
  end
end

local get_item_data = function(path)
  local result = {}

  for i, val in ipairs(vim.fn.systemlist('dir /b "' .. path .. '"')) do
    result[i] = item_info(path, val)
  end
  return result
end

M.get_directories = function(path)
  local result = {}
  local item_data = get_item_data(path)

  local new_index = 1
  for i, item in ipairs(item_data) do
    if (not item.failbit) and (item.is_dir == 1) then
      result[new_index] = item
      new_index = new_index + 1
    end
  end

  return result
end

M.get_files = function(path, type)
  local result = {}
  local item_data = get_item_data(path)

  local new_index = 1
  for i, item in ipairs(item_data) do
    if (not item.failbit) and (item.is_dir ~= 1) then
      if (type == nil) or (type == '') then
        result[new_index] = item
        new_index = new_index + 1
      elseif item.name:match '%.(.+)$' ~= nil then
        if item.name:match('%.(.+)$'):lower() == type:lower() then
          result[new_index] = item
          new_index = new_index + 1
        end
      end
    end
  end

  return result
end

M.print_item_data = function(path, verbosity)
  local item_datas = get_item_data(path)
  for i, item_data in ipairs(item_datas) do
    item_data.index = i
    print_data(verbosity, item_data)
  end
end

M.print_directories = function(path, verbosity)
  local dir_datas = M.get_directories(path)
  for i, dir_data in ipairs(dir_datas) do
    dir_data.index = i
    print_data(verbosity, dir_data)
  end
end

M.print_files = function(path, verbosity)
  local file_datas = M.get_files(path)
  for i, file_data in ipairs(file_datas) do
    file_data.index = i
    print_data(verbosity, file_data)
  end
end

return M
