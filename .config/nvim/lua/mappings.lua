require "nvchad.mappings"

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if vim.bo.filetype == "opencode" then
      vim.keymap.set("n", "<S-Tab>", "<cmd>Opencode cycle_mode<cr>", { buffer = true, desc = "Opencode cycle mode" })
    else
      vim.keymap.set(
        "n",
        "<S-Tab>",
        "<cmd>lua require('nvchad.tabufline').prev()<cr>",
        { buffer = true, desc = "Previous buffer" }
      )
    end
  end,
})

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Insert Mode Mappings
-- Use <Left>, <Down>, <Up>, <Right> to stay in Insert mode
map("i", "<C-h>", "<Left>", { noremap = true, desc = "Move cursor left" })
map("i", "<C-j>", "<Down>", { noremap = true, desc = "Move cursor down" })
map("i", "<C-k>", "<Up>", { noremap = true, desc = "Move cursor up" })
map("i", "<C-l>", "<Right>", { noremap = true, desc = "Move cursor right" })

-- Fast switch indentation to 2
vim.keymap.set("n", "<leader>t2", ":setlocal ts=2 sw=2 sts=2 et<CR>", { desc = "Set indent to 2" })
-- Fast switch indentation to 4
vim.keymap.set("n", "<leader>t4", ":setlocal ts=4 sw=4 sts=4 et<CR>", { desc = "Set indent to 4" })

-- Disable legacy horizontal/vertical terminal keymaps
vim.keymap.del("n", "<leader>h")
vim.keymap.del("n", "<leader>v")

-- Prevent copying to clipboard when using 'x'
map("n", "x", '"_x', { noremap = true, silent = true })
map("v", "x", '"_x', { noremap = true, silent = true })
map({ "n", "v" }, "s", '"_s', { noremap = true, silent = true })

-- Basic splits
map("n", "<leader>h", "<cmd>split<cr>", { desc = "Split horizontal" })
map("n", "<leader>v", "<cmd>vsplit<cr>", { desc = "Split vertical" })

-- Close current window
map("n", "<leader>c", "<cmd>close<cr>", { desc = "Close window" })

-- Only keep current window (close all other windows)
map("n", "<leader>bo", "<cmd>only<cr>", { desc = "Close other windows" })

-- Move windows
map("n", "<leader>wH", "<C-w>H", { desc = "Move window to left" })
map("n", "<leader>wJ", "<C-w>J", { desc = "Move window to bottom" })
map("n", "<leader>wK", "<C-w>K", { desc = "Move window to top" })
map("n", "<leader>wL", "<C-w>L", { desc = "Move window to right" })

-- Rotate windows
map("n", "<leader>wr", "<C-w>r", { desc = "Rotate windows downward" })
map("n", "<leader>wR", "<C-w>R", { desc = "Rotate windows upward" })

map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

map("n", "<leader>th", function()
  require("nvchad.term").new { pos = "sp", size = 0.3 } -- size is height ratio
end, { desc = "New horizontal terminal" })

map("n", "<leader>tv", function()
  require("nvchad.term").new { pos = "vsp", size = 0.4 } -- size is width ratio
end, { desc = "New vertical terminal" })

map("n", "<leader>tf", function()
  require("nvchad.term").new { pos = "float" }
end, { desc = "New floating terminal" })
-- Ctrl+e: Jump to the end of next word
map("i", "<C-e>", "<C-o>e<C-o>a", { desc = "Jump to end of next word" })

-- Ctrl+b: Jump to the beginning of previous word
map("i", "<C-b>", "<C-o>b", { desc = "Jump to beginning of previous word" })

-- Ctrl+w: Jump to the beginning of next word
map("i", "<C-w>", "<C-o>w", { desc = "Jump to beginning of next word" })

-- Ctrl+Shift+e: Jump to the end of next WORD (space-separated)
map("i", "<C-S-e>", "<C-o>E<C-o>a", { desc = "Jump to end of next WORD" })

-- Ctrl+Shift+b: Jump to the beginning of previous WORD
map("i", "<C-S-b>", "<C-o>B", { desc = "Jump to beginning of previous WORD" })

-- Ctrl+Shift+w: Jump to the beginning of next WORD
map("i", "<C-S-w>", "<C-o>W", { desc = "Jump to beginning of next WORD" })

-- Format code
map({ "n", "v" }, "<leader>fm", function()
  require("conform").format { async = true, lsp_fallback = true }
end, { desc = "Format code" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
