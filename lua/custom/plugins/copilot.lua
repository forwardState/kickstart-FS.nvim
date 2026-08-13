return {
  {
    -- 1. Core Copilot engine
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    build = ':Copilot auth',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        suggestion = { enabled = false },
        panel = { enabled = false },
      }
    end,
  },

  {
    -- 2. Feed Copilot into nvim-cmp
    'zbirenbaum/copilot-cmp',
    dependencies = { 'zbirenbaum/copilot.lua' },
    config = function()
      require('copilot_cmp').setup()
    end,
  },

  {
    -- 3. Interactive Copilot Chat
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'main', -- optional, can use main
    dependencies = {
      { 'zbirenbaum/copilot.lua' }, -- required
      { 'nvim-lua/plenary.nvim' }, -- required
    },
    build = 'make tiktoken',
    config = function()
      require('CopilotChat').setup {
        -- optional config
      }

      -- Optional keymap example
      vim.api.nvim_set_keymap('n', '<leader>cc', '<cmd>CopilotChat<CR>', { noremap = true, silent = true })
    end,
  },
}
