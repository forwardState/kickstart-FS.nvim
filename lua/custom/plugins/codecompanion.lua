return {
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      -- ACP adapters are chat-only
      strategies = {
        chat = {
          adapter = 'codex',
        },
      },

      adapters = {
        acp = {
          codex = function()
            local codex_acp = vim.env.CODEX_ACP or vim.fn.exepath 'codex-acp'
            if codex_acp == '' then
              vim.notify('codecompanion.nvim: set CODEX_ACP or put codex-acp on PATH', vim.log.levels.WARN)
              codex_acp = 'codex-acp'
            end

            return require('codecompanion.adapters').extend('codex', {
              commands = {
                default = { codex_acp },
              },

              defaults = {
                -- "openai-api-key" | "codex-api-key" | "chatgpt"
                auth_method = 'chatgpt',
              },

              -- If you use API key auth instead, set auth_method = "openai-api-key"
              -- and provide OPENAI_API_KEY via env (or just export it in your shell).
              -- env = { OPENAI_API_KEY = "my-api-key" },
            })
          end,
        },
      },
    },
  },
}
