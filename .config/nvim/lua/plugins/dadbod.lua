return {
  -- Vim-Dadbod - 数据库后端
  {
    "tpope/vim-dadbod",
    lazy = false,
  },
  -- Vim-Dadbod-UI - 数据库 UI
  {
    "kristijanhusak/vim-dadbod-ui",
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIChangeConnection" },
    dependencies = {
      "tpope/vim-dadbod",
      "kristijanhusak/vim-dadbod-completion",
    },
    init = function()
      -- 配置数据库 UI
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_show_database_icon = true
      -- 保存位置
      vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/dadbod/"
    end,
    opts = {},
    keys = {
      -- 打开数据库 UI
      {
        "<leader>db",
        "<cmd>DBUI<cr>",
        desc = "Toggle Database UI",
      },
      -- 快速连接
      {
        "<leader>dbs",
        function()
          vim.ui.input({ prompt = "DB URL: " }, function(input)
            if input then
              vim.g.db_url = input
              vim.cmd("DBUI")
            end
          end)
        end,
        desc = "Quick Connect to DB",
      },
    },
  },
  -- Vim-Dadbod-Completion - 自动补全
  {
    "kristijanhusak/vim-dadbod-completion",
    dependencies = { "tpope/vim-dadbod" },
    ft = { "sql", "mysql", "postgres" },
    init = function()
      vim.g.db_completion = 1
    end,
  },
}
