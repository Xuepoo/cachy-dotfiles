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
      -- 关闭 render-markdown 的 latex 转换，交由 Snacks.image 处理终端高清渲染
      latex = {
        enabled = false,
      },
      -- 仅在 Normal 和 Command 模式下渲染，进入 Insert 模式自动显示源码
      render_modes = { "n", "c" },
      -- 建议开启，这样在当前行编辑时能看到公式源码，离开后变回渲染效果
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
    build = function() vim.fn["mkdp#util#install"]() end,
  },
}
