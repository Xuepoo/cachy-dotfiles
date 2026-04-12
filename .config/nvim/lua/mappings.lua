require "nvchad.mappings"

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if vim.bo.filetype == "opencode" then
      vim.keymap.set("n", "<S-Tab>", "<cmd>Opencode cycle_mode<cr>", { buffer = true, desc = "Opencode cycle mode" })
    else
      vim.keymap.set("n", "<S-Tab>", "<cmd>lua require('nvchad.tabufline').prev()<cr>", { buffer = true, desc = "Previous buffer" })
    end
  end,
})

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Insert Mode 映射
-- 使用 <Left>, <Down>, <Up>, <Right> 以保持 Insert 状态
map('i', '<C-h>', '<Left>', { noremap = true, desc = 'Move cursor left' })
map('i', '<C-j>', '<Down>', { noremap = true, desc = 'Move cursor down' })
map('i', '<C-k>', '<Up>', { noremap = true, desc = 'Move cursor up' })
map('i', '<C-l>', '<Right>', { noremap = true, desc = 'Move cursor right' })

-- 快速切换缩进为 2
vim.keymap.set('n', '<leader>t2', ':setlocal ts=2 sw=2 sts=2 et<CR>', { desc = "Set indent to 2" })
-- 快速切换缩进为 4
vim.keymap.set('n', '<leader>t4', ':setlocal ts=4 sw=4 sts=4 et<CR>', { desc = "Set indent to 4" })

-- 禁用原来的水平/垂直终端快捷键
vim.keymap.del("n", "<leader>h")
vim.keymap.del("n", "<leader>v")

-- 禁用x键位的复制
map("n", "x", '"_x', { noremap = true, silent = true })
map("v", "x", '"_x', { noremap = true, silent = true })
map({"n", "v"}, "s", '"_s', { noremap = true, silent = true })

-- 基础分屏
map("n", "<leader>h", "<cmd>split<cr>", { desc = "Split horizontal" })
map("n", "<leader>v", "<cmd>vsplit<cr>", { desc = "Split vertical" })

-- 关闭当前窗口
map("n", "<leader>c", "<cmd>close<cr>", { desc = "Close window" })

-- 只保留当前窗口（关闭其他所有窗口）
map("n", "<leader>bo", "<cmd>only<cr>", { desc = "Close other windows" })

-- 窗口交换位置
map("n", "<leader>wH", "<C-w>H", { desc = "Move window to left" })
map("n", "<leader>wJ", "<C-w>J", { desc = "Move window to bottom" })
map("n", "<leader>wK", "<C-w>K", { desc = "Move window to top" })
map("n", "<leader>wL", "<C-w>L", { desc = "Move window to right" })

-- 窗口旋转
map("n", "<leader>wr", "<C-w>r", { desc = "Rotate windows downward" })
map("n", "<leader>wR", "<C-w>R", { desc = "Rotate windows upward" })

map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

map("n", "<leader>th", function()
  require("nvchad.term").new { pos = "sp", size = 0.3 }  -- size 是高度比例
end, { desc = "New horizontal terminal" })

map("n", "<leader>tv", function()
  require("nvchad.term").new { pos = "vsp", size = 0.4 }  -- size 是宽度比例
end, { desc = "New vertical terminal" })

map("n", "<leader>tf", function()
  require("nvchad.term").new { pos = "float" }
end, { desc = "New floating terminal" })
-- Ctrl+e: 跳转到下一个单词尾部
map("i", "<C-e>", "<C-o>e<C-o>a", { desc = "Jump to end of next word" })

-- Ctrl+b: 跳转到上一个单词开头
map("i", "<C-b>", "<C-o>b", { desc = "Jump to beginning of previous word" })

-- Ctrl+w: 跳转到下一个单词开头
map("i", "<C-w>", "<C-o>w", { desc = "Jump to beginning of next word" })

-- Ctrl+Shift+e: 跳转到下一个 WORD 尾部（以空格分隔）
map("i", "<C-S-e>", "<C-o>E<C-o>a", { desc = "Jump to end of next WORD" })

-- Ctrl+Shift+b: 跳转到上一个 WORD 开头
map("i", "<C-S-b>", "<C-o>B", { desc = "Jump to beginning of previous WORD" })

-- Ctrl+Shift+w: 跳转到下一个 WORD 开头
map("i", "<C-S-w>", "<C-o>W", { desc = "Jump to beginning of next WORD" })


-- 格式化代码
map({ "n", "v" }, "<leader>fm", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format code" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
