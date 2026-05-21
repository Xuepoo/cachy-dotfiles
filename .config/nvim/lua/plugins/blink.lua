return {
  -- Blink.cmp - Autocompletion plugin replacing nvim-cmp
  {
    "saghen/blink.cmp",
    version = "*",
    lazy = false,
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    opts = {
      -- Keymaps configuration
      keymap = {
        preset = "super-tab",
        -- Cancel Tab key accepting Copilot suggestions, keep default behavior
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        -- Enter key to accept completion (preserves default behavior to prevent accidental newline)
        ["<CR>"] = { "select_and_accept", "fallback" },
      },
      -- Appearance configuration
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
      -- Default sources configuration
      sources = {
        default = { "lsp", "buffer", "path", "snippets" },
      },
      -- Signature help
      signature = {
        enabled = false,
      },
    },
  },
}
