#!/usr/bin/env bash
# ─── Xeno OS First-Run Setup ──────────────────────────────────────────────────
# Runs automatically on first terminal login (triggered from .zshrc).
# Completes post-install configuration that archinstall cannot do:
#   • Flatpak + Flathub
#   • AUR helper confirmation
#   • Wallpaper generation
#   • betterlockscreen cache
#   • Plymouth enable
#   • Docker group
#   • Default browser
#   • Notification + marker

set -euo pipefail

MARKER="$HOME/.config/xeno-setup-done"
LOG="$HOME/.config/xeno-firstrun.log"

# Already done — exit immediately
[[ -f "$MARKER" ]] && exit 0

mkdir -p "$HOME/.config"
exec > >(tee -a "$LOG") 2>&1

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; NC='\033[0m'
step() { echo -e "\n${CYAN}▶ $1${NC}"; }
ok()   { echo -e "${GREEN}  ✓ $1${NC}"; }
warn() { echo -e "${YELLOW}  ⚠ $1${NC}"; }

clear
echo -e "${CYAN}"
cat << 'BANNER'
  ╔══════════════════════════════════════════╗
  ║        Xeno OS — First Run Setup         ║
  ║   Configuring your environment...        ║
  ╚══════════════════════════════════════════╝
BANNER
echo -e "${NC}"
sleep 1

# ─── 1. Flatpak + Flathub ─────────────────────────────────────────────────────
step "Setting up Flatpak + Flathub"
if command -v flatpak &>/dev/null; then
    flatpak remote-add --user --if-not-exists flathub \
        https://flathub.org/repo/flathub.flatpakrepo 2>/dev/null || true
    ok "Flathub remote added"
else
    warn "flatpak not found — skipping"
fi

# ─── 2. Wallpaper ─────────────────────────────────────────────────────────────
step "Generating wallpaper"
if command -v xeno-wallpaper &>/dev/null; then
    xeno-wallpaper && ok "Wallpaper generated"
else
    warn "xeno-wallpaper not found — skipping"
fi

# ─── 3. betterlockscreen cache ────────────────────────────────────────────────
step "Pre-rendering lock screen"
WALLPAPER_DIR="$HOME/.local/share/backgrounds/xeno-os"
if command -v betterlockscreen &>/dev/null && [[ -d "$WALLPAPER_DIR" ]]; then
    betterlockscreen -u "$WALLPAPER_DIR" --fx dimblur 2>/dev/null && \
        ok "Lock screen cache built" || warn "betterlockscreen render failed"
else
    warn "betterlockscreen or wallpaper dir not found — skipping"
fi

# ─── 4. nitrogen wallpaper restore ───────────────────────────────────────────
step "Setting desktop wallpaper"
if command -v nitrogen &>/dev/null && [[ -d "$WALLPAPER_DIR" ]]; then
    WALL=$(find "$WALLPAPER_DIR" -name "*.png" | head -1)
    [[ -n "$WALL" ]] && nitrogen --set-zoom-fill --save "$WALL" 2>/dev/null && \
        ok "Wallpaper set: $WALL"
fi

# ─── 5. Plymouth enable ───────────────────────────────────────────────────────
step "Enabling Plymouth boot splash"
if command -v plymouth-set-default-theme &>/dev/null; then
    sudo plymouth-set-default-theme -R xeno 2>/dev/null && \
        ok "Plymouth theme set to xeno" || warn "Plymouth theme set failed (check sudo)"
else
    warn "Plymouth not found — skipping"
fi

# ─── 6. Docker group ──────────────────────────────────────────────────────────
step "Checking Docker group membership"
if groups | grep -q docker; then
    ok "Already in docker group"
else
    warn "Not in docker group. Run: sudo usermod -aG docker $USER && newgrp docker"
fi

# ─── 7. zinit (Zsh plugin manager bootstrap) ─────────────────────────────────
step "Bootstrapping zinit"
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
if [[ ! -d "$ZINIT_HOME" ]]; then
    git clone --depth=1 https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME" && \
        ok "zinit installed" || warn "zinit install failed"
else
    ok "zinit already present"
fi

# ─── 8. Neovim plugins (headless) ────────────────────────────────────────────
step "Installing Neovim plugins (lazy.nvim)"
if command -v nvim &>/dev/null; then
    nvim --headless "+Lazy! sync" +qa 2>/dev/null && \
        ok "Neovim plugins synced" || warn "Neovim plugin sync failed (will retry on first open)"
fi

# ─── 9. Python virtual environment for AI work ───────────────────────────────
step "Setting up Python AI workspace"
AIENV="$HOME/.local/share/xeno-ai-env"
if command -v python &>/dev/null && [[ ! -d "$AIENV" ]]; then
    python -m venv "$AIENV" && \
    "$AIENV/bin/pip" install --quiet --upgrade pip ipython numpy scipy matplotlib && \
    ok "AI virtualenv created at $AIENV" || warn "AI venv setup failed"
else
    ok "AI virtualenv already exists"
fi

# ─── 10. Marker ───────────────────────────────────────────────────────────────
touch "$MARKER"
echo ""
echo -e "${GREEN}╔══════════════════════════════════════════╗"
echo -e "║    Xeno OS setup complete! Enjoy :)      ║"
echo -e "╚══════════════════════════════════════════╝${NC}"
echo ""
echo -e "Run ${CYAN}xeno-ai${NC}     to launch AI tools"
echo -e "Run ${CYAN}xeno-lock${NC}   to lock your screen"
echo -e "Run ${CYAN}xeno-installer${NC} to install on another disk"
echo ""
sleep 3
