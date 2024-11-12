vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
  disable_netrw = true,
  hijack_cursor = true,
  view = {
    number = true,
    relativenumber = true,
  },
  renderer = {
    add_trailing = true,
    highlight_opened_files = "all",
    highlight_modified = "all",
    indent_markers = {
      enable = true,
    },
  },
  update_cwd = true,
  update_focused_file = {
    enable = true,
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 500,
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },
  modified = {
    enable = true,
  },
  filters = {
    enable = false,
  },
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
})

vim.keymap.set("n", "<leader>tt", ":NvimTreeFindFileToggle<CR>")
