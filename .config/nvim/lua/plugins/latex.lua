return {
  {
    "lervag/vimtex",
    lazy = false, -- vimtex is best loaded at startup, it handles its own lazy loading
    init = function()
      -- Use Zathura as PDF viewer
      vim.g.vimtex_view_method = "zathura"
      -- Enable inverse search
      vim.g.vimtex_view_general_viewer = "zathura"
      -- Set compiler (latexmk is highly recommended, included in texlive-most)
      vim.g.vimtex_compiler_method = "latexmk"
    end,
  },
}
