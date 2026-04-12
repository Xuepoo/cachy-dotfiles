-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "tundra",
  -- 启用透明背景
  transparency = true,
  -- 自定义高亮
  hl_override = {
    -- 注释斜体
    Comment = { italic = true },
    ["@comment"] = { italic = true },
    -- 完全透明
    Normal = { bg = "NONE" },
    NormalFloat = { bg = "NONE" },
    SignColumn = { bg = "NONE" },
    -- 文件树透明
    NvimTreeNormal = { bg = "NONE" },
    NvimTreeNormalNC = { bg = "NONE" },
    -- Telescope 透明
    TelescopeNormal = { bg = "NONE" },
    TelescopeBorder = { bg = "NONE" },
    -- 相对行号加深
    LineNr = { fg = "light_grey" },
  },
}

M.ui = {
  statusline = {
    theme = "minimal",
    separator_style = "round",
  },
}

-- 禁用默认插件，使用自定义替代方案
M.plugins = {
  disabled = {
    -- 替代方案: snacks.nvim
    "nvim-telescope/telescope.nvim",
    "telescope.nvim",
    -- 替代方案: blink.cmp
    "nvim-cmp",
    "cmp-nvim-lsp",
    "cmp-buffer",
    "cmp-nvim-lua",
    "cmp_luasnip",
    "cmp-async-path",
    -- 替代方案: oil.nvim
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
