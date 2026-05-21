return {
  -- Vim-Dadbod - Database backend
  {
    "tpope/vim-dadbod",
    lazy = false,
  },
  -- Vim-Dadbod-UI - Database UI
  {
    "kristijanhusak/vim-dadbod-ui",
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIChangeConnection" },
    dependencies = {
      "tpope/vim-dadbod",
      "kristijanhusak/vim-dadbod-completion",
    },
    init = function()
      -- Configure Database UI
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_show_database_icon = true
      -- Save location
      vim.g.db_ui_save_location = vim.fn.stdpath "data" .. "/dadbod/"
    end,
    opts = {},
    keys = {
      -- Open Database UI
      {
        "<leader>db",
        "<cmd>DBUI<cr>",
        desc = "Toggle Database UI",
      },
      -- Quick connect
      {
        "<leader>dbs",
        function()
          vim.ui.input({ prompt = "DB URL: " }, function(input)
            if input then
              vim.g.db_url = input
              vim.cmd "DBUI"
            end
          end)
        end,
        desc = "Quick Connect to DB",
      },
    },
  },
  -- Vim-Dadbod-Completion - Autocompletion
  {
    "kristijanhusak/vim-dadbod-completion",
    dependencies = { "tpope/vim-dadbod" },
    ft = { "sql", "mysql", "postgres" },
    init = function()
      vim.g.db_completion = 1
    end,
  },
}
