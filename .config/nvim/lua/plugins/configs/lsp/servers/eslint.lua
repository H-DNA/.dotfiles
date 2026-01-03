local lspconfig = require("lspconfig")

return {
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
  settings = {
    codeAction = {
      disableRuleComment = { enable = true, location = "separateLine" },
      showDocumentation = { enable = true },
    },
    format = true,
    codeActionOnSave = { enable = false, mode = "all" },
    run = "onType",
    validate = "on",
  },
  root_dir = function(fname)
    return lspconfig.util.root_pattern(
      "eslint.config.js",
      "eslint.config.mjs",
      "eslint.config.cjs",
      "eslint.config.ts",
      ".eslintrc.json",
      ".eslintrc.cjs",
      ".eslintrc.mjs",
      ".eslintrc.js"
    )(fname)
  end,
  on_attach = function(client, bufnr)
    local config_files = {
      client.config.root_dir .. "/eslint.config.js",
      client.config.root_dir .. "/eslint.config.mjs",
      client.config.root_dir .. "/eslint.config.cjs",
      client.config.root_dir .. "/eslint.config.ts",
      client.config.root_dir .. "/.eslintrc.json",
      client.config.root_dir .. "/.eslintrc.js",
      client.config.root_dir .. "/.eslintrc.cjs",
      client.config.root_dir .. "/.eslintrc.mjs",
    }
    local has_config = false
    for _, file in ipairs(config_files) do
      if vim.fn.filereadable(file) == 1 then
        has_config = true
        break
      end
    end
    if not has_config then
      vim.notify("No ESLint config file found, detaching server.", vim.log.levels.WARN)
      client.stop()
    end
  end,
  single_file_support = false,
}
