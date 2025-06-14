local SoftColorScheme = {}
SoftColorScheme.__index = SoftColorScheme

function SoftColorScheme:Apply()
  local colorConfig = require 'custom.colors.softColorConfig'
  colorConfig.SetScheme(self)
end

local unnamed_schemes = 0

-- stylua: ignore start
function SoftColorScheme.new(
    name_to_set,
    get_base_config_table,
    get_lualine_theme,
    get_lualine_tab_colors,
    get_indentline_colors)
  local self = setmetatable({}, SoftColorScheme)
  local unnamed = name_to_set == nil or name_to_set == ''
  if unnamed then
    unnamed_schemes = unnamed_schemes + 1
  end
  self.name = (unnamed == false) and name_to_set or 'unnamed scheme ' .. unnamed_schemes
  self.base_config_table = get_base_config_table or function() return {} end
  self.lualine_theme = get_lualine_theme or function() return {} end
  self.lualine_tab_colors = get_lualine_tab_colors or function() return {} end
  self.indentline_colors = get_indentline_colors or function() return {} end
  return self
end
-- stylua: ignore end

return SoftColorScheme
