local IconPair = require 'custom.utils.borders.IconPair'

---@alias operation fun() : {a: string, b: string}
---
---@alias SwapTable {sides: boolean, levels:boolean, topCorners: boolean, btmCorners: boolean}
---@alias OpTable {sides: operation, levels: operation, topCorners: operation, btmCorners: operation}
---
---@class CharTable
---@field [1] string nw
---@field [2] string n
---@field [3] string ne
---@field [4] string e
---@field [5] string se
---@field [6] string s
---@field [7] string sw
---@field [8] string w

---@class Borders
---@field config {sides: IconPair, levels: IconPair, topCorner: IconPair, btmCorner: IconPair}
---@field swaptable SwapTable
---@field get_operations fun(self: Borders) : OpTable
---@field get fun(...) : CharTable
local Borders = {}
Borders.__index = Borders

Borders.arrows = IconPair:new('󰘟', '󰘠')
Borders.graphs = IconPair:new('󱇂', '󱇄')
Borders.transit_sides = IconPair:new('󰴼', '󰴼')
Borders.pipes = IconPair:new('󱥢', '󱥢')

Borders.lines = IconPair:new('', '')
Borders.transit_levels = IconPair:new('󱕆', '󱕆')

Borders.triangle = IconPair:new('󱇃', '󱇃')
Borders.transit_corners = IconPair:new('󰴽', '󰴽')

Borders.default_config = {
  sides = Borders.arrows,
  levels = Borders.lines,
  topCorners = Borders.triangle,
  btmCorners = Borders.triangle,
}

Borders.default_swaptable = {
  sides = false,
  levels = false,
  topCorners = false,
  btmCorners = false,
}

local function is_valid(key, iconPair)
  if key == nil then
    return false, 'Nil key in Borders config table'
  end
  if Borders.default_config[key] == nil then
    return false, 'Invalid key [' .. key .. ']'
  end
  if iconPair == nil then
    return false, 'Borders table element was nil'
  end
  if getmetatable(iconPair).__index ~= IconPair then
    return false, 'Borders table element was not an IconPair'
  end

  return true
end

---@param iconPairs {sides: IconPair|nil, levels: IconPair|nil, topCorners: IconPair|nil, btmCorners: IconPair|nil}
---@return Borders
function Borders:new(iconPairs)
  local instance = setmetatable({}, Borders)
  instance.config = Borders.default_config
  instance.swaptable = Borders.default_swaptable
  if iconPairs == nil or type(iconPairs) ~= 'table' then
    return instance
  end

  for key, iconPair in pairs(iconPairs) do
    local valid, err = is_valid(key, iconPair)
    if valid then
      instance.config[key] = iconPair
    else
      print(err)
    end
  end
  return instance
end

---@return OpTable
function Borders:get_operations()
  local ops = {}
  for key, iconPair in pairs(self.config) do
    if self.swaptable[key] then
      ops[key] = function()
        return iconPair:get_swapped()
      end
    else
      ops[key] = function()
        return iconPair:get()
      end
    end
  end
  return ops
end

function Borders:get(...)
  local args = { ... }
  local newSwaps = {}
  if #args == 1 and type(args[1]) == table then
    newSwaps = args[1]
  elseif #args > 0 and #args <= 4 then
    for _, arg in pairs(args) do
      newSwaps[arg] = true
    end
  end

  for key, val in pairs(newSwaps) do
    if
      key ~= nil
      and val ~= nil
      and type(val) == 'boolean'
      and self.swaptable[key] ~= nil
    then
      self.swaptable[key] = val
    end
  end

  local optable = self:get_operations()
  return {
    optable['topCorners']().a,
    optable['levels']().a,
    optable['topCorners']().b,
    optable['sides']().b,
    optable['btmCorners']().b,
    optable['levels']().b,
    optable['btmCorners']().a,
    optable['sides']().a,
  }
end

return Borders
