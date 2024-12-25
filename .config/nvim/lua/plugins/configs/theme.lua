-- colortheme - gruvbox
vim.o.termguicolors = true
vim.cmd([[ colorscheme gruvbox ]])

-- status line - lualine
require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "gruvbox",
  },
  sections = {
    lualine_a = {
      {
        "filename",
        path = 1,
      },
    },
  },
})

-- transparent background
require("transparent").setup({
  groups = {
    "Normal",
    "NormalNC",
    "Comment",
    "Constant",
    "Special",
    "Identifier",
    "Statement",
    "PreProc",
    "Type",
    "Underlined",
    "Todo",
    "String",
    "Function",
    "Conditional",
    "Repeat",
    "Operator",
    "Structure",
    "LineNr",
    "NonText",
    "SignColumn",
    "CursorLine",
    "CursorLineNr",
    "StatusLine",
    "StatusLineNC",
    "EndOfBuffer",
  },
  extra_groups = {},
  exclude_groups = {},
  on_clear = function() end,
})
