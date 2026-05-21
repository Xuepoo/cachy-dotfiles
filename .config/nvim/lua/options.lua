require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
local opt = vim.opt

opt.relativenumber = true
opt.conceallevel = 2 -- Required for plugins like Snacks.image to hide text and show images

-- Cursor settings: ensure character under block cursor is visible
-- n-v-c: block, i: vertical bar
-- Add blend=20 (if terminal supports it) or use highlight group reverse
vim.opt.guicursor = "n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor/lCursor,r-cr:hor20,o:hor50"
vim.api.nvim_set_hl(0, "Cursor", { reverse = true })

-- Dynamic scrolloff: set scroll offset based on window height
-- Keep cursor in the middle 1/2 region of the screen (leave 1/4 at top and bottom)
local function set_dynamic_scrolloff()
  local height = vim.api.nvim_win_get_height(0)
  local scrolloff_value = math.floor(height / 4)
  vim.opt.scrolloff = scrolloff_value
end

-- Execute once immediately
set_dynamic_scrolloff()

-- Ensure scrolloff is updated in various contexts
vim.api.nvim_create_autocmd({ "VimResized", "BufEnter", "WinEnter" }, {
  callback = set_dynamic_scrolloff,
  desc = "Dynamically adjust scrolloff to keep cursor in the middle 1/2 area of the screen",
})

-- Indentation configuration for different file types
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "lua",
    "yaml",
    "toml",
    "json",
    "jsonc",
    "xml",
    "html",
    "htmldjango",
    "css",
    "scss",
    "sass",
    "less",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "vue",
    "svelte",
    "rust",
    "go",
    "c",
    "cpp",
    "java",
    "python",
    "ruby",
    "php",
    "sh",
    "bash",
    "zsh",
    "markdown",
    "markdown_inline",
    "vim",
  },
  callback = function(args)
    local filetype = args.match
    local indent_size = 2
    local use_tab = false

    -- Only the following filetypes use 4-space indentation
    if
      vim.tbl_contains({
        "rust",
        "c",
        "cpp",
        "java",
        "python",
        "ruby",
        "php",
        "sh",
        "bash",
        "zsh",
      }, filetype)
    then
      indent_size = 4
    end

    -- Filetypes that use actual tabs
    if vim.tbl_contains({
      "make",
      "go",
    }, filetype) then
      use_tab = true
      indent_size = 4 -- Go recommended tab stop size is 4
    end

    vim.opt_local.shiftwidth = indent_size
    vim.opt_local.tabstop = indent_size
    vim.opt_local.softtabstop = indent_size
    vim.opt_local.expandtab = not use_tab
  end,
  desc = "Set indentation size based on filetype",
})
