return {
  'romgrk/barbar.nvim',
  dependencies = {
    'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
    'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  opts = {
    -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
    -- animation = true,
    -- insert_at_start = true,
    -- …etc.
  },
  version = '^1.0.0', -- optional: only update when a new 1.x version is released
  config = function(_, opts)
    require('barbar').setup(opts)

    local map = vim.keymap.set
    local km_opts = { noremap = true, silent = true }

    -- === Navigation (Ctrl) ===
    map('n', '<S-Tab>', '<Cmd>BufferPrevious<CR>', km_opts) -- Ctrl + ,
    map('n', '<Tab>', '<Cmd>BufferNext<CR>', km_opts) -- Ctrl + .

    -- === Reorder (Ctrl + Shift) ===
    map('n', '<C-<>', '<Cmd>BufferMovePrevious<CR>', km_opts) -- Ctrl + Shift + ,
    map('n', '<C->>', '<Cmd>BufferMoveNext<CR>', km_opts) -- Ctrl + Shift + .

    -- === Jump to buffer (Command) ===
    -- macOS terminals send these reliably; great for quick access
    map('n', '<D-1>', '<Cmd>BufferGoto 1<CR>', km_opts)
    map('n', '<D-2>', '<Cmd>BufferGoto 2<CR>', km_opts)
    map('n', '<D-3>', '<Cmd>BufferGoto 3<CR>', km_opts)
    map('n', '<D-4>', '<Cmd>BufferGoto 4<CR>', km_opts)
    map('n', '<D-5>', '<Cmd>BufferGoto 5<CR>', km_opts)
    map('n', '<D-6>', '<Cmd>BufferGoto 6<CR>', km_opts)
    map('n', '<D-7>', '<Cmd>BufferGoto 7<CR>', km_opts)
    map('n', '<D-8>', '<Cmd>BufferGoto 8<CR>', km_opts)
    map('n', '<D-9>', '<Cmd>BufferGoto 9<CR>', km_opts)
    map('n', '<D-0>', '<Cmd>BufferLast<CR>', km_opts)

    -- === Pin / Close (Ctrl) ===
    map('n', '<C-p>', '<Cmd>BufferPin<CR>', km_opts) -- toggle pin
    map('n', '<C-c>', '<Cmd>BufferClose<CR>', km_opts) -- close current

    -- === “Pick” modes (Ctrl) ===
    map('n', '<C-b>', '<Cmd>BufferPick<CR>', km_opts) -- label-pick to jump
    map('n', '<C-S-b>', '<Cmd>BufferPickDelete<CR>', km_opts) -- label-pick to delete

    -- === Sorting (leader + b …) ===
    map('n', '<leader>bb', '<Cmd>BufferOrderByBufferNumber<CR>', km_opts)
    map('n', '<leader>bn', '<Cmd>BufferOrderByName<CR>', km_opts)
    map('n', '<leader>bd', '<Cmd>BufferOrderByDirectory<CR>', km_opts)
    map('n', '<leader>bl', '<Cmd>BufferOrderByLanguage<CR>', km_opts)
    map('n', '<leader>bw', '<Cmd>BufferOrderByWindowNumber<CR>', km_opts)
  end,
}
