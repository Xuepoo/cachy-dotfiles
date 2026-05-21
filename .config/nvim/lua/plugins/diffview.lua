return {
  -- Diffview.nvim - Git diff viewer
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose", "DiffviewToggleFiles" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      use_icons = true,
      icons = {
        folder_closed = "",
        folder_open = "",
      },
      view = {
        default = {
          winbar_info = true,
        },
      },
      file_panel = {
        win_config = {
          height = 20,
        },
      },
      enhanced_diff_hl = true,
    },
    keys = {
      -- Open Diffview (current changes)
      {
        "<leader>Do",
        function()
          vim.ui.input({ prompt = "Diff refs (ex. main..feature): " }, function(refs)
            if refs and refs ~= "" then
              require("diffview").open(refs)
            else
              require("diffview").open()
            end
          end)
        end,
        desc = "Open Diffview",
      },
      -- Open Diffview (simplified mode)
      {
        "<leader>Ds",
        function()
          require("diffview").open { args = { "--imply-local" } }
        end,
        desc = "Open Diffview (simplified)",
      },
      -- Close Diffview
      {
        "<leader>Dc",
        function()
          require("diffview").close()
        end,
        desc = "Close Diffview",
      },
      -- Toggle file panel
      {
        "<leader>Dt",
        function()
          vim.cmd "DiffviewToggleFiles"
        end,
        desc = "Toggle Files Panel",
      },
      -- File history
      {
        "<leader>Dh",
        function()
          vim.ui.input({ prompt = "File (empty for current): " }, function(file)
            require("diffview").file_history(file or nil)
          end)
        end,
        desc = "File History",
      },
    },
  },
}
