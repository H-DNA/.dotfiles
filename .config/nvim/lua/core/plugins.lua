local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
  use("wbthomason/packer.nvim")
  use("ellisonleao/gruvbox.nvim")
  use("nvim-tree/nvim-tree.lua")
  use("nvim-tree/nvim-web-devicons")
  use("nvim-lualine/lualine.nvim")
  use("nvim-treesitter/nvim-treesitter")
  use("xiyaowong/transparent.nvim")
  use({
    "nvim-telescope/telescope.nvim",
    tag = "0.1.4",
    requires = { { "nvim-lua/plenary.nvim" } },
  })

  -- lsp
  use({
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  })
  use("jose-elias-alvarez/null-ls.nvim")
  use({
    "jay-babu/mason-null-ls.nvim",
    requires = { { "nvimtools/none-ls.nvim" } },
  })
  use("nvim-treesitter/nvim-treesitter-refactor")
  use("https://git.sr.ht/~whynothugo/lsp_lines.nvim")

  -- completion
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-nvim-lsp")
  use("L3MON4D3/LuaSnip")
  use("saadparwaiz1/cmp_luasnip")
  use("rafamadriz/friendly-snippets")

  -- autosave
  use({
    "Pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup({})
    end,
  })

  -- git
  use({
    "kdheepak/lazygit.nvim",
    requires = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("telescope").load_extension("lazygit")
    end,
  })

  use("tpope/vim-fugitive")

  -- discord
  use("andweeb/presence.nvim")

  -- vim-be-good
  use("ThePrimeagen/vim-be-good")

  -- vim-tmux-navigation
  use("christoomey/vim-tmux-navigator")

  if packer_bootstrap then
    require("packer").sync()
  end
end)
