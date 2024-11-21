require("mason-null-ls").setup({
  ensure_installed = { "jq", "eslint" },
})

local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.eslint,
    null_ls.builtins.diagnostics.eslint,
  },
})
