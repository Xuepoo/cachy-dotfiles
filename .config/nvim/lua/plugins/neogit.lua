return {
  -- Neogit - Git TUI (Magit alternative)
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
    opts = {
      -- How to open
      kind = "split_above",
      -- Integrate diffview
      integrations = {
        diffview = true,
      },
      -- Sign configurations
      signs = {
        section = { "▸", "▾" },
        item = { "▸", "▾" },
        hunk = { "", "" },
      },
      -- Status display
      status = {
        recent_commit_count = 10,
      },
      -- Commit editor
      commit_editor = {
        kind = "split",
      },
      -- Rebase editor
      rebase_editor = {
        kind = "split",
      },
    },
    keys = {
      -- Open Neogit
      {
        "<leader>gg",
        function()
          require("neogit").open()
        end,
        desc = "Open Neogit",
      },
      -- Open Neogit (repository root)
      {
        "<leader>gG",
        function()
          require("neogit").open { kind = "tab" }
        end,
        desc = "Open Neogit (tab)",
      },
    },
  },
}
