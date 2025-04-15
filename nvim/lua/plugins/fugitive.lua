vim.keymap.set('n', '<leader>gs', ':Git<CR>', { silent = true })
vim.keymap.set('n', '<leader>gc', ':Git commit<CR>', { silent = true })
vim.keymap.set('n', '<leader>gl', ':Gclog<CR>', { silent = true })
vim.keymap.set('n', '<leader>gd', ':Gvdiffsplit<CR>', { silent = true })
vim.keymap.set('n', '<leader>gb', ':Git blame<CR>', { silent = true })
vim.keymap.set('n', '<leader>gm', ':Gvdiffsplit origin/main<CR>', { silent = true })
vim.keymap.set('n', '<leader>gw', ':Gwrite<CR>', { silent = true })
vim.keymap.set('n', '<leader>gr', ':Gread<CR>', { silent = true })

return { "tpope/vim-fugitive", name = "fugitive" }
