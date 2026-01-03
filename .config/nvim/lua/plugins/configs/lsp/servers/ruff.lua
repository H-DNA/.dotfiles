local lspconfig = require("lspconfig")

return {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  root_dir = lspconfig.util.root_pattern("pyproject.toml", "ruff.toml", ".ruff.toml")
    or lspconfig.util.find_git_ancestor(),
  single_file_support = true,
  settings = {},
}
