# XDG Base Directory specification compliance

set -gx MAVEN_OPTS "-Dmaven.repo.local=$HOME/.local/share/maven/repository"
set -gx GRADLE_USER_HOME "$HOME/.local/share/gradle"
set -gx _JAVA_OPTIONS "-Duser.home=$HOME/.local/share/java"
set -gx CARGO_HOME "$HOME/.local/share/cargo"
set -gx RUSTUP_HOME "$HOME/.local/share/rustup"
set -gx GOPATH "$HOME/.local/share/go"
set -gx BUN_INSTALL "$HOME/.local/share/bun"
set -gx NPM_CONFIG_USERCONFIG "$HOME/.config/npm/npmrc"
set -gx DOCKER_CONFIG "$HOME/.config/docker"
set -gx PIP_CONFIG_FILE "$HOME/.config/pip/pip.conf"
set -gx ANDROID_USER_HOME "$HOME/.local/share/android"
set -gx KUBECONFIG "$HOME/.config/kube/config"
set -gx WGETRC "$HOME/.config/wgetrc"
set -gx ATUIN_CONFIG_DIR "$HOME/.config/atuin"
set -gx ATUIN_DATA_DIR "$HOME/.local/share/atuin"
set -gx ATUIN_LOG_DIR "$HOME/.local/state/atuin"
set -gx DOTNET_CLI_HOME "$HOME/.local/share/dotnet"
set -gx CUDA_CACHE_DIR "$HOME/.cache/nv"

# Default XDG variables
set -q XDG_CONFIG_HOME; or set -gx XDG_CONFIG_HOME "$HOME/.config"
set -q XDG_DATA_HOME; or set -gx XDG_DATA_HOME "$HOME/.local/share"
set -q XDG_STATE_HOME; or set -gx XDG_STATE_HOME "$HOME/.local/state"
set -q XDG_CACHE_HOME; or set -gx XDG_CACHE_HOME "$HOME/.cache"

# Ollama models path
set -gx OLLAMA_MODELS "$DATA_HOME/Model/ollama/models"
