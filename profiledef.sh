#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="xeno-os"
iso_label="XENO_$(date --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}" +%Y%m)"
iso_publisher="Xeno OS <https://github.com/xeno2426/xeno-os>"
iso_application="Xeno OS — Developer Environment"
iso_version="$(date --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}" +%Y.%m.%d)"
install_dir="arch"
buildmodes=('iso')
bootmodes=('bios.syslinux' 'uefi.systemd-boot')
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
airootfs_image_tool_options=('-comp' 'xz' '-Xbcj' 'x86' '-b' '1M' '-Xdict-size' '1M')
bootstrap_tarball_compression=('zstd' '-c' '-T0' '--auto-threads=logical' '--long' '-19')
file_permissions=(
  ["/etc/shadow"]="0:0:400"
  ["/root"]="0:0:750"
  ["/root/.automated_script.sh"]="0:0:755"
  ["/root/.gnupg"]="0:0:700"
  ["/usr/local/bin/choose-mirror"]="0:0:755"
  ["/usr/local/bin/Installation_guide"]="0:0:755"
  ["/usr/local/bin/livecd-sound"]="0:0:755"
  ["/usr/local/bin/xeno-init.sh"]="0:0:755"
  ["/usr/local/bin/xeno-installer"]="0:0:755"
  ["/usr/local/bin/xeno-firstrun.sh"]="0:0:755"
  ["/usr/local/bin/xeno-lock"]="0:0:755"
  ["/usr/local/bin/xeno-ai"]="0:0:755"
  ["/usr/local/bin/xeno-wallpaper"]="0:0:755"
  ["/etc/skel/.config/polybar/launch.sh"]="0:0:755"
  ["/etc/skel/.config/bspwm/bspwmrc"]="0:0:755"
  ["/etc/udev/rules.d/99-xeno-embedded.rules"]="0:0:644"
)
systemd_services=(
  'NetworkManager.service'
  'sshd.service'
  'tlp.service'
  'avahi-daemon.service'
  'systemd-resolved.service'
  'xeno-init.service'
  'docker.service'
)
