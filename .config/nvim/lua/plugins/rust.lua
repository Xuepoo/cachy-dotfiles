return {
  {
    "mrcjkb/rustaceanvim",
    version = "^7", -- 推荐固定版本以避免破坏性更新
    lazy = false,
    ft = { "rust" }, -- 仅在 Rust 文件加载
  },
}
