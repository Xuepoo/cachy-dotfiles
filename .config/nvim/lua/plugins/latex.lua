return {
  {
    "lervag/vimtex",
    lazy = false, -- vimtex is best loaded at startup, it handles its own lazy loading
    init = function()
      -- 使用 Zathura 作为 PDF 阅读器
      vim.g.vimtex_view_method = "zathura"
      -- 开启反向跳转 (Inverse Search)
      vim.g.vimtex_view_general_viewer = "zathura"
      -- 设置编译器 (latexmk 是最推荐的，texlive-most 已包含)
      vim.g.vimtex_compiler_method = "latexmk"
    end,
  },
}
