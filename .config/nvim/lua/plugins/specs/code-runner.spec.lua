return {
  "CRAG666/code_runner.nvim",
  cmd = { "RunCode", "RunFile", "RunProject" },
  keys = {
    { "<leader>r", "<cmd>RunCode<cr>", desc = "Run code" },
    { "<leader>rf", "<cmd>RunFile<cr>", desc = "Run file" },
    { "<leader>rp", "<cmd>RunProject<cr>", desc = "Run project" },
  },
  config = function()
    require("code_runner").setup({
      filetype = {
        python = "python3 -u",
        javascript = "node",
        typescript = "npx ts-node",
        lua = "lua",
        rust = "cargo run",
        go = "go run",
        c = "gcc -o /tmp/a.out $file && /tmp/a.out",
        cpp = "g++ -o /tmp/a.out $file && /tmp/a.out",
        java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
        sh = "bash",
        ruby = "ruby",
        php = "php",
        coq = "coqc $file",
      },
      mode = "term",
      focus = true,
      startinsert = true,
    })
  end,
}
