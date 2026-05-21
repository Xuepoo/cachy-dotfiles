return {
  -- Oil.nvim - File explorer replacing nvim-tree
  {
    "stevearc/oil.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      -- Default file explorer configuration
      default_file_explorer = true,
      -- Delete to trash
      delete_to_trash = true,
      -- Skip confirmation for simple edits
      skip_confirm_for_simple_edits = true,
      -- View options
      view_options = {
        show_hidden = true,
        -- Natural order
        natural_order = true,
      },
      -- Float window configuration
      float = {
        padding = 5,
        max_width = 120,
        max_height = 100,
        border = "rounded",
      },
      -- Preview window
      preview = {
        border = "rounded",
      },
      -- Keymaps configuration
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-s>"] = { "actions.select", opts = { vertical = true }, desc = "Open in vertical split" },
        ["<C-h>"] = { "actions.select", opts = { horizontal = true }, desc = "Open in horizontal split" },
        ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open in new tab" },
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = { "actions.cd", opts = { scope = "tilde" }, desc = "CD to home" },
        ["q"] = "actions.close",
        ["R"] = "actions.refresh",
        ["H"] = "actions.toggle_hidden",
        ["."] = "actions.toggle_dotfiles",
      },
    },
    config = function(_, opts)
      require("oil").setup(opts)
    end,
    keys = {
      -- Open current directory
      {
        "<leader>e",
        function()
          require("oil").open()
        end,
        desc = "Open Oil File Explorer",
      },
      -- Open directory of the current file
      {
        "-",
        function()
          require("oil").open()
        end,
        desc = "Open Parent Directory",
      },
      -- Open float window
      {
        "<leader>E",
        function()
          require("oil").open_float()
        end,
        desc = "Open Oil Float",
      },
    },
  },
}
