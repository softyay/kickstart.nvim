local Filter = require 'softMiniFile.filter'
local M = {}

M.maxWindows = 3

local filter_calls = 0

-- Filters
-- ============================================================================

-- .meta filtering
local meta_filter = Filter.new('Meta Files', false, false, function(entry)
  return not vim.endswith(entry.name, '.meta')
end)

-- ============================================================================

M.filters = {
  meta_filter,
}

local disable_debug_msg_all_filters = false
M.passes_all_filters = function(entry)
  filter_calls = filter_calls + 1

  for i = 1, #M.filters do
    local current_filter = M.filters[i]
    local passes_current_filter = current_filter:get_callback()

    if disable_debug_msg_all_filters then
      current_filter.show_debug_messages = false
    end

    if not passes_current_filter(entry) then
      if current_filter.show_debug_messages then
        local prompt = "Entry '" .. entry.name .. "' was filtered by filter " .. i .. ' (' .. M.filters[i].name .. ') \n'
        prompt = prompt .. 'Enter -> continue\n'
        prompt = prompt .. "'off' -> disable debug mode for this filter\n"
        prompt = prompt .. "'all off' -> disable debug mode off for all filters\n"
        local inp = vim.fn.input(prompt)
        if inp == 'off' then
          current_filter.show_debug_messages = false
        elseif inp == 'all off' then
          current_filter.show_debug_messages = false
          disable_debug_msg_all_filters = true
        end
      end

      return false
    end
  end

  return true
end

M.config_table = {
  'echasnovski/mini.files',
  config = function()
    local minifiles = require 'mini.files'
    minifiles.setup {
      -- Customization of shown content
      content = {
        -- Predicate for which file system entries to show
        filter = M.passes_all_filters,
        -- What prefix to show to the left of file system entry
        prefix = nil,
        -- In which order to show file system entries
        sort = nil,
      },

      -- Module mappings created only inside explorer.
      -- Use `''` (empty string) to not create one.
      mappings = {
        close = 'q',
        go_in = 'l',
        go_in_plus = 'L',
        go_out = 'h',
        go_out_plus = 'H',
        mark_goto = "'",
        mark_set = 'm',
        reset = '<BS>',
        reveal_cwd = '@',
        show_help = 'g?',
        synchronize = '=',
        trim_left = '<',
        trim_right = '>',
      },

      -- General options
      options = {
        -- Whether to delete permanently or move into module-specific trash
        permanent_delete = true,
        -- Whether to use for editing directories
        use_as_default_explorer = true,
      },

      -- Customization of explorer windows
      windows = {
        -- Maximum number of windows to show side by side
        max_number = M.maxWindows,
        -- Whether to show preview of file/directory under cursor
        preview = true,
        -- Width of focused window
        width_focus = 25,
        -- Width of non-focused window
        width_nofocus = 25,
        -- Width of preview window
        width_preview = 70,
      },
    }

    vim.keymap.set('n', '<leader>ec', function()
      minifiles.open(nil, false)
    end, { desc = '[E]xplore [C]urrent Directory)' })

    vim.keymap.set('n', '<leader>er', function()
      minifiles.open()
    end, { desc = '[E]xplore ([R]esume)' })

    vim.keymap.set('n', '<leader>ef', function()
      minifiles.open(vim.fn.getreg '%', false)
    end, { desc = '[E]xplore from [F]ile' })

    vim.keymap.set('n', '<leader>etm', function()
      meta_filter:toggle()
      MiniFiles.refresh { content = { filter = M.passes_all_filters } }
    end, { desc = '[E]xplore: [T]oggle .[m]eta files' })
    -- vim.api.nvim_create_autocmd('User', {
    --   pattern = 'MiniFilesWindowOpen',
    --   callback = function(args)
    --     MiniFiles.refresh { content = { filter = filter_through_enabled } }
    --   end,
    -- })

    -- TODO: Make a keymap to find the current directory under the cursor
    -- possibly check for a git repo first.
    --
    -- vim.keymap.set('n', '<leader>es', function()
    --   minifiles.open(vim.fn.chdir(vim.fn.getreg '%'), false)
    -- end, { desc = '[S]et this as current dir' })
  end,
}

return M
