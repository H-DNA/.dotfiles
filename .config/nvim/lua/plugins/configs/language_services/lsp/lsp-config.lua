local lsps = require("plugins.configs.language_services.lsp.utils").lsps

for index = 1, #lsps do
  local lsp_name = lsps[index]
  local lsp_config = require("lspconfig")
  if lsp_name == "denols" then
    lsp_config.denols.setup({
      on_attach = on_attach,
      root_dir = lsp_config.util.root_pattern("deno.json", "deno.jsonc"),
    })
  elseif lsp_name == "ts_ls" then
    local mason_registry = require("mason-registry")
    local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
        .. "/node_modules/@vue/language-server"
    lsp_config.ts_ls.setup({
      init_options = {
        plugins = {
          {
            name = "@vue/typescript-plugin",
            location = vue_language_server_path,
            languages = { "vue" },
          },
        },
      },
      on_attach = on_attach,
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
      filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
      root_dir = lsp_config.util.root_pattern("package.json"),
      single_file_support = false,
    })
  elseif lsp_name == "eslint" then
    lsp_config.eslint.setup({
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
      settings = {
        codeAction = {
          disableRuleComment = {
            enable = true,
            location = "separateLine"
          },
          showDocumentation = {
            enable = true
          }
        },
        format = true,
        codeActionOnSave = {
          enable = false,
          mode = 'all', -- Apply all fixes on save
        },
        run = "onType",
        validate = "on",
      },
      root_dir = function(fname)
        local root = lsp_config.util.root_pattern(
          'eslint.config.js',
          'eslint.config.mjs',
          'eslint.config.cjs'
        )(fname)
        return root
      end,
      on_attach = function(client, bufnr)
        local config_files = {
          client.config.root_dir .. '/eslint.config.cjs',
          client.config.root_dir .. '/eslint.config.mjs',
          client.config.root_dir .. '/eslint.config.cjs',
        }
        if vim.fn.filereadable(config_files[1]) == 0 and vim.fn.filereadable(config_files[2]) == 0 and vim.fn.filereadable(config_files[3]) == 0 then
          vim.notify("No ESLint config file found, detaching server.", vim.log.levels.WARN)
          client.stop()
          return
        end
        on_attach(client, bufnr)
      end,
      single_file_support = false,
    })
  elseif lsp_name == 'ruff' then
    lsp_config.ruff.setup({
      cmd = { 'ruff', 'server' },
      filetypes = { 'python' },
      root_dir = lsp_config.util.root_pattern('pyproject.toml', 'ruff.toml', '.ruff.toml') or
          lsp_config.util.find_git_ancestor(),
      single_file_support = true,
      settings = {},
    })
  else
    lsp_config[lsp_name].setup({
      on_attach = on_attach,
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
    })
  end
end
