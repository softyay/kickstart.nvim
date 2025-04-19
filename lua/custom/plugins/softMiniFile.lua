local maxWindows = 3

return {
  'echasnovski/mini.files',
  config = function()
    local minifiles = require 'mini.files'
    minifiles.setup {
      -- Customization of shown content
      content = {
        -- Predicate for which file system entries to show
        filter = nil,
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
        max_number = maxWindows,
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
    end, { desc = 'File [e]xplore ([c]urrent dir)' })
    vim.keymap.set('n', '<leader>er', function()
      minifiles.open()
    end, { desc = 'File [e]xplore ([r]esume)' })
    vim.keymap.set('n', '<leader>ef', function()
      minifiles.open(vim.fn.getreg '%', false)
    end, { desc = 'File [e]xplore (this [f]ile)' })

    -- TODO: Make a keymap to find the current directory under the cursor
    -- possibly check for a git repo first.
    --
    -- vim.keymap.set('n', '<leader>es', function()
    --   minifiles.open(vim.fn.chdir(vim.fn.getreg '%'), false)
    -- end, { desc = '[S]et this as current dir' })
  end,
}
