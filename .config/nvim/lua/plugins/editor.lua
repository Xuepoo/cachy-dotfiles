return {
  -- ── 自动括号/引号补全 ──────────────────────────────────────────────
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true, -- 使用 treesitter 智能判断上下文
    },
  },

  -- ── 词间跳转优化 ───────────────────────────────────────────────
  -- 让 w, e, b 能识别 camelCase, snake_case
  {
    "chrisgrieser/nvim-spider",
    keys = {
      { "w", "<cmd>lua require('spider').motion('w')<cr>", mode = { "n", "o", "x" }, desc = "Spider-w" },
      { "e", "<cmd>lua require('spider').motion('e')<cr>", mode = { "n", "o", "x" }, desc = "Spider-e" },
      { "b", "<cmd>lua require('spider').motion('b')<cr>", mode = { "n", "o", "x" }, desc = "Spider-b" },
    },
  },

  -- ── 快速包裹/修改包围字符 ─────────────────────────────────────────
  -- 用法示例：
  --   ysiw"  → 给单词加双引号
  --   cs"'   → 把双引号换成单引号
  --   ds(    → 删除括号
  --   yss)   → 给整行加括号
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {},
  },

  -- ── 诊断 / 引用列表面板 ───────────────────────────────────────────
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {
      modes = {
        lsp = {
          win = { position = "right" }, -- LSP 引用显示在右侧
        },
      },
    },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",              desc = "Diagnostics (Trouble)" },
      { "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics" },
      { "<leader>xs", "<cmd>Trouble symbols toggle<cr>",                  desc = "Symbols (Trouble)" },
      { "<leader>xl", "<cmd>Trouble lsp toggle<cr>",                      desc = "LSP Definitions / References" },
      { "<leader>xq", "<cmd>Trouble qflist toggle<cr>",                   desc = "Quickfix List (Trouble)" },
    },
  },
}
