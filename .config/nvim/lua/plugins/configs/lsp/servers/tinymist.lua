local lspconfig = require("lspconfig")

return {
  root_dir = lspconfig.util.root_pattern("main.typ") or lspconfig.util.find_git_ancestor(),
  offset_enconding = "utf-8",
  settings = {
    exportPdf = "onType",
    formatterMode = "typstyle",
    formatterPrintWidth = 80,
    outputPath = "$root/target/$dir/$name",
  },
  on_attach = function(bufnr, client)
    vim.lsp.buf.execute_command({
      command = "tinymist.pinMain",
      arguments = { vim.fs.joinpath(vim.fs.root(0, { "main.typ" }), "main.typ") },
    })
  end,
}
