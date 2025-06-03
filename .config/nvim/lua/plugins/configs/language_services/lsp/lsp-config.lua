local lsps = require("plugins.configs.language_services.lsp.utils").lsps

for index = 1, #lsps do
  local lsp_name = lsps[index]
  local lsp_config = require("lspconfig")
  if lsp_name == "denols" then
    lsp_config.denols.setup({
      root_dir = lsp_config.util.root_pattern("deno.json", "deno.jsonc"),
    })
  elseif lsp_name == "texlab" then
    lsp_config.texlab.setup({
      settings = {
        texlab = {
          bibtexFormatter = "texlab",
          build = {
            args = {
              "-pdf",
              "-interaction=nonstopmode",
              "-synctex=1",
              "-pvc", -- Enable continuous preview mode
              "%f"
            },
            executable = "latexmk",
            forwardSearchAfter = true, -- Enable forward search after build
            onSave = true              -- Build on save (set to true for live preview)
          },
          chktex = {
            onEdit = true,
            onOpenAndSave = true -- Enable syntax checking
          },
          diagnosticsDelay = 300,
          formatterLineLength = 80,
          forwardSearch = {
            executable = "zathura",
            args = { "--synctex-forward", "%l:1:%f", "%p" }
          },
          latexFormatter = "latexindent",
          latexindent = {
            modifyLineBreaks = false
          }
        }
      }
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
  elseif lsp_name == "tinymist" then
    lsp_config.tinymist.setup({
      root_dir = lsp_config.util.root_pattern('main.typ') or
          lsp_config.util.find_git_ancestor(),
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
    })
  else
    lsp_config[lsp_name].setup({
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
    })
  end
end
