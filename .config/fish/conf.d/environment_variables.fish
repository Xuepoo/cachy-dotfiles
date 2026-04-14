set -x RUSTUP_UPDATE_ROOT https://mirrors.tuna.tsinghua.edu.cn/rustup/up
set -x RUSTUP_DIST_SERVER https://mirrors.tuna.tsinghua.edu.cn/rustup
set -x HF_ENDPOINT https://hf-mirror.com

set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx SYSTEMD_EDITOR nvim

set -x PNPM_HOME $HOME/.local/share/pnpm
fish_add_path $HOME/.local/share/npm-global/bin
fish_add_path $PNPM_HOME
fish_add_path $HOME/.local/bin

