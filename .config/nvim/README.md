# Neovim 配置 (NvChad)

基于 NvChad v2.5 的个人配置，使用了更现代的插件替代方案。

## 插件列表

### AI

| 插件          | 说明                       |
| ------------- | -------------------------- |
| copilot.lua   | 代码补全                   |
| opencode.nvim | AI 助手 (替代 CopilotChat) |

### UI / 体验

| 插件                 | 说明                                |
| -------------------- | ----------------------------------- |
| snacks.nvim          | 替代 Telescope、Dashboard、Notifier |
| blink.cmp            | 代码补全 (替代 nvim-cmp)            |
| which-key.nvim       | 快捷键提示                          |
| mini.animate         | 动画效果                            |
| todo-comments.nvim   | TODO 注释高亮                       |
| flash.nvim           | 快速跳转                            |
| render-markdown.nvim | Markdown 渲染                       |

### 文件导航

| 插件     | 说明                        |
| -------- | --------------------------- |
| oil.nvim | 文件浏览器 (替代 nvim-tree) |

### Git

| 插件          | 说明                 |
| ------------- | -------------------- |
| gitsigns.nvim | Git 行级变更标记     |
| diffview.nvim | Git diff 视图        |
| neogit        | Git TUI (类似 Magit) |

### 数据库

| 插件                  | 说明         |
| --------------------- | ------------ |
| vim-dadbod            | 数据库后端   |
| vim-dadbod-ui         | 数据库 UI    |
| vim-dadbod-completion | SQL 自动补全 |

### 代码

| 插件            | 说明       |
| --------------- | ---------- |
| nvim-lspconfig  | LSP 配置   |
| conform.nvim    | 代码格式化 |
| nvim-treesitter | 语法高亮   |
| nvim-autopairs  | 括号配对   |
| nvim-surround   | 包围修改   |

### 语言支持

| 插件         | 说明  |
| ------------ | ----- |
| vimtex       | LaTeX |
| rustaceanvim | Rust  |

## 快捷键速查表

### 基础操作

| 快捷键 | 说明                    |
| ------ | ----------------------- |
| `;`    | 进入命令模式            |
| `jk`   | 退出插入模式            |
| `x`    | 删除字符 (不进入寄存器) |
| `s`    | 删除字符并进入插入模式  |

### 窗口操作

| 快捷键       | 说明         |
| ------------ | ------------ |
| `<leader>h`  | 水平分屏     |
| `<leader>v`  | 垂直分屏     |
| `<leader>c`  | 关闭当前窗口 |
| `<leader>bo` | 关闭其他窗口 |
| `<leader>wH` | 窗口移到左侧 |
| `<leader>wJ` | 窗口移到下方 |
| `<leader>wK` | 窗口移到上方 |
| `<leader>wL` | 窗口移到右侧 |
| `<leader>wr` | 窗口向下循环 |
| `<leader>wR` | 窗口向上循环 |
| `<C-方向键>` | 调整窗口大小 |

### 终端

| 快捷键       | 说明     |
| ------------ | -------- |
| `<leader>th` | 水平终端 |
| `<leader>tv` | 垂直终端 |
| `<leader>tf` | 浮动终端 |

### 插入模式

| 快捷键    | 说明                   |
| --------- | ---------------------- |
| `<C-e>`   | 跳转到下一个单词尾部   |
| `<C-b>`   | 跳转到上一个单词开头   |
| `<C-w>`   | 跳转到下一个单词开头   |
| `<C-S-e>` | 跳转到下一个 WORD 尾部 |
| `<C-S-b>` | 跳转到上一个 WORD 开头 |
| `<C-S-w>` | 跳转到下一个 WORD 开头 |

### Snacks Picker (文件搜索)

| 快捷键       | 说明            |
| ------------ | --------------- |
| `<leader>ff` | 查找文件        |
| `<leader>fg` | Grep 搜索       |
| `<leader>fb` | 搜索 Buffer     |
| `<leader>fh` | 搜索帮助文档    |
| `<leader>fr` | 最近文件        |
| `<leader>/`  | Grep (根目录)   |
| `<leader>sg` | Grep (选中内容) |

### OpenCode AI

| 快捷键       | 说明               |
| ------------ | ------------------ |
| `<leader>oa` | 打开 OpenCode 聊天 |
| `<leader>oq` | 快速提问           |

### Oil (文件浏览器)

| 快捷键      | 说明               |
| ----------- | ------------------ |
| `<leader>e` | 打开文件浏览器     |
| `-`         | 进入上级目录       |
| `<leader>E` | 打开浮动文件浏览器 |

### Git (Neogit)

| 快捷键       | 说明                   |
| ------------ | ---------------------- |
| `<leader>gg` | 打开 Neogit            |
| `<leader>gG` | 打开 Neogit (新标签页) |

### Diffview

| 快捷键       | 说明                 |
| ------------ | -------------------- |
| `<leader>Do` | 打开 Diffview        |
| `<leader>Ds` | 打开 Diffview (简洁) |
| `<leader>Dc` | 关闭 Diffview        |
| `<leader>Dt` | 切换文件面板         |
| `<leader>Dh` | 文件历史             |

### 数据库 (DadBod)

| 快捷键        | 说明           |
| ------------- | -------------- |
| `<leader>db`  | 打开数据库 UI  |
| `<leader>dbs` | 快速连接数据库 |

### 代码

| 快捷键       | 说明       |
| ------------ | ---------- |
| `<leader>fm` | 格式化代码 |

### Gitsigns

| 快捷键       | 说明        |
| ------------ | ----------- |
| `]h`         | 下一个 Hunk |
| `[h`         | 上一个 Hunk |
| `<leader>hs` | Stage Hunk  |
| `<leader>hr` | Reset Hunk  |
| `<leader>hb` | Blame Line  |
| `<leader>hd` | Diff This   |

### Trouble (诊断)

| 快捷键       | 说明          |
| ------------ | ------------- |
| `<leader>xx` | 诊断列表      |
| `<leader>xb` | 当前文件诊断  |
| `<leader>xs` | 符号列表      |
| `<leader>xl` | LSP 引用/定义 |
| `<leader>xq` | Quickfix 列表 |

## 配置说明

### 主题

- 主题: tundra
- 透明背景: 启用

### 禁用的默认插件

以下 NvChad 默认插件已被禁用，使用自定义替代方案：

- telescope.nvim → snacks.nvim
- nvim-cmp → blink.cmp
- nvim-tree.lua → oil.nvim

## 使用方法

1. 打开 Neovim
2. 运行 `:LazySync` 同步插件
3. 享受！

## 依赖

- Neovim 0.10+
- Git
- ripgrep (用于 Grep 搜索)
- 各种数据库 CLI 工具 (psql, mysql 等)
