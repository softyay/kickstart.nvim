local M = {}

local WINDOWS = {
  key = 'win',
  separator = '\\',
  info = 'Unspecified Windows version',
}
local UNIX = {
  key = 'unix',
  separator = '/',
  info = 'Unspecified Unix-based OS (Mac or Linux)',
}
local ERROR = {
  key = 'error',
  separator = nil,
  info = 'No Operating System found.',
}

M.RECOGNIZED_OPERATING_SYSTEMS = {
  WINDOWS,
  UNIX,
}

M.get_path_separator = function()
  return package.config:sub(1, 1)
end

M.get_operating_system = function()
  local path_sep = M.get_path_separator()
  local systems = M.RECOGNIZED_OPERATING_SYSTEMS

  for i = 1, #systems do
    if systems[i].separator == path_sep then
      return systems[i]
    end
  end

  return ERROR
end

return M
