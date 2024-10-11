return {
  'mfussenegger/nvim-dap',
  config = function()
    local dap = require 'dap'
    dap.adapters.gdb = {
      type = 'executable',
      command = 'gdb',
      args = { '--interpreter=dap', '--eval-command', 'set print pretty on' },
    }
    dap.configurations.c = {
      {
        name = 'Run executable (GDB)',
        type = 'gdb',
        request = 'launch',
        -- This requires special handling of 'run_last', see
        -- https://github.com/mfussenegger/nvim-dap/issues/1025#issuecomment-1695852355
        program = function()
          local path = vim.fn.input {
            prompt = 'Path to executable: ',
            default = vim.fn.getcwd() .. '/',
            completion = 'file',
          }

          return (path and path ~= '') and path or dap.ABORT
        end,
      },
      {
        name = 'Run executable with arguments (GDB)',
        type = 'gdb',
        request = 'launch',
        -- This requires special handling of 'run_last', see
        -- https://github.com/mfussenegger/nvim-dap/issues/1025#issuecomment-1695852355
        program = function()
          local path = vim.fn.input {
            prompt = 'Path to executable: ',
            default = vim.fn.getcwd() .. '/',
            completion = 'file',
          }

          return (path and path ~= '') and path or dap.ABORT
        end,
        args = function()
          local args_str = vim.fn.input {
            prompt = 'Arguments: ',
          }
          return vim.split(args_str, ' +')
        end,
      },
      {
        name = 'Attach to process (GDB)',
        type = 'gdb',
        request = 'attach',
        processId = require('dap.utils').pick_process,
      },
    }
    dap.configurations.cpp = dap.configurations.c
    vim.fn.sign_define('DapBreakpoint', { text = '🟥', texthl = '', linehl = '', numhl = '' })
    vim.fn.sign_define('DapStopped', { text = '▶️', texthl = '', linehl = '', numhl = '' })
    -- vim.keymap.set('n', '<F5>',

    vim.keymap.set('n', '<F5>', require('dap').continue)
    vim.keymap.set('n', '<F10>', require('dap').step_over)
    vim.keymap.set('n', '<F11>', require('dap').step_into)
    vim.keymap.set('n', '<F12>', require('dap').step_out)
    vim.keymap.set('n', '<F9>', require('dap').toggle_breakpoint)
  end,
}
