return {
  -- Neogit - Git TUI (类似 Magit)
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
    opts = {
      -- 打开方式
      kind = "split_above",
      -- 集成 diffview
      integrations = {
        diffview = true,
      },
      -- 符号配置
      signs = {
        section = { "▸", "▾" },
        item = { "▸", "▾" },
        hunk = { "", "" },
      },
      -- 状态显示
      status = {
        recent_commit_count = 10,
      },
      -- 提交编辑器
      commit_editor = {
        kind = "split",
      },
      -- 变基编辑器
      rebase_editor = {
        kind = "split",
      },
    },
    keys = {
      -- 打开 Neogit
      {
        "<leader>gg",
        function()
          require("neogit").open()
        end,
        desc = "Open Neogit",
      },
      -- 打开 Neogit (仓库根目录)
      {
        "<leader>gG",
        function()
          require("neogit").open({ kind = "tab" })
        end,
        desc = "Open Neogit (tab)",
      },
    },
  },
}
