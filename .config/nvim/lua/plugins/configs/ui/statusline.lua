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
  local sep = icons.separator .. " "
  if #parts <= 3 then
    return icons.folder .. " " .. sep .. table.concat(parts, sep)
  end
  local short_parts = { parts[#parts - 2], parts[#parts - 1], parts[#parts] }
  return icons.folder_open .. " " .. sep .. table.concat(short_parts, sep)
end

-- Check if current file is dirty in git
local function git_dirty()
  local gitsigns_status = vim.b.gitsigns_status
  if gitsigns_status and gitsigns_status ~= "" then
    return icons.git .. " +"
  end
  return ""
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
    lualine_b = { git_dirty },
    lualine_c = {},
    lualine_x = {
      { lsp_errors, color = { fg = "#fb4934" } },
      { lsp_warnings, color = { fg = "#fabd2f" } },
    },
    lualine_y = { git_branch },
    lualine_z = {},
  },
})
