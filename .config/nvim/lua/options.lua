require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
local opt = vim.opt

opt.relativenumber = true

-- 动态 scrolloff：根据窗口高度设置滚动偏移量
-- 这会让光标保持在屏幕中间 1/3 区域
local function set_dynamic_scrolloff()
  local height = vim.api.nvim_win_get_height(0)
  -- 计算 1/3 窗口高度作为 scrolloff
  local scrolloff_value = math.floor(height / 3)
  vim.wo.scrolloff = scrolloff_value
end

-- 初始设置
set_dynamic_scrolloff()

-- 当窗口大小改变时更新 scrolloff
vim.api.nvim_create_autocmd({ "VimResized", "WinEnter", "BufEnter" }, {
  callback = set_dynamic_scrolloff,
  desc = "动态调整 scrolloff 使光标保持在中间 1/3 区域",
})

-- 不同文件类型的缩进配置
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

    -- 4 空格缩进
    if vim.tbl_contains({
      "lua", "yaml", "toml", "html", "htmldjango", "vue", "svelte",
      "rust", "go", "c", "cpp", "java", "python", "ruby", "php",
      "sh", "bash", "zsh",
    }, filetype) then
      indent_size = 4
    end

    -- 使用 tab 的文件类型
    if vim.tbl_contains({
      "make", "go",
    }, filetype) then
      use_tab = true
    end

    vim.opt_local.shiftwidth = indent_size
    vim.opt_local.tabstop = indent_size
    vim.opt_local.softtabstop = indent_size
    vim.opt_local.expandtab = not use_tab
  end,
  desc = "根据文件类型设置缩进",
})
