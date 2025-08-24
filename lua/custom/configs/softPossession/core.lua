local M = {}

M.dependencies = {
  'nvim-lua/plenary.nvim',
}

M.config = function()
  require('possession').setup {}
end

return M
