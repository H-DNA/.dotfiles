return {
  "pwntester/octo.nvim",
  cmd = "Octo",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    suppress_missing_scope = {
      projects_v2 = true,
    },
  },
  keys = {
    { "<leader>gp", "<cmd>Octo pr list<cr>", desc = "List PRs" },
    { "<leader>gi", "<cmd>Octo issue list<cr>", desc = "List issues" },
    { "<leader>gr", "<cmd>Octo review start<cr>", desc = "Start review" },
  },
}
