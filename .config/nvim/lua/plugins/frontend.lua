return {
  -- ── 自动闭合 HTML/JSX 标签 ──────────────────────────────────────────
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
        enable_close = true,          -- 自动关闭标签
        enable_rename = true,         -- 自动重命名配对标签
        enable_close_on_slash = false, -- 输入 </> 时自动补全标签名
      },
    },
  },

  -- ── 颜色代码高亮显示 ───────────────────────────────────────────────
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
        RGB = true,       -- #RGB 十六进制颜色
        RRGGBB = true,    -- #RRGGBB 十六进制颜色
        names = false,    -- 不高亮颜色名称如 "Blue"
        RRGGBBAA = true,  -- #RRGGBBAA 十六进制颜色
        rgb_fn = true,    -- CSS rgb() 和 rgba() 函数
        hsl_fn = true,    -- CSS hsl() 和 hsla() 函数
        css = true,       -- 启用所有 CSS 特性
        css_fn = true,    -- 启用所有 CSS *函数*: rgb_fn, hsl_fn
        mode = "background", -- 显示模式: foreground, background, virtualtext
        tailwind = true,  -- 启用 tailwind 颜色
        sass = { enable = true, parsers = { "css" } }, -- 启用 sass 颜色
        virtualtext = "■",
      },
    },
  },

  -- ── 代码检查器 ─────────────────────────────────────────────────────
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      -- 配置每种文件类型的 linter
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

      -- 创建自动命令组
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      -- 在保存和进入缓冲区时自动检查
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      -- 手动触发 lint 的快捷键
      vim.keymap.set("n", "<leader>ll", function()
        lint.try_lint()
      end, { desc = "Trigger linting for current file" })
    end,
  },
}
