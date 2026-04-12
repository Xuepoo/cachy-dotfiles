return {
  -- ── 自动括号/引号补全 ──────────────────────────────────────────────
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true, -- 使用 treesitter 智能判断上下文
    },
  },

  -- ── Git 行级变更标记 ───────────────────────────────────────────────
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts = {
      signs = {
        add          = { text = "▎" },
        change       = { text = "▎" },
        delete       = { text = "" },
        topdelete    = { text = "" },
        changedelete = { text = "▎" },
        untracked    = { text = "▎" },
      },
      on_attach = function(buf)
        local gs = package.loaded.gitsigns
        local map = vim.keymap.set

        -- Hunk 跳转
        map("n", "]h", gs.next_hunk,  { buffer = buf, desc = "Next Git Hunk" })
        map("n", "[h", gs.prev_hunk,  { buffer = buf, desc = "Prev Git Hunk" })

        -- Hunk 操作
        map("n", "<leader>hs", gs.stage_hunk,        { buffer = buf, desc = "Stage Hunk" })
        map("n", "<leader>hr", gs.reset_hunk,        { buffer = buf, desc = "Reset Hunk" })
        map("n", "<leader>hu", gs.undo_stage_hunk,   { buffer = buf, desc = "Undo Stage Hunk" })
        map("n", "<leader>hS", gs.stage_buffer,      { buffer = buf, desc = "Stage Buffer" })
        map("n", "<leader>hR", gs.reset_buffer,      { buffer = buf, desc = "Reset Buffer" })

        -- 查看差异 & blame
        map("n", "<leader>hb", function() gs.blame_line { full = true } end, { buffer = buf, desc = "Blame Line" })
        map("n", "<leader>hd", gs.diffthis,          { buffer = buf, desc = "Diff This" })
        map("n", "<leader>hD", function() gs.diffthis "~" end, { buffer = buf, desc = "Diff This ~" })

        -- 选中 hunk（文本对象）
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { buffer = buf, desc = "Select Hunk" })
      end,
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
