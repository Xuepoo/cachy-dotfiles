return {
  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "markdown",
        "markdown_inline",
        "latex",
        -- 前端开发相关
        "javascript",
        "typescript",
        "tsx",
        "json",
        "vue",
        "svelte",
        "scss",
      },
    },
  },

  -- 禁用 nvim-cmp 和 LuaSnip，因为我们使用 blink.cmp
  { "hrsh7th/nvim-cmp", enabled = false },
  { "L3MON4D3/LuaSnip", enabled = false },
}
