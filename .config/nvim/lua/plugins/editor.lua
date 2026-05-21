return {
  -- ── Auto-pairs / Quotes Completion ──────────────────────────────────────────────
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true, -- Use treesitter to intelligently determine context
    },
  },

  -- ── Word motion optimization ───────────────────────────────────────────────
  -- Enable w, e, b to recognize camelCase and snake_case
  {
    "chrisgrieser/nvim-spider",
    keys = {
      { "w", "<cmd>lua require('spider').motion('w')<cr>", mode = { "n", "o", "x" }, desc = "Spider-w" },
      { "e", "<cmd>lua require('spider').motion('e')<cr>", mode = { "n", "o", "x" }, desc = "Spider-e" },
      { "b", "<cmd>lua require('spider').motion('b')<cr>", mode = { "n", "o", "x" }, desc = "Spider-b" },
    },
  },

  -- ── Fast Surround manipulation ─────────────────────────────────────────
  -- Usage Examples:
  --   ysiw"  → Surround word with double quotes
  --   cs"'   → Change double quotes to single quotes
  --   ds(    → Delete surrounding parentheses
  --   yss)   → Surround whole line with parentheses
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {},
  },

  -- ── Diagnostics / References List Panel ───────────────────────────────────────────
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {
      modes = {
        lsp = {
          win = { position = "right" }, -- Display LSP references on the right
        },
      },
    },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics" },
      { "<leader>xs", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols (Trouble)" },
      { "<leader>xl", "<cmd>Trouble lsp toggle<cr>", desc = "LSP Definitions / References" },
      { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
    },
  },
}
