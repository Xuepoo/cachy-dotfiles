# CachyOS Dotfiles

A premium, highly-optimized set of Wayland-centric dotfiles tailored for **CachyOS / Arch Linux**. Featuring modern GPU-accelerated terminals, customized scrollable & dynamic tiling window managers, and full terminal-based development environment integrations.

Managed seamlessly using a **Bare Git Repository** setup to keep the home directory clean and organized.

---

## Managed Configurations & Systems

Below is the structured breakdown of the configurations tracked in this repository:

| Component | Path | Description / Key Tool |
| :--- | :--- | :--- |
| **Window Compositors** | [`.config/hypr`](file:///.config/hypr) | **Hyprland** & **Hyprlock** – Smooth, dynamic tiling Wayland compositor. |
| | [`.config/niri`](file:///.config/niri) | **Niri** – Innovative scrollable-tiling Wayland window manager. |
| **Bars & Notifications** | [`.config/waybar`](file:///.config/waybar) | **Waybar** – Optimized status bar with customized CPU, temp, and memory modules. |
| | [`.config/swaync`](file:///.config/swaync) | **SwayNC** – Sleek, modern notification center for Wayland. |
| **Terminal & Prompt** | [`.config/ghostty`](file:///.config/ghostty) | **Ghostty** – GPU-accelerated terminal emulator with custom themes and keybinds. |
| | [`.config/starship.toml`](file:///.config/starship.toml) | **Starship** – Custom cross-shell prompt for Fish/Bash. |
| | [`.config/fastfetch`](file:///.config/fastfetch) | **Fastfetch** – Custom system info tool featuring aesthetic anime image displays. |
| **Editor** | [`.config/nvim`](file:///.config/nvim) | **Neovim** – Fully-featured IDE setup formatted via StyLua, featuring translation-clean comments. |
| **File Management** | [`.config/superfile`](file:///.config/superfile) | **Superfile** – Modern aesthetic terminal file manager loaded with themes. |
| **Media & Audio** | [`.config/cava`](file:///.config/cava) | **CAVA** – Terminal audio spectrum visualizer with custom shaders. |
| | [`.config/rmpc`](file:///.config/rmpc) | **RMPC** – High-fidelity MPD client for music control. |
| **Utilities** | [`.config/wofi`](file:///.config/wofi) | **Wofi** – Custom launcher and menu runner. |
| | [`.config/satty`](file:///.config/satty) | **Satty** – Modern, high-performance screenshot annotator. |
| | [`.config/television`](file:///.config/television) | **Television** – Modular, high-speed terminal fuzzy finder. |

---

## Installation & Dotfiles Management

These configurations are managed via a **bare git repository** mapped to `$HOME/.cfg/` with the worktree set to `$HOME`. 

### Initial Restoration
To deploy these dotfiles onto a fresh CachyOS setup:

1. **Clone the bare repository**:
   ```bash
   git clone --bare git@github.com:Xuepoo/cachy-dotfiles.git $HOME/.cfg
   ```

2. **Define the alias/function (Fish Shell)**:
   Ensure the following function is in your `~/.config/fish/functions/config.fish`:
   ```fish
   function config
       /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $argv
   end
   ```

3. **Apply the configuration**:
   ```bash
   config checkout
   ```
   *Note: If there are existing system files clashing, back up or delete them, then re-run `config checkout`.*

4. **Hide untracked files in status**:
   To prevent `git status` from listing your entire home directory, ignore untracked files locally:
   ```bash
   config config --local status.showUntrackedFiles no
   ```

### Daily Usage Flow
Use the `config` command just like a normal `git` command to track and commit changes:
```bash
# Check modified files
config status

# Add a modified or new configuration
config add .config/nvim/init.lua

# Commit and Push
config commit -m "style: tweak editor layout options"
config push
```

---

## Key Recent Optimizations

### 1. Waybar Status Bar Redesign
- **Unified CPU & Temp Module**: Replaced separate status modules with a single, unified python-based script (`cpu.py`) leveraging `psutil` to show aggregated CPU utilization and average core temperatures. Hovering displays a beautiful layout showing utilization per logical thread and temperature per physical core.
- **Memory Module Enhancements**: Added an aesthetic RAM chip logo (`󰘚`) and removed raw markup tags in tooltips to prevent raw tags from showing in the system bar.
- **Translation & Linting**: Cleaned and translated all Waybar styles and configurations to clean English, and formatted `style.css` via Prettier.

### 2. Neovim Configuration Refinement
- **English Comments & Mapping Specs**: Translated 100% of the Chinese documentation and mapped keys descriptions into professional, technical English to maintain maximum clean-code compliance.
- **StyLua Standardization**: Formatted the entire lua codebase with `stylua` following the custom rules in `.stylua.toml` to guarantee precise formatting and clean structure.
