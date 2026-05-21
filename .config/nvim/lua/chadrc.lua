-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "tundra",
  -- Enable transparent background
  transparency = true,
  -- Custom highlights
  hl_override = {
    -- Italic comments
    Comment = { italic = true },
    ["@comment"] = { italic = true },
    -- Fully transparent
    Normal = { bg = "NONE" },
    NormalFloat = { bg = "NONE" },
    SignColumn = { bg = "NONE" },
    -- File tree transparent
    NvimTreeNormal = { bg = "NONE" },
    NvimTreeNormalNC = { bg = "NONE" },
    -- Telescope transparent
    TelescopeNormal = { bg = "NONE" },
    TelescopeBorder = { bg = "NONE" },
    -- Darken relative line numbers
    LineNr = { fg = "light_grey" },
  },
}

M.ui = {
  statusline = {
    theme = "minimal",
    separator_style = "round",
  },
}

-- Disable default plugins, use custom alternatives
M.plugins = {
  disabled = {
    -- Alternative: snacks.nvim
    "nvim-telescope/telescope.nvim",
    "telescope.nvim",
    -- Alternative: blink.cmp
    "nvim-cmp",
    "cmp-nvim-lsp",
    "cmp-buffer",
    "cmp-nvim-lua",
    "cmp_luasnip",
    "cmp-async-path",
    -- Alternative: oil.nvim
    "nvim-tree/nvim-tree.lua",
    "nvim-tree.lua",
  },
}

-- hl_override = {
-- 	Comment = { italic = true },
-- 	["@comment"] = { italic = true },
--   },
-- }

-- M.nvdash = { load_on_startup = true }
-- M.ui = {
--       tabufline = {
--          lazyload = false
--      }
-- }

return M
