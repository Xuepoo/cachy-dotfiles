return {
  -- Copilot code completion (Keep)
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
  -- OpenCode AI Assistant (CopilotChat alternative)
  {
    "sudo-tee/opencode.nvim",
    cmd = { "Opencode" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      preferred_picker = "snacks",
      default_global_keymaps = false,
      -- Disable default Shift+Tab layout switching mode
      -- Custom re-mappings can be done here if needed
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
