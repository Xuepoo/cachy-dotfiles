return {
  -- Oil.nvim - 替代 nvim-tree
  {
    "stevearc/oil.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      -- 默认文件浏览器配置
      default_file_explorer = true,
      -- 删除到回收站
      delete_to_trash = true,
      -- 简单编辑不确认
      skip_confirm_for_simple_edits = true,
      -- 视图选项
      view_options = {
        show_hidden = true,
        -- 自然排序
        natural_order = true,
      },
      -- 浮动窗口配置
      float = {
        padding = 5,
        max_width = 120,
        max_height = 100,
        border = "rounded",
      },
      -- 预览窗口
      preview = {
        border = "rounded",
      },
      -- 键位配置
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
      -- 打开当前目录
      {
        "<leader>e",
        function()
          require("oil").open()
        end,
        desc = "Open Oil File Explorer",
      },
      -- 打开当前文件所在目录
      {
        "-",
        function()
          require("oil").open()
        end,
        desc = "Open Parent Directory",
      },
      -- 打开浮动窗口
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
