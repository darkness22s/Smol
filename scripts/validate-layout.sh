#!/usr/bin/env bash
set -Eeuo pipefail
ROOT=$(cd -- "$(dirname -- "$0")/.." && pwd)
for path in README.md scripts/build-iso.sh scripts/doctor.sh \
  image/config/hooks/live/0200-install-cua.hook.chroot \
  image/config/hooks/live/0300-render-wallpaper.hook.chroot \
  image/config/package-lists/smol.list.chroot \
  image/config/includes.chroot/usr/share/backgrounds/smol/smol.svg \
  image/config/includes.chroot/etc/xdg/pcmanfm-qt/lxqt/settings.conf \
  image/config/includes.chroot/etc/skel/.config/pcmanfm-qt/lxqt/settings.conf \
  image/config/includes.chroot/etc/xdg/smol/tint2rc \
  image/config/includes.chroot/etc/xdg/autostart/smol-desktop.desktop \
  image/config/includes.chroot/usr/local/bin/smol-desktop-session \
  image/config/includes.chroot/usr/share/applications/smol-browser.desktop \
  image/config/includes.chroot/usr/share/applications/smol-files.desktop \
  image/config/includes.chroot/usr/share/applications/smol-settings.desktop \
  docs/DESKTOP.md skills/smol-app-qa/SKILL.md agent/cua-driver.mcp.json; do
  [[ -f $ROOT/$path ]] || { echo "Missing: $path" >&2; exit 1; }
done
for path in scripts/install-cua.sh scripts/qa_run.py \
  image/config/includes.chroot/usr/share/applications/smol-install-cua.desktop \
  image/config/includes.chroot/etc/skel/.config/autostart/smol-plank.desktop; do
  [[ ! -e $ROOT/$path ]] || { echo "Legacy installer or dock file remains: $path" >&2; exit 1; }
done
python3 -m json.tool "$ROOT/agent/cua-driver.mcp.json" >/dev/null
grep -q 'CUA_DRIVER_RS_HOME=/opt/cua-driver' "$ROOT/image/config/hooks/live/0200-install-cua.hook.chroot"
grep -qx 'chromium' "$ROOT/image/config/package-lists/smol.list.chroot"
grep -qx 'tint2' "$ROOT/image/config/package-lists/smol.list.chroot"
grep -qx 'flatpak' "$ROOT/image/config/package-lists/smol.list.chroot"
grep -qx 'distrobox' "$ROOT/image/config/package-lists/smol.list.chroot"
grep -qx 'librsvg2-bin' "$ROOT/image/config/package-lists/smol.list.chroot"
! grep -qx 'netsurf-gtk' "$ROOT/image/config/package-lists/smol.list.chroot"
! grep -qx 'plank' "$ROOT/image/config/package-lists/smol.list.chroot"
grep -q '^Exec=chromium %U' "$ROOT/image/config/includes.chroot/usr/share/applications/smol-browser.desktop"
grep -q 'Wallpaper=/usr/share/backgrounds/smol/smol.png' "$ROOT/image/config/includes.chroot/etc/xdg/pcmanfm-qt/lxqt/settings.conf"
grep -q 'launcher_item_app = /usr/share/applications/smol-browser.desktop' "$ROOT/image/config/includes.chroot/etc/xdg/smol/tint2rc"
grep -q 'panel_layer = top' "$ROOT/image/config/includes.chroot/etc/xdg/smol/tint2rc"
grep -q 'rsvg-convert' "$ROOT/image/config/hooks/live/0300-render-wallpaper.hook.chroot"
grep -q 'smol-app-qa' "$ROOT/skills/smol-app-qa/SKILL.md"
echo "SMOL full-edition layout checks passed."
