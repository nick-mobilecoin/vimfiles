vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.splitright = true
vim.opt.virtualedit = all
vim.opt.scrolloff = 3
vim.opt.linebreak = true
vim.opt.autowrite = true
vim.opt.textwidth = 80

vim.g.mapleader = " "
vim.g.maplocalleader="\r"
vim.keymap.set('n', '<leader>h', '<c-w>h', { noremap = true})
vim.keymap.set('n', '<leader>j', '<c-w>j', { noremap = true})
vim.keymap.set('n', '<leader>k', '<c-w>k', { noremap = true})
vim.keymap.set('n', '<leader>l', '<c-w>l', { noremap = true})
vim.keymap.set('n', '<leader>sv', ':source $MYVIMRC <cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>ev', ':vsplit $MYVIMRC <cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<esc><esc>', ':nohlsearch<cr>:<esc>', { noremap = true, silent = true })
vim.keymap.set('n', '<Up>', ':cprev<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Down>', ':cnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<localleader>f', ':grep! "\\<<C-r><C-W>\\>"<cr>:cw<cr>', { noremap = true })
vim.keymap.set('n', 's', 'diw"0P', { noremap = true })
vim.keymap.set('n', 'S', ':%s/\\<<C-r><C-w>\\>/<C-r>0/g', { noremap = true })
vim.keymap.set('v', 's', '"0P', { noremap = true })
vim.keymap.set('i', 'jk', '<Esc>', { noremap = true })
vim.keymap.set('n', '<c-p>', ':Files<CR>', { silent = true, noremap = true })
vim.keymap.set('n', 'ci%', [[:s/<C-r><C-w>/\=expand('%:t:r')<CR>]], { noremap = true, silent = true })

if vim.fn.executable('fdfind') == 1 then
    vim.env.FZF_DEFAULT_COMMAND='fdfind --type f'
elseif vim.fn.executable('fd') == 1 then
    vim.env.FZF_DEFAULT_COMMAND='fd --type f'
end

if vim.fn.has('nvim-0.10') == 1 then
    vim.lsp.inlay_hint.enable(true)
end

require("config.lazy")

vim.api.nvim_create_augroup('squash', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
    group = 'squash',
    pattern = 'gitrebase',
    callback = function()
        vim.api.nvim_buf_set_keymap(0, 'n', '<localleader>s', ':2,$s/^pick\\>/fixup/e | :1s/^pick\\>/reword/e<CR>', { noremap = true, silent = true })
    end,
})
vim.cmd.colorscheme "catppuccin-mocha"
