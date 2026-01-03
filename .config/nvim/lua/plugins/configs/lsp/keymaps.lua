vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, {})
vim.keymap.set("n", "<leader>li", vim.lsp.buf.references, {})
vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, {})
vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, {})
vim.keymap.set("n", "<leader>lf", function()
  if vim.fn.exists(":EslintFixAll") ~= 0 then
    vim.cmd("EslintFixAll")
  else
    vim.lsp.buf.format({ async = true })
  end
end, {})
vim.keymap.set("n", "<leader>ls", vim.lsp.buf.document_symbol, {})
vim.keymap.set("n", "<leader>lc", vim.lsp.buf.outgoing_calls, {})
vim.keymap.set("n", "<leader>lo", vim.diagnostic.open_float, {})

vim.diagnostic.config({ update_in_insert = true })
