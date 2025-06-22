-- Filter class
-- ============================================================================
local Filter = {
  name = 'Unnamed Filter',
  enabled = false,
  should_show_entry = function(entry)
    return true
  end,
  show_toggle_messages = true,
  show_debug_messages = true,
}
Filter.__index = Filter

local filter_calls = 0

function Filter:toggle()
  self.enabled = not self.enabled
  if self.show_toggle_messages then
    local result = self.enabled and 'on' or 'off'
    print(self.name .. ' filter toggled ' .. result)
  end
end

--stylua: ignore start
function Filter:get_callback()
  if (self.enabled) then
    return self.should_show_entry
  else
    return function(entry)
      return true
    end
  end
end
--stylua: ignore end

function Filter.new(name, start_enabled, start_debug_enabled, should_show_entry)
  local self = setmetatable({}, Filter)
  self.name = name
  self.enabled = start_enabled
  self.should_show_entry = should_show_entry
  self.show_debug_messages = start_debug_enabled
  return self
end

return Filter
-- ============================================================================
