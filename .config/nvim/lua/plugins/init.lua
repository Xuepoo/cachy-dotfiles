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
        -- Frontend development
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

  -- Disable nvim-cmp and LuaSnip since we use blink.cmp
  { "hrsh7th/nvim-cmp", enabled = false },
  { "L3MON4D3/LuaSnip", enabled = false },
}
