require("mason-null-ls").setup({
  ensure_installed = { "jq", "stylua" },
})

local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua,
  },
})
