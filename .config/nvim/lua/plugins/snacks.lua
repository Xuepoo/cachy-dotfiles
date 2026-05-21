return {
  -- Snacks.nvim - QoL utilities replacing Telescope, Dashboard, Notifier, etc.
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      -- Enable image and math formula rendering support (Ghostty / Kitty Image Protocol)
      image = {
        force_kitty = true,
        enabled = true,
        doc = {
          enabled = true,
          inline = true,
          float = true,
        },
        math = {
          enabled = true,
        },
      },
      -- Dashboard configuration
      dashboard = {
        preset = {
          keys = {},
        },
      },
      -- Notifier configuration
      notifier = {
        timeout = 3000,
      },
      -- Scope configuration
      scope = {
        show_git = true,
      },
      -- Statuscolumn configuration
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
      -- Picker keymaps
      {
        "<leader>ff",
        function()
          Snacks.picker.files()
        end,
        desc = "Find Files",
      },
      {
        "<leader>fg",
        function()
          Snacks.picker.live_grep()
        end,
        desc = "Live Grep",
      },
      {
        "<leader>fb",
        function()
          Snacks.picker.buffers()
        end,
        desc = "Find Buffers",
      },
      {
        "<leader>fr",
        function()
          Snacks.picker.recent()
        end,
        desc = "Recent Files",
      },
      {
        "<leader>/",
        function()
          Snacks.picker.grep()
        end,
        desc = "Grep (root dir)",
      },
      {
        "<leader>sg",
        function()
          Snacks.picker.grep_visual()
        end,
        desc = "Grep Selection",
      },
      {
        "<leader>fh",
        function()
          Snacks.picker.help()
        end,
        desc = "Find Help",
      },

      -- Dashboard
      {
        "<leader>nd",
        function()
          Snacks.dashboard()
        end,
        desc = "Dashboard",
      },

      -- Notifier
      {
        "<leader>un",
        function()
          Snacks.notifier.show_history()
        end,
        desc = "Notification History",
      },

      -- Scope
      {
        "<leader>us",
        function()
          Snacks.scope()
        end,
        desc = "Scope",
      },

      -- Word (Spell checking)
      {
        "z=",
        function()
          Snacks.words()
        end,
        desc = " Spelling suggestions",
      },
    },
  },
}
