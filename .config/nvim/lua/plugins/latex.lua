return {
  {
    "lervag/vimtex",
    lazy = false, -- vimtex is best loaded at startup, it handles its own lazy loading
    init = function()
      -- vim.g.vimtex_view_method = "zathura" -- Uncomment if you use Zathura
    end,
  },
}
