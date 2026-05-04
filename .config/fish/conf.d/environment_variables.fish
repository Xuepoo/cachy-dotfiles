set -x RUSTUP_UPDATE_ROOT https://mirrors.tuna.tsinghua.edu.cn/rustup/up
set -x RUSTUP_DIST_SERVER https://mirrors.tuna.tsinghua.edu.cn/rustup
set -x HF_ENDPOINT https://hf-mirror.com
set -gx OLLAMA_MODELS "/mnt/data/Model/ollama/models"


set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx SYSTEMD_EDITOR nvim
set -gx MOZ_ENABLE_WAYLAND 1

fish_add_path $HOME/.local/bin
fish_add_path $HOME/.local/share/npm-global/bin
fish_add_path $HOME/.local/share/pnpm
fish_add_path $HOME/.local/share/bun/bin
fish_add_path $HOME/.local/share/cargo/bin
