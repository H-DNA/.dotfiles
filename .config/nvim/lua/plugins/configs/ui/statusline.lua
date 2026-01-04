-- Nerd Font icons
local icons = {
  git = "\u{e702}",           -- nf-dev-git
  branch = "\u{e725}",        -- nf-dev-git_branch
  error = "\u{f00d}",         -- nf-fa-times
  warning = "\u{f071}",       -- nf-fa-warning
  folder = "\u{f07b}",        -- nf-fa-folder
  folder_open = "\u{f07c}",   -- nf-fa-folder_open
  separator = "\u{e0b1}",     -- nf-pl-left_soft_divider
}

-- Cache git root per buffer
local git_root_cache = {}

local function get_git_root()
  local bufnr = vim.api.nvim_get_current_buf()
  if git_root_cache[bufnr] == nil then
    local root = vim.fn.systemlist("git rev-parse --show-toplevel 2>/dev/null")[1]
    git_root_cache[bufnr] = (root and root ~= "") and root or vim.fn.getcwd()
  end
  return git_root_cache[bufnr]
end

-- Clear cache when buffer is deleted
vim.api.nvim_create_autocmd("BufDelete", {
  callback = function(args)
    git_root_cache[args.buf] = nil
  end,
})

-- Highlight groups for file status per mode
local function setup_file_highlights()
  local modes = { "normal", "insert", "visual", "replace", "command", "terminal", "inactive" }
  for _, mode in ipairs(modes) do
    local lualine_hl = vim.api.nvim_get_hl(0, { name = "lualine_a_" .. mode })
    local bg = lualine_hl.bg
    vim.api.nvim_set_hl(0, "LualineDirtyFile_" .. mode, {
      fg = "#fabd2f", -- yellow for dirty
      bg = bg,
      bold = true,
    })
    vim.api.nvim_set_hl(0, "LualineNewFile_" .. mode, {
      fg = "#b8bb26", -- green for new/untracked
      bg = bg,
      bold = true,
    })
  end
end

vim.api.nvim_create_autocmd("ColorScheme", { callback = setup_file_highlights })
vim.defer_fn(setup_file_highlights, 100)

-- Get current mode for highlight group
local function get_mode_suffix()
  local mode = vim.fn.mode()
  local mode_map = {
    n = "normal",
    i = "insert",
    v = "visual",
    V = "visual",
    ["\22"] = "visual",
    R = "replace",
    c = "command",
    t = "terminal",
  }
  return mode_map[mode] or "normal"
end

-- Get shortened path relative to git root or cwd, max 3 directories
local function short_path()
  local filepath = vim.fn.expand("%:p")
  if filepath == "" then
    return "[No Name]"
  end
  local root = get_git_root()
  -- Make path relative to root
  local path = filepath
  if vim.startswith(filepath, root) then
    path = filepath:sub(#root + 2) -- +2 to remove trailing slash
  end
  local parts = vim.split(path, "/", { plain = true, trimempty = true })
  local sep = " " .. icons.separator .. " "
  local icon = #parts <= 3 and icons.folder or icons.folder_open
  local display_parts = #parts <= 3 and parts or { parts[#parts - 2], parts[#parts - 1], parts[#parts] }

  -- Check file git status
  local filename = display_parts[#display_parts]
  local gitsigns_status = vim.b.gitsigns_status
  local gitsigns_head = vim.b.gitsigns_head
  local mode_suffix = get_mode_suffix()

  if gitsigns_status and gitsigns_status ~= "" then
    -- File is tracked and has changes (dirty) - yellow
    display_parts[#display_parts] = "%#LualineDirtyFile_" .. mode_suffix .. "#" .. filename .. "%*"
  elseif gitsigns_head and not vim.b.gitsigns_status_dict then
    -- In a git repo but file is untracked (new) - green
    display_parts[#display_parts] = "%#LualineNewFile_" .. mode_suffix .. "#" .. filename .. "%*"
  end

  return icon .. " " .. sep .. table.concat(display_parts, sep)
end

-- Responsive conditions
local function wide_window()
  return vim.fn.winwidth(0) > 80
end

local function medium_window()
  return vim.fn.winwidth(0) > 50
end

-- LSP error count
local function lsp_errors()
  local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
  if errors > 0 then
    return icons.error .. " " .. errors
  end
  return ""
end

-- LSP warning count
local function lsp_warnings()
  local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
  if warnings > 0 then
    return icons.warning .. " " .. warnings
  end
  return ""
end

-- Git branch name
local function git_branch()
  local branch = vim.b.gitsigns_head
  if branch and branch ~= "" then
    return icons.branch .. " " .. branch
  end
  return ""
end

require("lualine").setup({
  options = {
    icons_enabled = false,
    theme = "gruvbox",
    component_separators = { left = "|", right = "|" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = { "NvimTree" },
    },
  },
  sections = {
    lualine_a = { short_path },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {
      { lsp_errors, color = { fg = "#fb4934" }, cond = medium_window },
      { lsp_warnings, color = { fg = "#fabd2f" }, cond = medium_window },
    },
    lualine_y = { { git_branch, cond = wide_window } },
    lualine_z = {},
  },
})
