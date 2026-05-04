# XDG Base Directory specification compliance
# Default XDG variables
set -q XDG_CONFIG_HOME; or set -gx XDG_CONFIG_HOME "$HOME/.config"
set -q XDG_DATA_HOME; or set -gx XDG_DATA_HOME "$HOME/.local/share"
set -q XDG_STATE_HOME; or set -gx XDG_STATE_HOME "$HOME/.local/state"
set -q XDG_CACHE_HOME; or set -gx XDG_CACHE_HOME "$HOME/.cache"

# XDG config
set -gx MC_CONFIG_DIR "$XDG_CONFIG_HOME/mcli"
set -gx NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npm/npmrc"
set -gx KUBECONFIG "$XDG_CONFIG_HOME/kube/config"
set -gx WGETRC "$XDG_CONFIG_HOME/wgetrc"
set -gx ATUIN_CONFIG_DIR "$XDG_CONFIG_HOME/atuin"
set -gx PIP_CONFIG_FILE "$XDG_CONFIG_HOME/pip/pip.conf"
set -gx DOCKER_CONFIG "$XDG_CONFIG_HOME/docker"
set -gx CLAUDE_CONFIG_DIR "$XDG_CONFIG_HOME/claude"
set -gx COPILOT_HOME "$XDG_CONFIG_HOME/copilot"
set -gx GEMINI_CONFIG_DIR "$XDG_CONFIG_HOME/gemini"

# XDG shared data
set -gx MAVEN_OPTS "-Dmaven.repo.local=$XDG_DATA_HOME/maven/repository"
set -gx GRADLE_USER_HOME "$XDG_DATA_HOME/gradle"
set -gx _JAVA_OPTIONS "-Duser.home=$XDG_DATA_HOME/java"
set -gx CARGO_HOME "$XDG_DATA_HOME/cargo"
set -gx RUSTUP_HOME "$XDG_DATA_HOME/rustup"
set -gx GOPATH "$XDG_DATA_HOME/go"
set -gx BUN_INSTALL "$XDG_DATA_HOME/bun"
set -gx ANDROID_USER_HOME "$XDG_DATA_HOME/android"
set -gx ATUIN_DATA_DIR "$XDG_DATA_HOME/atuin"
set -gx DOTNET_CLI_HOME "$XDG_DATA_HOME/dotnet"

# XDG state
set -gx ATUIN_LOG_DIR "$XDG_STATE_HOME/atuin"

# XDG cache
set -gx CUDA_CACHE_DIR "$XDG_CACHE_HOME/nv"
set -gx COPILOT_CACHE_HOME "$XDG_CACHE_HOME/copilot"
