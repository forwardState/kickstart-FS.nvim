return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { 'markdown' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'echasnovski/mini.nvim',
    },
    keys = {
      {
        '<leader>mr',
        function()
          require('render-markdown').buf_toggle()
        end,
        ft = 'markdown',
        desc = 'Markdown: Toggle rendered view',
      },
      {
        '<leader>mp',
        function()
          require('render-markdown').buf_toggle()
        end,
        ft = 'markdown',
        desc = 'Markdown: Toggle pretty view',
      },
    },
    opts = {
      enabled = false,
      file_types = { 'markdown' },
      render_modes = { 'n', 'c' },
    },
  },
}
