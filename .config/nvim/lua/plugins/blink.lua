return {
  -- Blink.cmp - 替代 nvim-cmp
  {
    "saghen/blink.cmp",
    version = "*",
    lazy = false,
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    opts = {
      -- 键位配置
      keymap = {
        preset = "super-tab",
        -- 取消 Tab 接受 Copilot 建议，保持默认行为
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        -- Enter 用于接受补全（保留原默认行为防止直接换行）
        ["<CR>"] = { "select_and_accept", "fallback" },
      },
      -- 外观配置
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
      -- 默认源配置
      sources = {
        default = { "lsp", "buffer", "path", "snippets" },
      },
      -- 签名帮助
    signature = {
      enabled = false,
    },
    },
  },
}
