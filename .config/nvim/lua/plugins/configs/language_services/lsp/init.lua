-- lsp keymaps
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
vim.keymap.set("n", "<leader>gi", vim.lsp.buf.references, {})
vim.keymap.set("n", "<leader>gr", vim.lsp.buf.rename, {})
vim.keymap.set("n", "<leader>gh", vim.lsp.buf.hover, {})
vim.keymap.set("n", "<leader>gf", function()
  if vim.fn.exists(':EslintFixAll') ~= 0 then
    vim.cmd('EslintFixAll')
  else
    vim.lsp.buf.format({ async = true })
  end
end, {})
vim.keymap.set("n", "<leader>gs", vim.lsp.buf.document_symbol, {})
vim.keymap.set("n", "<leader>gc", vim.lsp.buf.outgoing_calls, {})
vim.keymap.set("n", "<leader>go", vim.diagnostic.open_float, {})

vim.diagnostic.config({ update_in_insert = true })

-- further configs
require("plugins.configs.language_services.lsp.mason")
require("plugins.configs.language_services.lsp.lsp-config")
