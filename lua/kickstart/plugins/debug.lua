-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
    -- 'Samsung/netcoredbg',
  },
  keys = {
    -- Basic debugging keymaps, feel free to change to your liking!
    {
      '<F5>',
      function()
        require('dap').continue()
      end,
      desc = 'Debug: Start/Continue',
    },
    {
      '<F1>',
      function()
        require('dap').step_into()
      end,
      desc = 'Debug: Step Into',
    },
    {
      '<F2>',
      function()
        require('dap').step_over()
      end,
      desc = 'Debug: Step Over',
    },
    {
      '<F3>',
      function()
        require('dap').step_out()
      end,
      desc = 'Debug: Step Out',
    },
    {
      '<leader>dbs',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = '[D]ebug: [B]reakpoints: [S]tandard',
    },
    {
      '<leader>dbc',
      function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = '[D]ebug: [B]reakpoints: [C]onditional',
    },
    {
      '<leader>dbd',
      function()
        require('dap').clear_breakpoints()
      end,
      desc = '[D]ebug: [B]reakpoints: [D]elete',
    },
    {
      '<leader>dbl',
      function()
        require('dap').list_breakpoints(true)
      end,
      desc = '[D]ebug: [B]reakpoints: [L]ist',
    },
    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    {
      '<F7>',
      function()
        require('dapui').toggle()
      end,
      desc = 'Debug: See last session result.',
    },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        -- 'delve',
      },
    }

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      layouts = {
        {
          elements = {
            {
              id = 'scopes',
              size = 0.25,
            },
            {
              id = 'breakpoints',
              size = 0.25,
            },
            {
              id = 'stacks',
              size = 0.25,
            },
            {
              id = 'watches',
              size = 0.25,
            },
          },
          position = 'left',
          size = 40,
        },
        {
          elements = {
            {
              id = 'repl',
              size = 0.5,
            },
            {
              id = 'console',
              size = 0.5,
            },
          },
          position = 'bottom',
          size = 10,
        },
      },
    }

    -- Change breakpoint icons
    vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
    vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
    local breakpoint_icons = vim.g.have_nerd_font
        and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
      or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
    for type, icon in pairs(breakpoint_icons) do
      local tp = 'Dap' .. type
      local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
      vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    end

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    require('dap-go').setup {
      delve = {
        -- On Windows delve must be run attached or it crashes.
        -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = vim.fn.has 'win32' == 0,
      },
    }

    -- NOTE: Layla
    --[[
    local cwdItemInfo = require 'custom.utils.cwdItemInfo'

    dap.configurations.cs = {
      {
        type = 'coreclr',
        name = 'Launch And Attach',
        request = 'attach',
        -- program = function()
        --     --   return dll
        --     -- else
        --     --   return dap.ABORT
        -- end,
        processId = function()
          local function has_proj_file(path, incoming_depth, current_iterations)
            local MaxIterations = 100000
            local MaxDepth = 5

            local current_depth = incoming_depth

            while current_depth < MaxDepth and current_iterations < MaxIterations do
              local file_matches = cwdItemInfo.get_files(path, 'csproj')
              local dirs = cwdItemInfo.get_directories(path)
              if #file_matches > 0 then
                return true
              elseif #dirs > 0 then
                for i, dir in ipairs(dirs) do
                  current_iterations = current_iterations + 1
                  if has_proj_file(dir.fullpath, current_depth + 1, current_iterations) then
                    return true
                  end
                end
              end
            end

            return false
          end

          local function select_dll(path, incoming_depth, current_iterations)
            local MaxIterations = 100000
            local MaxDepth = 5

            local current_depth = incoming_depth

            if current_depth >= MaxDepth or current_iterations >= MaxIterations then
              return nil
            else
              local file_matches = cwdItemInfo.get_files(path, 'dll')
              local dirs = cwdItemInfo.get_directories(path)
              print('files in ' .. path .. 'at depth ' .. current_depth .. 'that match pattern ' .. 'dll' .. ':\n', vim.inspect(file_matches))
              -- print(vim.inspect(dirs))
              if #file_matches > 0 then
                print(file_matches[1].fullpath)
                return file_matches[1].fullpath
              end

              if #dirs > 0 then
                for i, dir in ipairs(dirs) do
                  current_iterations = current_iterations + 1
                  local dll = select_dll(dir.fullpath, current_depth + 1, current_iterations)
                  if dll then
                    return dll
                  end
                end
              else
                return nil
              end
            end

            return nil
          end

          local has_proj = has_proj_file(vim.fn.getcwd(), 0, 0)
          local dll = select_dll(vim.fn.getcwd(), 0, 0)
          if has_proj and (dll ~= nil) then
            -- Function to launch the external terminal and return the process’s PID
            local function launch_process_and_get_pid(dll_path)
              -- Build the command to launch Windows Terminal (wt) to run dotnet with your DLL.
              -- This command opens a new interactive terminal window.
              local terminal_cmd = 'start wt -w 0 cmd /k "dotnet ' .. dll_path .. '"'
              print('Launching process: ' .. terminal_cmd)
              os.execute(terminal_cmd)

              -- Allow a bit of time (e.g. 2 seconds) for the process to start
              vim.wait(1000, function()
                return false
              end)

              -- Now, use a PowerShell command to query for the dotnet process running our DLL.
              -- Note: We assume the DLL path appears (uniquely) in the process’s command line.
              local ps_command = 'powershell -Command "Get-Process dotnet | Where-Object { $_.Path -like \'*'
                .. dll_path:gsub('\\', '\\\\')
                .. '*\' } | Select-Object -First 1 -Property Id | Format-Table -HideTableHeaders"'
              print 'Running PowerShell command to find process:'
              print(ps_command)
              local output = vim.fn.systemlist(ps_command)
              print 'Process query output:'
              print(vim.inspect(output))

              -- Parse the first line of output to extract the PID (an integer)
              for _, line in ipairs(output) do
                local pid = line:match '(%d+)'
                if pid then
                  print('Found PID:', pid)
                  return tonumber(pid)
                end
              end

              print 'No matching process found.'
              return nil
            end
            return launch_process_and_get_pid(dll)
          end
        end,
      },
      {
        type = 'coreclr',
        name = 'hi',
        request = 'launch',
        processId = require('dap.utils').pick_process,
      },
    }
    --]]
  end,
}
