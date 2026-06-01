#!/usr/bin/env bash
# ─── Xeno OS First-Run Setup ──────────────────────────────────────────────────
# Runs automatically on first terminal login (triggered from .zshrc).
# Uses || true on all optional steps so a single failure never aborts the rest.

MARKER="$HOME/.config/xeno-setup-done"
LOG="$HOME/.config/xeno-firstrun.log"

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
    xeno-wallpaper && ok "Wallpaper generated" || warn "Wallpaper generation failed — skipping"
else
    warn "xeno-wallpaper not found — skipping"
fi

# ─── 3. betterlockscreen cache ────────────────────────────────────────────────
step "Pre-rendering lock screen"
WALLPAPER_DIR="$HOME/.local/share/backgrounds/xeno-os"
if command -v betterlockscreen &>/dev/null && [[ -d "$WALLPAPER_DIR" ]]; then
    betterlockscreen -u "$WALLPAPER_DIR" --fx dimblur 2>/dev/null && \
        ok "Lock screen cache built" || warn "betterlockscreen render failed — skipping"
else
    warn "betterlockscreen or wallpaper dir not found — skipping"
fi

# ─── 4. nitrogen wallpaper restore ───────────────────────────────────────────
step "Setting desktop wallpaper"
if command -v nitrogen &>/dev/null && [[ -d "$WALLPAPER_DIR" ]]; then
    WALL=$(find "$WALLPAPER_DIR" -name "*.png" | head -1)
    if [[ -n "$WALL" ]]; then
        nitrogen --set-zoom-fill --save "$WALL" 2>/dev/null && \
            ok "Wallpaper set: $WALL" || warn "nitrogen failed — skipping"
    fi
fi

# ─── 5. Plymouth enable ───────────────────────────────────────────────────────
step "Enabling Plymouth boot splash"
if command -v plymouth-set-default-theme &>/dev/null; then
    sudo plymouth-set-default-theme -R xeno 2>/dev/null && \
        ok "Plymouth theme set to xeno" || warn "Plymouth theme set failed — skipping"
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

# ─── 7. zinit bootstrap ───────────────────────────────────────────────────────
step "Bootstrapping zinit"
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
if [[ ! -d "$ZINIT_HOME" ]]; then
    git clone --depth=1 https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME" && \
        ok "zinit installed" || warn "zinit install failed — skipping"
else
    ok "zinit already present"
fi

# ─── 8. Neovim plugins — with retry ──────────────────────────────────────────
step "Installing Neovim plugins (lazy.nvim)"
if command -v nvim &>/dev/null; then
    for attempt in 1 2 3; do
        nvim --headless "+Lazy! sync" +qa 2>/dev/null && \
            { ok "Neovim plugins synced (attempt $attempt)"; break; } || \
            warn "Attempt $attempt failed — retrying..."
        sleep 2
    done
fi

# ─── 9. Python AI venv ───────────────────────────────────────────────────────
step "Setting up Python AI workspace"
AIENV="$HOME/.local/share/xeno-ai-env"
if command -v python &>/dev/null; then
    if [[ ! -d "$AIENV" ]]; then
        python -m venv "$AIENV" && \
        "$AIENV/bin/pip" install --quiet --upgrade pip ipython numpy scipy matplotlib && \
        ok "AI virtualenv created at $AIENV" || warn "AI venv setup failed — skipping"
    else
        ok "AI virtualenv already exists"
    fi
fi

# ─── 10. Harden SSH post-install ─────────────────────────────────────────────
step "Hardening SSH config"
SSHD_OVERRIDE="/etc/ssh/sshd_config.d/99-xeno-hardened.conf"
if [[ ! -f "$SSHD_OVERRIDE" ]]; then
    sudo tee "$SSHD_OVERRIDE" > /dev/null << 'EOF' && \
        ok "SSH hardened (root login + password auth disabled)" || \
        warn "Could not write SSH hardening config — skipping"
# Xeno OS post-install SSH hardening
PasswordAuthentication no
PermitRootLogin no
EOF
fi

# ─── 11. Set default browser ─────────────────────────────────────────────────
step "Setting default browser"
if command -v brave-browser &>/dev/null; then
    xdg-settings set default-web-browser brave-browser.desktop 2>/dev/null && \
        ok "Brave set as default browser" || warn "xdg-settings failed — skipping"
fi

# ─── 12. Create Screenshots dir ──────────────────────────────────────────────
step "Creating Screenshots directory"
mkdir -p "$HOME/Pictures/Screenshots" && ok "~/Pictures/Screenshots ready"

# ─── 13. Marker ───────────────────────────────────────────────────────────────
touch "$MARKER"
echo ""
echo -e "${GREEN}╔══════════════════════════════════════════╗"
echo -e "║    Xeno OS setup complete! Enjoy :)      ║"
echo -e "╚══════════════════════════════════════════╝${NC}"
echo ""
echo -e "Run ${CYAN}xeno-ai${NC}         to launch AI tools"
echo -e "Run ${CYAN}xeno-lock${NC}       to lock your screen"
echo -e "Run ${CYAN}xeno-installer${NC}  to install to disk"
echo ""
sleep 3
