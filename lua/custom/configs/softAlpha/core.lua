local M = {}

local theme_name = 'soft_dash'

local alpha = {}
local configs = {}

local get_soft_dash = function()
  local dash = require 'alpha.themes.dashboard'
  dash.section.buttons.val = {
    dash.button('f', ' ' .. ' Find Files', ':Telescope find_files<cr>'),
    dash.button('e', ' ' .. ' New Files', ':ene <BAR> startinsert <CR>'),
    dash.button('o', '󱎫 ' .. ' Recent Files', ':Telescope frecency <CR>'),
    dash.button('g', ' ' .. ' Find Text', ':Telescope live_grep <CR>'),
    dash.button(
      'c',
      ' ' .. ' Nvim Config',
      [[<cmd>PossessionLoad config<CR>]]
    ),
    dash.button('z', '󰒲 ' .. ' Lazy', ':Lazy<CR>'),
    dash.button('q', ' ' .. ' Quit', ':qa<CR>'),
    (function()
      local group = { type = 'group', opts = { spacing = 0 } }
      group.val = {
        {
          type = 'text',
          val = 'Sessions',
          opts = {
            position = 'center',
          },
        },
      }
      local path = vim.fn.stdpath 'data' .. '/possession'
      local files = vim.split(vim.fn.glob(path .. '/*.json'), '\n')
      for i, file in pairs(files) do
        local basename = vim.fs.basename(file):gsub('%.json', '')
        local button = dash.button(
          tostring(i),
          ' ' .. basename,
          '<cmd>PossessionLoad ' .. basename .. '<cr>'
        )
        table.insert(group.val, button)
      end
      return group
    end)(),
  }
  dash.opts.layout[1].val = 8
  return dash.opts
end

M.config = function()
  alpha = require 'alpha'
  configs = {
    dashboard = function()
      return require('alpha.themes.dashboard').config
    end,
    startify = function()
      return require('alpha.themes.startify').config
    end,
    theta = function()
      return require('alpha.themes.theta').config
    end,
    soft_dash = function()
      return get_soft_dash()
    end,
  }
  alpha.setup(configs[theme_name]())
end
return M
