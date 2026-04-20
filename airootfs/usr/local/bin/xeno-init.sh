#!/bin/bash
# xeno-init.sh — Chaotic-AUR keyring bootstrap
# Runs once at first boot via xeno-init.service

set -euo pipefail

echo "[xeno-init] Bootstrapping Chaotic-AUR keyring..."

pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com || {
    echo "[xeno-init] Primary keyserver failed, trying fallback..."
    pacman-key --recv-key 3056513887B78AEB --keyserver hkps://keyserver.ubuntu.com:443
}

pacman-key --lsign-key 3056513887B78AEB

pacman -U \
    'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' \
    'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' \
    --noconfirm

echo "[xeno-init] Chaotic-AUR keyring initialized successfully."
