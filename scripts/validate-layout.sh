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
grep -q 'smol-app-qa' "$ROOT/skills/smol-app-qa/SKILL.md"
echo "SMOL source checks passed."
