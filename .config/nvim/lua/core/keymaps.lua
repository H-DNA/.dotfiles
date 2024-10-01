vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.backspace = '2'
vim.opt.showcmd = true
vim.opt.autowrite = true
vim.opt.cursorline = true
vim.opt.autoread = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.wo.number = true
vim.opt.relativenumber = true

vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
vim.api.nvim_set_keymap("n", "<leader>n", ":ASToggle<CR>", {})
vim.keymap.set('n', '<c-s>v', '<c-w>v')
vim.keymap.set('n', '<c-s>h', '<c-w>s')
