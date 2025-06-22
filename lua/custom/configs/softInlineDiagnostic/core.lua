local M = {}

M.config_table = {
  'rachartier/tiny-inline-diagnostic.nvim',
  event = 'VeryLazy', -- Or `LspAttach`
  priority = 1000, -- needs to be loaded in first
  config = function()
    require('tiny-inline-diagnostic').setup {
      options = {
        miltilines = true,
      },
    }
    vim.diagnostic.config {
      -- Only if needed in your configuration,
      -- if you already have native LSP diagnostics
      virtual_text = false,
    }
  end,
}

return M
