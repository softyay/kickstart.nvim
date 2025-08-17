---@class IconPair
---@field a string
---@field b string
local IconPair = {}
IconPair.__index = IconPair

---@param a string
---@param b string
---@return IconPair
function IconPair:new(a, b)
  local instance = setmetatable({}, IconPair)
  instance.a = a or 'x'
  instance.b = b or 'x'
  return instance
end

---@return {a: string, b: string}
function IconPair:get()
  return { a = self.a, b = self.b }
end

---@return {a: string, b: string}
function IconPair:get_swapped()
  return { a = self.b, b = self.a }
end

return IconPair
