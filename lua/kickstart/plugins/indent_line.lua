local hi_test = function()
  return function()
    return function()
      return function()
        return function()
          return function()
            return function()
              return function()
                return function() end
              end
            end
          end
        end
      end
    end
  end
end

local highlight = {
  'RainbowRed',
  'RainbowYellow',
  'RainbowBlue',
  'RainbowGreen',
  'RainbowOrange',
  'RainbowViolet',
  'RainbowCyan',
}

-- stylua: ignore start
local defaults_bright = {
  RainbowRed =    { fg = '#E06C75' },
  RainbowYellow = { fg = '#E5C07B' },
  RainbowBlue =   { fg = '#61AFEF' },
  RainbowGreen =  { fg = '#98C379' },
  RainbowOrange = { fg = '#D19A66' },
  RainbowViolet = { fg = '#C678DD' },
  RainbowCyan =   { fg = '#56B6C2' },
}
local defaults_dim = {
  RainbowRed =    { fg = '#500210' },
  RainbowYellow = { fg = '#553713' },
  RainbowBlue =   { fg = '#113767' },
  RainbowGreen =  { fg = '#304004' },
  RainbowOrange = { fg = '#401200' },
  RainbowViolet = { fg = '#511234' },
  RainbowCyan =   { fg = '#114141' },
}
-- stylua: ignore end

local config_fn = function()
  local hooks = require 'ibl.hooks'
  local indent_line_ext = nil --require 'softKanagawa.extensions.indent_line'
  local color_table = indent_line_ext ~= nil and indent_line_ext.get_rainbow() or defaults_dim

  -- create the highlight groups in the highlight setup hook, so they are reset
  -- every time the colorscheme changes
  hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    local colors = color_table ~= nil and color_table or defaults_dim
    -- stylua: ignore start
    vim.api.nvim_set_hl(0, 'RainbowRed',    colors.RainbowRed)
    vim.api.nvim_set_hl(0, 'RainbowYellow', colors.RainbowYellow)
    vim.api.nvim_set_hl(0, 'RainbowBlue',   colors.RainbowBlue)
    vim.api.nvim_set_hl(0, 'RainbowGreen',  colors.RainbowGreen)
    vim.api.nvim_set_hl(0, 'RainbowOrange', colors.RainbowOrange)
    vim.api.nvim_set_hl(0, 'RainbowViolet', colors.RainbowViolet)
    vim.api.nvim_set_hl(0, 'RainbowCyan',   colors.RainbowCyan)
    -- stylua: ignore end
  end)

  require('ibl').setup { indent = { highlight = highlight } }
end

return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    config = config_fn,
  },
}
