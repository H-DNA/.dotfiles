require("mason-null-ls").setup({
  ensure_installed = { "jq", "stylua", "prettier", "black", "gofumpt" },
})

local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.prettier.with({
      filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "vue", "json", "css", "scss", "html", "yaml", "markdown" },
    }),
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.gofumpt,
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
})
