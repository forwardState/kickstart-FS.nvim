return {
  'krady21/compiler-explorer.nvim',
  config = function()
    require('compiler-explorer').setup {
      -- optional: pick defaults
      infer_lang = true, -- Try to infer possible language based on file extension.
      line_match = {
        highlight = true, -- highlight the matching line(s) in the other buffer.
        jump = true, -- move the cursor in the other buffer to the first matching line.
      },
      open_qflist = false, -- show errors in qf if compile fails
      split = 'split', -- or "horizontal"/"vertical"
    }

    local map = vim.keymap.set
    local o = { noremap = true, silent = true }

    -- Core compile flows
    map('n', '<leader>ce', '<Cmd>CECompile<CR>', vim.tbl_extend('force', o, { desc = 'CE: Compile buffer' })) -- prompts for compiler/flags
    map('n', '<leader>cE', '<Cmd>CECompile!<CR>', vim.tbl_extend('force', o, { desc = 'CE: Compile (new asm win)' }))
    map('n', '<leader>cl', '<Cmd>CECompileLive<CR>', vim.tbl_extend('force', o, { desc = 'CE: Toggle live compile' }))
    map('v', '<leader>ce', ':CECompile<CR>', vim.tbl_extend('force', o, { desc = 'CE: Compile selection' }))

    -- Utilities
    map('n', '<leader>cf', '<Cmd>CEFormat<CR>', vim.tbl_extend('force', o, { desc = 'CE: Format buffer' }))
    map('n', '<leader>cb', '<Cmd>CEAddLibrary<CR>', vim.tbl_extend('force', o, { desc = 'CE: Add library' }))
    map('n', '<leader>co', '<Cmd>CEOpenWebsite<CR>', vim.tbl_extend('force', o, { desc = 'CE: Open in website' }))
    map('n', '<leader>cL', '<Cmd>CELoadExample<CR>', vim.tbl_extend('force', o, { desc = 'CE: Load example' }))
    map('n', '<leader>cD', '<Cmd>CEDeleteCache<CR>', vim.tbl_extend('force', o, { desc = 'CE: Clear CE cache' }))

    -- Assembly-window conveniences
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'asm', 'nasm', 'masm' }, -- CE opens asm; cover common fts
      callback = function(ev)
        local b = { buffer = ev.buf, noremap = true, silent = true }
        map('n', 'K', '<Cmd>CEShowTooltip<CR>', vim.tbl_extend('force', b, { desc = 'CE: Show instr tooltip' }))
        --[[ map('n', 'gd', '<Cmd>CEGotoLabel<CR>', vim.tbl_extend('force', b, { desc = 'CE: Go to label' })) ]]
      end,
    })
    -- examples:
    -- :CECompile          -> compile current buffer (pick compiler)
    -- :CECompileRun       -> compile & run (where supported)
    -- :CEOpen             -> open last result window
    -- :CEEditConfig       -> tweak per-language options
  end,
}
