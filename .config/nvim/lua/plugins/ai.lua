return {
  -- Copilot 代码补全 (保留)
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "BufReadPost",
    opts = {
      suggestion = {
        enabled = not vim.g.ai_cmp,
        auto_trigger = true,
        hide_during_completion = vim.g.ai_cmp,
        keymap = {
          accept = "<Tab>",
          next = "<M-]>",
          prev = "<M-[>",
        },
      },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
  -- OpenCode AI 助手 (替代 CopilotChat)
  {
    "sudo-tee/opencode.nvim",
    cmd = { "Opencode" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      preferred_picker = "snacks",
      default_global_keymaps = false,
      -- 禁用默认的 Shift+Tab 切换模式
      -- 如果需要自定义，可以在这里重新映射
    },
    keys = {
      {
        "<leader>aa",
        "<cmd>Opencode toggle<cr>",
        desc = "Toggle OpenCode Chat",
        mode = { "n", "x" },
      },
      {
        "<leader>aq",
        function()
          vim.ui.input({ prompt = "Ask OpenCode: " }, function(input)
            if input and input ~= "" then
              vim.cmd("Opencode run_new " .. input)
            end
          end)
        end,
        desc = "Quick Ask OpenCode",
        mode = { "n", "x" },
      },
    },
  },
}
