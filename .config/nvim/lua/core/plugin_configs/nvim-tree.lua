vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
  disable_netrw = true,
  hijack_cursor = true,
  view = {
    number = true,
    relativenumber = true,
  },
  update_cwd = true,
  git = {
    enable = true,
    ignore = false,
    timeout = 500,
  },
})

vim.keymap.set("n", "<leader>tt", ":NvimTreeFindFileToggle<CR>")
