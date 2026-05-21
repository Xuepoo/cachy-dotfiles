return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "echasnovski/mini.nvim",
    },
    ---@module 'render-markdown'
    opts = {
      -- Disable latex conversion in render-markdown, delegate to Snacks.image for HD terminal rendering
      latex = {
        enabled = false,
      },
      -- Only render in Normal and Command modes, automatically show source in Insert mode
      render_modes = { "n", "c" },
      -- Enable anti_conceal to see math source on current line when editing, reverts when cursor leaves
      anti_conceal = {
        enabled = true,
      },
      html = { enabled = true },
    },
    config = function(_, opts)
      require("render-markdown").setup(opts)
      vim.opt.conceallevel = 2
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
}
