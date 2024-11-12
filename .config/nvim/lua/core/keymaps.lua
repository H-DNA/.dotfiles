vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.backspace = "2"
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
vim.opt.clipboard:append("unnamedplus")

vim.keymap.set("n", "<c-s>v", "<c-w>v")
vim.keymap.set("n", "<c-s>h", "<c-w>s")
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

-- keymaps for buffer workflow
vim.api.nvim_set_keymap("n", "<C-b>", ":buffers<CR>:buffer<Space>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>bd", ":bd<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-d>", ":buffers<CR>:bd<Space>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[b", ":bprev<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "]b", ":bnext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[B", ":bfirst<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "]B", ":blast<CR>", { noremap = true, silent = true })

-- command copy file path to clipboard
vim.cmd([[command! CopyFilePath let @+ = expand('%:p')]])
