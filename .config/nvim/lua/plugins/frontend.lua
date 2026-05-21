return {
  -- ── Auto-close HTML/JSX tags ──────────────────────────────────────────
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    ft = {
      "html",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "vue",
      "svelte",
      "xml",
    },
    opts = {
      opts = {
        enable_close = true, -- Auto close tags
        enable_rename = true, -- Auto rename paired tags
        enable_close_on_slash = false, -- Auto complete tag name when typing </
      },
    },
  },

  -- ── Color code highlighting ───────────────────────────────────────────────
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
      filetypes = {
        "css",
        "scss",
        "sass",
        "html",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
        "svelte",
        "lua",
      },
      user_default_options = {
        RGB = true, -- #RGB hex colors
        RRGGBB = true, -- #RRGGBB hex colors
        names = false, -- Do not highlight color names like "Blue"
        RRGGBBAA = true, -- #RRGGBBAA hex colors
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features
        css_fn = true, -- Enable all CSS functions: rgb_fn, hsl_fn
        mode = "background", -- Display mode: foreground, background, virtualtext
        tailwind = true, -- Enable tailwind colors
        sass = { enable = true, parsers = { "css" } }, -- Enable sass colors
        virtualtext = "■",
      },
    },
  },

  -- ── Linter ─────────────────────────────────────────────────────
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require "lint"

      -- Configure linter for each filetype
      lint.linters_by_ft = {
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        vue = { "eslint_d" },
        svelte = { "eslint_d" },
        python = { "pylint" },
        -- css = { "stylelint" },
        -- scss = { "stylelint" },
      }

      -- Create autocommand group
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      -- Automatically lint on save and buffer entry
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      -- Keymap to manually trigger linting
      vim.keymap.set("n", "<leader>ll", function()
        lint.try_lint()
      end, { desc = "Trigger linting for current file" })
    end,
  },
}
