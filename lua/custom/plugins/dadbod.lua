return {
  'tpope/vim-dadbod',
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      'tpope/vim-dadbod',
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = vim.g.have_nerd_font and 1 or 0
    end,
  },
  {
    'kristijanhusak/vim-dadbod-completion',
    ft = { 'sql', 'mysql', 'plsql' },
    dependencies = {
      'tpope/vim-dadbod',
      'hrsh7th/nvim-cmp',
    },
  },
}
