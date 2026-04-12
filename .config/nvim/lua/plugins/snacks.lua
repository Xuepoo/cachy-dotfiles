return {
  -- Snacks.nvim - 替代 Telescope、Dashboard、Notifier 等
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      -- Dashboard 配置
      dashboard = {
        preset = {
          keys = {},
        },
      },
      -- Notifier 配置
      notifier = {
        timeout = 3000,
      },
      -- Scope 配置
      scope = {
        show_git = true,
      },
      -- Statuscolumn 配置
      statuscolumn = {
        folds = {
          open = "󰷏 ",
          closed = "󰵿 ",
          show = true,
        },
        git = {
          show = true,
        },
      },
    },
    keys = {
      -- Picker 快捷键
      { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
      { "<leader>fg", function() Snacks.picker.live_grep() end, desc = "Live Grep" },
      { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Find Buffers" },
      { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent Files" },
      { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep (root dir)" },
      { "<leader>sg", function() Snacks.picker.grep_visual() end, desc = "Grep Selection" },
      { "<leader>fh", function() Snacks.picker.help() end, desc = "Find Help" },

      -- Dashboard
      { "<leader>nd", function() Snacks.dashboard() end, desc = "Dashboard" },

      -- Notifier
      { "<leader>un", function() Snacks.notifier.show_history() end, desc = "Notification History" },

      -- Scope
      { "<leader>us", function() Snacks.scope() end, desc = "Scope" },

      -- Word (拼写检查)
      { "z=", function() Snacks.words() end, desc = " Spelling suggestions" },
    },
  },
}
