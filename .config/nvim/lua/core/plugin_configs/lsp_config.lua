local lsps = {
  "lua_ls",
  "rust_analyzer",
  "clangd",
  "cssls",
  "dockerls",
  "eslint",
  "html",
  "marksman",
  "tailwindcss",
  "tsserver",
  "jsonls",
  "pyright",
  "gopls",
  "golangci_lint_ls",
  "volar",
  "volar",
  "sqls",
  "elp",
}

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = lsps,
})
local on_attach = function(_, _)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
  vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
  vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, {})
  vim.keymap.set("n", "<leader>gr", vim.lsp.buf.rename, {})
  vim.keymap.set("n", "<leader>gh", vim.lsp.buf.hover, {})
  vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  vim.diagnostic.config({ update_in_insert = true })
end

for index = 1, #lsps do
  local lsp_name = lsps[index]
  require("lspconfig")[lsp_name].setup({
    on_attach = on_attach,
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
  })
end
