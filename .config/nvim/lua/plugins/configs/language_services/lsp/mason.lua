local lsps = require("plugins.configs.language_services.lsp.utils").lsps

require("mason").setup({
  PATH = "append" -- Prioritize system packages, for Nix
})
require("mason-lspconfig").setup({
  ensure_installed = lsps,
})
