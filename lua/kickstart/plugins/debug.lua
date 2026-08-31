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

    -- Shows variable values inline while debugging
    'theHamsta/nvim-dap-virtual-text',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
  },
  keys = {
    -- Basic debugging keymaps, feel free to change to your liking!
    {
      '<leader>dc',
      function()
        require('dap').continue()
      end,
      desc = 'Debug: Start/Continue',
    },
    {
      '<leader>di',
      function()
        require('dap').step_into()
      end,
      desc = 'Debug: Step Into',
    },
    {
      '<leader>do',
      function()
        require('dap').step_over()
      end,
      desc = 'Debug: Step Over',
    },
    {
      '<leader>dO',
      function()
        require('dap').step_out()
      end,
      desc = 'Debug: Step Out',
    },
    {
      '<leader>b',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Debug: Toggle Breakpoint',
    },
    {
      '<leader>B',
      function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = 'Debug: Set Breakpoint',
    },
    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    {
      '<leader>du',
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
        'delve',
        'js',
        'codelldb',
        'elixir',
      },
    }

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    require('nvim-dap-virtual-text').setup {
      display_callback = function(variable)
        local name = string.lower(variable.name)
        local value = string.lower(variable.value)
        if name:match 'secret' or name:match 'api' or value:match 'secret' or value:match 'api' then
          return '*****'
        end

        if #variable.value > 15 then
          return ' ' .. string.sub(variable.value, 1, 15) .. '... '
        end

        return ' ' .. variable.value
      end,
    }

    vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
    vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })

    local breakpoint_icons = {
      Breakpoint = 'B',
      BreakpointCondition = 'C',
      BreakpointRejected = 'R',
      LogPoint = 'L',
      Stopped = '>',
    }

    for type, icon in pairs(breakpoint_icons) do
      local tp = 'Dap' .. type
      local hl = type == 'Stopped' and 'DapStop' or 'DapBreak'
      vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    end

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    local function input(default, prompt)
      local value = vim.fn.input(prompt, default)
      if value == '' then
        return default
      end
      return value
    end

    local function split_args(value)
      return vim.split(value or '', ' +', { trimempty = true })
    end

    local js_debug_adapter = vim.fn.exepath 'js-debug-adapter'
    if js_debug_adapter ~= '' then
      dap.adapters['pwa-node'] = {
        type = 'server',
        host = '127.0.0.1',
        port = '${port}',
        executable = {
          command = js_debug_adapter,
          args = { '${port}' },
        },
      }
      dap.adapters['pwa-chrome'] = dap.adapters['pwa-node']

      local js_configurations = {
        {
          name = 'Node: Launch current file',
          type = 'pwa-node',
          request = 'launch',
          program = '${file}',
          cwd = '${workspaceFolder}',
          sourceMaps = true,
          console = 'integratedTerminal',
          skipFiles = { '<node_internals>/**' },
        },
        {
          name = 'Node: Launch package script',
          type = 'pwa-node',
          request = 'launch',
          cwd = '${workspaceFolder}',
          runtimeExecutable = function()
            return input('npm', 'Package manager: ')
          end,
          runtimeArgs = function()
            return split_args(input('run dev', 'Package manager args: '))
          end,
          sourceMaps = true,
          autoAttachChildProcesses = true,
          console = 'integratedTerminal',
          skipFiles = { '<node_internals>/**' },
        },
        {
          name = 'Node: Attach process',
          type = 'pwa-node',
          request = 'attach',
          processId = require('dap.utils').pick_process,
          cwd = '${workspaceFolder}',
          sourceMaps = true,
          skipFiles = { '<node_internals>/**' },
        },
        {
          name = 'Node: Attach inspect port 9229',
          type = 'pwa-node',
          request = 'attach',
          address = function()
            return input('127.0.0.1', 'Debug host: ')
          end,
          port = function()
            return tonumber(input('9229', 'Debug port: '))
          end,
          localRoot = '${workspaceFolder}',
          remoteRoot = function()
            return input('/app', 'Remote root: ')
          end,
          sourceMaps = true,
          skipFiles = { '<node_internals>/**' },
        },
        {
          name = 'Browser: Launch Chrome/SvelteKit',
          type = 'pwa-chrome',
          request = 'launch',
          url = function()
            return input('http://localhost:5173', 'URL: ')
          end,
          webRoot = '${workspaceFolder}',
          sourceMaps = true,
        },
        {
          name = 'Browser: Attach Chrome port 9222',
          type = 'pwa-chrome',
          request = 'attach',
          address = function()
            return input('127.0.0.1', 'Browser debug host: ')
          end,
          port = function()
            return tonumber(input('9222', 'Browser debug port: '))
          end,
          webRoot = '${workspaceFolder}',
          sourceMaps = true,
        },
      }

      for _, language in ipairs { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte' } do
        dap.configurations[language] = js_configurations
      end
    end

    local native_configurations = {
      {
        name = 'LLDB: Launch executable',
        type = 'codelldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = function()
          return split_args(vim.fn.input 'Args: ')
        end,
        runInTerminal = true,
      },
      {
        name = 'LLDB: Attach process',
        type = 'codelldb',
        request = 'attach',
        pid = require('dap.utils').pick_process,
        cwd = '${workspaceFolder}',
      },
    }

    for _, language in ipairs { 'c', 'cpp', 'rust', 'zig' } do
      dap.configurations[language] = native_configurations
    end

    local debugpy_adapter = vim.fn.exepath 'debugpy-adapter'
    if debugpy_adapter ~= '' then
      dap.adapters.python = {
        type = 'executable',
        command = debugpy_adapter,
      }

      local function python_path()
        local venv = vim.env.VIRTUAL_ENV
        if venv and venv ~= '' then
          return venv .. '/bin/python'
        end

        local conda = vim.env.CONDA_PREFIX
        if conda and conda ~= '' then
          return conda .. '/bin/python'
        end

        return vim.fn.exepath 'python3'
      end

      dap.configurations.python = {
        {
          name = 'Python: Launch current file',
          type = 'python',
          request = 'launch',
          program = '${file}',
          cwd = '${workspaceFolder}',
          console = 'integratedTerminal',
          justMyCode = true,
          pythonPath = python_path,
        },
        {
          name = 'Python: Launch module',
          type = 'python',
          request = 'launch',
          module = function()
            return vim.fn.input 'Module: '
          end,
          cwd = '${workspaceFolder}',
          console = 'integratedTerminal',
          justMyCode = true,
          pythonPath = python_path,
          args = function()
            return split_args(vim.fn.input 'Args: ')
          end,
        },
        {
          name = 'Python: Attach debugpy port 5678',
          type = 'python',
          request = 'attach',
          connect = {
            host = function()
              return input('127.0.0.1', 'Debug host: ')
            end,
            port = function()
              return tonumber(input('5678', 'Debug port: '))
            end,
          },
          pathMappings = {
            {
              localRoot = '${workspaceFolder}',
              remoteRoot = function()
                return input('${workspaceFolder}', 'Remote root: ')
              end,
            },
          },
          justMyCode = true,
        },
      }
    end

    local elixir_ls_debugger = vim.fn.exepath 'elixir-ls-debugger'
    if elixir_ls_debugger ~= '' then
      dap.adapters.mix_task = {
        type = 'executable',
        command = elixir_ls_debugger,
      }

      dap.configurations.elixir = {
        {
          name = 'Elixir: Mix task prompt',
          type = 'mix_task',
          request = 'launch',
          task = function()
            return input('test', 'Mix task: ')
          end,
          taskArgs = function()
            return split_args(vim.fn.input 'Mix task args: ')
          end,
          projectDir = '${workspaceFolder}',
          startApps = true,
          exitAfterTaskReturns = false,
          debugAutoInterpretAllModules = false,
        },
        {
          name = 'Elixir: Mix test',
          type = 'mix_task',
          request = 'launch',
          task = 'test',
          taskArgs = { '--trace' },
          projectDir = '${workspaceFolder}',
          startApps = true,
          requireFiles = {
            'test/**/test_helper.exs',
            'test/**/*_test.exs',
          },
          debugAutoInterpretAllModules = false,
        },
        {
          name = 'Elixir: Mix test current file',
          type = 'mix_task',
          request = 'launch',
          task = 'test',
          taskArgs = function()
            return { vim.fn.expand '%:p' }
          end,
          projectDir = '${workspaceFolder}',
          startApps = true,
          requireFiles = {
            'test/**/test_helper.exs',
            vim.fn.expand '%:p',
          },
          debugAutoInterpretAllModules = false,
        },
        {
          name = 'Elixir: Phoenix server',
          type = 'mix_task',
          request = 'launch',
          task = 'phx.server',
          projectDir = '${workspaceFolder}',
          startApps = true,
          exitAfterTaskReturns = false,
          debugAutoInterpretAllModules = false,
        },
      }
    end

    local ocamlearlybird = vim.fn.exepath 'ocamlearlybird'
    if ocamlearlybird ~= '' then
      dap.adapters.ocamlearlybird = {
        type = 'executable',
        command = ocamlearlybird,
        args = { 'debug' },
      }

      dap.configurations.ocaml = {
        {
          name = 'OCaml: Launch bytecode prompt',
          type = 'ocamlearlybird',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to .bc file: ', vim.fn.getcwd() .. '/_build/default/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          yieldSteps = 4096,
          onlyDebugGlob = '<${workspaceFolder}/**/*>',
        },
        {
          name = 'OCaml: Launch current module bytecode',
          type = 'ocamlearlybird',
          request = 'launch',
          program = function()
            local relative_dir = vim.fn.expand '%:.:h'
            local module_name = vim.fn.expand '%:t:r'
            return vim.fn.getcwd() .. '/_build/default/' .. relative_dir .. '/' .. module_name .. '.bc'
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          yieldSteps = 4096,
          onlyDebugGlob = '<${workspaceFolder}/**/*>',
        },
      }
    end

    -- Install golang specific config
    require('dap-go').setup {
      delve = {
        -- On Windows delve must be run attached or it crashes.
        -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = vim.fn.has 'win32' == 0,
      },
    }
  end,
}
