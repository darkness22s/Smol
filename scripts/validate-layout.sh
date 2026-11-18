#!/usr/bin/env bash
set -Eeuo pipefail
ROOT=$(cd -- "$(dirname -- "$0")/.." && pwd)
for path in README.md scripts/build-iso.sh scripts/doctor.sh \
  image/config/hooks/live/0200-install-cua.hook.chroot \
  image/config/package-lists/smol.list.chroot \
  image/config/includes.chroot/usr/share/backgrounds/smol/smol.svg \
  image/config/includes.chroot/etc/skel/.config/plank/dock1/settings \
  image/config/includes.chroot/etc/skel/.config/autostart/smol-plank.desktop \
  image/config/includes.chroot/usr/share/applications/smol-browser.desktop \
  image/config/includes.chroot/usr/share/applications/smol-files.desktop \
  image/config/includes.chroot/usr/share/applications/smol-settings.desktop \
  docs/DESKTOP.md skills/smol-app-qa/SKILL.md agent/cua-driver.mcp.json; do
  [[ -f $ROOT/$path ]] || { echo "Missing: $path" >&2; exit 1; }
done
for path in scripts/install-cua.sh scripts/qa_run.py \
  image/config/includes.chroot/usr/share/applications/smol-install-cua.desktop; do
  [[ ! -e $ROOT/$path ]] || { echo "Legacy opt-in or QA file exists: $path" >&2; exit 1; }
done
python3 -m json.tool "$ROOT/agent/cua-driver.mcp.json" >/dev/null
grep -q 'CUA_DRIVER_RS_HOME=/opt/cua-driver' "$ROOT/image/config/hooks/live/0200-install-cua.hook.chroot"
grep -q 'plank' "$ROOT/image/config/package-lists/smol.list.chroot"
grep -q '^netsurf-gtk$' "$ROOT/image/config/package-lists/smol.list.chroot"
grep -q '^user-setup$' "$ROOT/image/config/package-lists/smol.list.chroot"
grep -q '^Exec=netsurf-gtk$' "$ROOT/image/config/includes.chroot/usr/share/applications/smol-browser.desktop"
for unwanted in chromium distrobox flatpak; do
  if grep -qx "$unwanted" "$ROOT/image/config/package-lists/smol.list.chroot"; then
    echo "Heavy package still preinstalled: $unwanted" >&2
    exit 1
  fi
done
grep -q -- '--apt-recommends false' "$ROOT/scripts/build-iso.sh"
grep -q -- '--chroot-squashfs-compression-type xz' "$ROOT/scripts/build-iso.sh"
grep -q 'smol-app-qa' "$ROOT/skills/smol-app-qa/SKILL.md"
echo "SMOL lite source checks passed."
