local core = require 'softLualine.core'
local lualine_ext = nil --require 'softKanagawa.extensions.lualine'

local visual_theme = 'round'

return {
  'nvim-lualine/lualine.nvim',
  -- event = 'VimEnter',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    -- require 'softKanagawa.spec',
  },
  priority = 10,
  config = function()
    local use_defaults = lualine_ext == nil
    local color_theme = use_defaults == true and {} or lualine_ext.get_main_theme()
    local tab_theme = use_defaults == true and {} or lualine_ext.get_tab_theme()
    require('lualine').setup(use_defaults == true and core.get_default_opts(visual_theme) or {
      options = {
        theme = color_theme,
        icons_enabled = true,
        component_separators = core.component_sep(visual_theme),
        section_separators = core.section_sep(visual_theme),
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = false,
        refresh = {
          statusline = 100,
          tabline = 100,
          winbar = 100,
        },
      },
      sections = {
        lualine_a = {
          {
            'mode',
          },
        },
        lualine_b = {
          {
            'branch',
          },
          {
            'diff',
          },
        },
        lualine_c = {
          {
            'filename',
            fmt = core.trim_path_to_filename,
          },
        },
        lualine_x = {
          {
            'filetype',
          },
        },
        lualine_y = {
          {
            'progress',
          },
        },
        lualine_z = {
          {
            'location',
          },
        },
      },
      inactive_sections = {
        lualine_a = {
          {
            'mode',
          },
        },
        lualine_b = {
          {
            'branch',
          },
          {
            'diff',
          },
        },
        lualine_c = {
          {
            'filename',
            fmt = core.trim_path_to_filename,
          },
        },
        lualine_x = {
          core.standalone_separator_component(nil, 0),
          {
            'filetype',
          },
        },
        lualine_y = {
          {
            'progress',
          },
        },
        lualine_z = {
          {
            'location',
          },
        },
      },
      tabline = {
        lualine_a = {
          {
            'tabs',
            mode = 2,
            tabs_color = use_defaults == true and {} or {
              active = tab_theme.active,
              inactive = tab_theme.inactive,
            },
          },
        },
        lualine_x = {
          {
            function()
              return ' '
            end,
            color = use_defaults == true and {} or color_theme.command.c,
          },
          {
            core.get_day,
            color = use_defaults == true and {} or color_theme.command.c,
          },
        },
        lualine_y = {
          {
            core.get_date,
            color = use_defaults == true and {} or color_theme.command.y,
          },
          -- {
          --   'windows',
          --   use_mode_colors = true,
          --   windows_color = {
          --     active = tab_theme.active,
          --     inactive = tab_theme.inactive,
          --   },
          -- },
        },
        lualine_z = {
          {
            core.get_time,
            color = use_defaults == true and {} or color_theme.command.z,
          },
        },
      },
      winbar = {
        lualine_a = {
          {
            'filename',
          },
        },
        lualine_b = {
          {
            'lsp_status',
          },
        },
        lualine_c = {
          {
            'diagnostics',
            always_visible = true,
          },
        },
        lualine_x = {
          {
            core.win_num,
          },
          {
            core.buff_id,
          },
        },
        lualine_y = {
          {
            'progress',
          },
        },
        lualine_z = {
          {
            'location',
          },
        },
      },
      inactive_winbar = {
        lualine_a = {
          {
            'filename',
          },
        },
        lualine_b = {
          {
            'lsp_status',
          },
        },
        lualine_c = {
          {
            'diagnostics',
            colored = false,
            always_visible = true,
          },
        },
        lualine_x = {
          {
            core.win_num,
          },
          {
            core.buff_id,
          },
        },
        lualine_y = {
          {
            'progress',
          },
        },
        lualine_z = {
          {
            'location',
          },
        },
      },
      extensions = {
        'fzf',
        'lazy',
        'nvim-dap-ui',
        'mason',
        'quickfix',
      },
    })

    -- New empty tab named to input from cmd
    vim.keymap.set('n', '<leader>bnn', function()
      local new_name = core.get_name_input()
      core.new_tab_wrapper(new_name)
    end, { desc = 'Ta[b] [n]ew with [n]ame' })

    -- Rename tab to input from cmd
    vim.keymap.set('n', '<leader>brn', function()
      local new_name = core.get_name_input()
      core.rename_wrapper(new_name)
    end, { desc = 'Ta[b] [r]e[n]ame' })

    local wk = require 'which-key'
    wk.add {
      { '<leader>b', group = 'Ta[b]s', mode = { 'n' } },
    }
  end,
}
