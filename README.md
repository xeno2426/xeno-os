<div align="center">

```
  ██╗  ██╗███████╗███╗   ██╗ ██████╗      ██████╗ ███████╗
  ╚██╗██╔╝██╔════╝████╗  ██║██╔═══██╗    ██╔═══██╗██╔════╝
   ╚███╔╝ █████╗  ██╔██╗ ██║██║   ██║    ██║   ██║███████╗
   ██╔██╗ ██╔══╝  ██║╚██╗██║██║   ██║    ██║   ██║╚════██║
  ██╔╝ ██╗███████╗██║ ╚████║╚██████╔╝    ╚██████╔╝███████║
  ╚═╝  ╚═╝╚══════╝╚═╝  ╚═══╝ ╚═════╝      ╚═════╝ ╚══════╝
```

**Developer-Grade Arch Linux Distribution**

[![Build Xeno OS ISO](https://github.com/xeno2426/xeno-os/actions/workflows/build.yml/badge.svg)](https://github.com/xeno2426/xeno-os/actions/workflows/build.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](#license)
[![Arch Linux](https://img.shields.io/badge/base-Arch%20Linux-1793d1?logo=arch-linux)](https://archlinux.org)
[![Theme: Catppuccin Mocha](https://img.shields.io/badge/theme-Catppuccin%20Mocha-cba6f7)](https://github.com/catppuccin/catppuccin)

</div>

---

## What is Xeno OS?

Xeno OS is a custom Arch Linux live ISO and installer profile built for developers, makers, and AI/robotics engineers. It ships a fully pre-configured desktop environment — no post-install tweaking required. Boot the ISO, run `xeno-installer`, and you have a production-ready workstation.

**Key philosophy:** everything works out of the box. Fonts render beautifully, keybinds are sensible, the terminal looks great, AI tools are one command away, and your ESP32 is detected the moment you plug it in.

---

## Desktop

| Component | Choice |
|-----------|--------|
| Window Manager | [bspwm](https://github.com/baskerville/bspwm) |
| Status Bar | [Polybar](https://github.com/polybar/polybar) — macOS menu bar style |
| Dock | [Plank](https://launchpad.net/plank) — macOS dock style |
| Compositor | [Picom](https://github.com/yshui/picom) — blur, rounded corners, shadows |
| Launcher | [Rofi](https://github.com/davatorium/rofi) — Spotlight-style |
| Terminal | [Kitty](https://sw.kovidgoyal.net/kitty/) — GPU-accelerated |
| Shell | Zsh + [zinit](https://github.com/zdharma-continuum/zinit) + [Starship](https://starship.rs) |
| Editor | [Neovim](https://neovim.io) — fully configured with LSP, Treesitter, lazy.nvim |
| Theme | [Catppuccin Mocha](https://github.com/catppuccin/catppuccin) — everywhere |
| Notifications | [Dunst](https://dunst-project.org) |
| Lock Screen | [betterlockscreen](https://github.com/betterlockscreen/betterlockscreen) |
| Boot Splash | Plymouth — custom Xeno theme |

---

## Keybinds

All keybinds use `Super` (Windows key) as the modifier.

### Applications
| Keybind | Action |
|---------|--------|
| `Super + Return` | Terminal (Kitty) |
| `Super + Space` | App launcher (Rofi) |
| `Super + b` | Browser (Brave) |
| `Super + e` | File manager (Thunar) |
| `Super + r` | Ranger (terminal file manager) |
| `Super + t` | Neovim |
| `Super + a` | AI Tools launcher |
| `Super + Shift + Return` | System monitor (btop) |
| `Super + Shift + l` | Lock screen |

### Window Management
| Keybind | Action |
|---------|--------|
| `Super + h/j/k/l` | Focus window (vim keys) |
| `Super + Shift + h/j/k/l` | Move window |
| `Super + f` | Toggle fullscreen |
| `Super + Shift + Space` | Toggle floating |
| `Super + m` | Toggle monocle |
| `Super + w` | Close window |
| `Super + 1–0` | Switch workspace |
| `Super + Shift + 1–0` | Move window to workspace |
| `Super + Alt + h/j/k/l` | Resize window |
| `Super + =` | Balance tree |

### Screenshots
| Keybind | Action |
|---------|--------|
| `Print` | Full screenshot |
| `Super + Print` | Selection screenshot |
| `Super + Shift + Print` | Focused window screenshot |

### Media
| Keybind | Action |
|---------|--------|
| `XF86AudioRaiseVolume` | Volume up 5% |
| `XF86AudioLowerVolume` | Volume down 5% |
| `XF86AudioMute` | Toggle mute |
| `XF86AudioPlay` | Play/pause |
| `XF86MonBrightnessUp/Down` | Brightness |

---

## Feature Overview

### 🖥️ Desktop
- Tiling window manager with 10 workspaces
- Frosted glass blur on windows and polybar
- Rounded corners on all windows
- Smooth window fade transitions
- Auto-hiding dock with zoom on hover

### 🤖 AI & Data Science
```bash
xeno-ai              # Opens AI tools menu
xeno-ai jupyter      # JupyterLab at localhost:8888
xeno-ai ipython      # IPython REPL
xeno-ai ollama       # Local LLM (llama3, mistral, etc.)
xeno-ai check        # PyTorch / CUDA environment report
xeno-ai update       # Upgrade all AI packages
```
Pre-installed: NumPy, SciPy, Matplotlib, Pandas, scikit-learn, PyTorch, IPython, JupyterLab.

### 🔌 Robotics & IoT
Plug in your device — it just works. Udev rules for:
- **ESP32 / ESP32-S3** (CP210x, CH340, native USB)
- **Arduino** (Uno, Mega, Nano, Leonardo — FTDI + CDC)
- **Raspberry Pi Pico** (RP2040 + UF2 bootloader)
- **STM32** (ST-Link v2/v3)
- **J-Link** (Segger)

Tools: `esptool`, `avrdude`, `minicom`, `python-pyserial`.

### 🛠️ Development Stack
- **Editors:** Neovim with LSP (Python, TypeScript, C/C++, Lua), Treesitter, autocomplete
- **Git:** LazyGit via `Super+gg` in Neovim, gitsigns in buffer
- **Containers:** Docker + Docker Compose (service enabled at boot)
- **Languages:** Python, Node.js, Rust (via rustup), C/C++
- **Tools:** `ripgrep`, `fd`, `bat`, `eza`, `fzf`, `jq`, `tmux`
- **Cloud:** Docker, docker-compose

### 📦 Package Management
```bash
aur <package>          # Install from AUR (alias for yay)
install <package>      # Same as aur
update                 # Update all packages (pacman + AUR)
search <query>         # Search packages
remove <package>       # Remove package + orphans
cleanup                # Remove orphaned packages
mirrors                # Refresh mirror list with reflector
```

### 🔒 Lock Screen
```bash
lock                   # Lock screen (alias)
xeno-lock              # Lock with betterlockscreen (blur effect)
```
Lock is also triggered automatically on inactivity via `xss-lock`.

---

## Installation

### Requirements
- USB drive ≥ 4GB
- UEFI or BIOS system
- Internet connection
- x86_64 processor

### Download
Download the latest ISO from [Releases](https://github.com/xeno2426/xeno-os/releases).

### Flash
```bash
# Linux / macOS
sudo dd if=xeno-os-YYYY.MM.DD-x86_64.iso of=/dev/sdX bs=4M status=progress oflag=sync

# Or use Balena Etcher / Ventoy
```

### Install
1. Boot from USB
2. Run `xeno-installer` in the terminal
3. Follow the guided TUI (disk, locale, user, extras)
4. Reboot — first login triggers `xeno-firstrun.sh` automatically

---

## Building from Source

### Prerequisites
Arch Linux host with `archiso` installed:
```bash
sudo pacman -S archiso git
```

### Build
```bash
git clone https://github.com/xeno2426/xeno-os.git
cd xeno-os
sudo mkarchiso -v -w /tmp/xeno-build -o /tmp/xeno-out .
```

Output ISO will be in `/tmp/xeno-out/`.

### CI
Every push to `main` automatically builds the ISO via GitHub Actions and creates a Release. See [`.github/workflows/build.yml`](.github/workflows/build.yml).

---

## Project Structure

```
xeno-os/
├── airootfs/                  # Overlaid onto the live root filesystem
│   ├── etc/
│   │   ├── skel/              # Default user dotfiles
│   │   │   └── .config/
│   │   │       ├── bspwm/     # Window manager
│   │   │       ├── polybar/   # Status bar (macOS style)
│   │   │       ├── picom/     # Compositor
│   │   │       ├── kitty/     # Terminal
│   │   │       ├── nvim/      # Neovim (full LSP config)
│   │   │       ├── rofi/      # App launcher theme
│   │   │       ├── dunst/     # Notifications
│   │   │       ├── sxhkd/     # Keybinds
│   │   │       ├── conky/     # System stats widget
│   │   │       └── starship.toml
│   │   ├── udev/rules.d/      # Embedded device rules (ESP32, Arduino...)
│   │   └── systemd/           # Service units
│   └── usr/local/bin/
│       ├── xeno-installer     # Guided TUI installer
│       ├── xeno-firstrun.sh   # Post-install setup
│       ├── xeno-ai            # AI tools launcher
│       ├── xeno-lock          # Lock screen
│       ├── xeno-wallpaper     # Wallpaper generator
│       └── xeno-init.sh       # Chaotic-AUR bootstrap
├── efiboot/                   # UEFI systemd-boot entries
├── grub/                      # GRUB bootloader config
├── syslinux/                  # Legacy BIOS syslinux
├── packages.x86_64            # Package manifest
├── pacman.conf                # Pacman config (+ Chaotic-AUR)
├── profiledef.sh              # ISO metadata & build settings
└── .github/workflows/
    └── build.yml              # GitHub Actions CI
```

---

## Customisation

### Adding packages
Edit `packages.x86_64`. One package name per line. Comments start with `#`.

### Changing the theme
All configs use [Catppuccin Mocha](https://github.com/catppuccin/catppuccin). To switch flavour (Latte, Frappé, Macchiato), search-replace the hex colours across `skel/.config/`.

### Adding keybinds
Edit `airootfs/etc/skel/.config/sxhkd/sxhkdrc`. Format:
```
super + key
    command
```

### Modifying the status bar
Edit `airootfs/etc/skel/.config/polybar/config.ini`. Full Polybar docs at [polybar.github.io](https://polybar.github.io).

---

## Shells & CLI Tools

| Tool | Purpose |
|------|---------|
| `eza` | Modern `ls` with icons and git status |
| `bat` | Syntax-highlighted `cat` |
| `fd` | Faster `find` |
| `ripgrep` | Faster `grep` |
| `fzf` | Fuzzy finder (Ctrl+R, Ctrl+T, Alt+C) |
| `z` | Jump to frecent directories |
| `starship` | Cross-shell prompt |
| `tmux` | Terminal multiplexer (prefix: `Ctrl+Space`) |

---

## Neovim

Full IDE-quality setup with:
- **Plugin manager:** lazy.nvim (auto-bootstrapped)
- **LSP servers:** Python (pyright), TypeScript, C/C++ (clangd), Lua
- **Completion:** nvim-cmp with LSP + snippets
- **Fuzzy finder:** Telescope + fzf native
- **File tree:** nvim-tree
- **Git:** gitsigns + LazyGit
- **Theme:** Catppuccin Mocha
- **Treesitter:** syntax for 14+ languages

Key leaders use `Space`:

| Key | Action |
|-----|--------|
| `Space ff` | Find files |
| `Space fg` | Live grep |
| `Space fb` | Buffers |
| `Space e` | File explorer |
| `Space gg` | LazyGit |
| `Space rn` | Rename symbol |
| `Space ca` | Code action |
| `K` | Hover docs |
| `gd` | Go to definition |

---

## Contributing

1. Fork the repo
2. Create a branch: `git checkout -b feat/my-change`
3. Commit: `git commit -m "feat: description"`
4. Push + open a PR

The CI will automatically lint your scripts and validate `packages.x86_64`.

---

## License

MIT — see [LICENSE](LICENSE) for details.

---

<div align="center">
Made with ❤️ and Catppuccin Mocha · <a href="https://github.com/xeno2426/xeno-os">xeno2426/xeno-os</a>
</div>
