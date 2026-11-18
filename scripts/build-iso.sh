#!/usr/bin/env bash
set -Eeuo pipefail

ROOT=$(cd -- "$(dirname -- "$0")/.." && pwd)
WORK="$ROOT/.work/live-build"
DIST="$ROOT/dist"
if [[ $EUID -ne 0 ]]; then
  echo "Run with sudo/root on Debian 13." >&2
  exit 1
fi
if ! command -v lb >/dev/null 2>&1; then
  echo "Missing live-build. Install live-build, debootstrap, squashfs-tools, xorriso." >&2
  exit 1
fi
if [[ $(uname -m) != x86_64 ]]; then
  echo "Initial SMOL ISO target is amd64 (x86_64)." >&2
  exit 1
fi
mkdir -p "$WORK" "$DIST"
cd "$WORK"
if [[ -d config ]]; then lb clean --purge; fi
lb config \
  --distribution trixie \
  --architectures amd64 \
  --binary-images iso-hybrid \
  --debian-installer none \
  --archive-areas "main contrib non-free-firmware" \
  --apt-recommends false \
  --apt-indices false \
  --apt-source-archives false \
  --firmware-chroot false \
  --firmware-binary false \
  --chroot-squashfs-compression-type xz \
  --bootappend-live "boot=live components locales=en_US.UTF-8"
cp -a "$ROOT/image/config/." config/
install -Dm0755 "$ROOT/scripts/doctor.sh" config/includes.chroot/usr/local/bin/smol-doctor
chmod 0755 config/hooks/live/*.hook.chroot
# Cua Driver remains included by default in the image, via the chroot hook.
lb build

found=0
for iso in ./*.iso; do
  [[ -f $iso ]] || continue
  found=1
  install -m0644 "$iso" "$DIST/smol-trixie-amd64-live.iso"
  (
    cd "$DIST"
    sha256sum smol-trixie-amd64-live.iso > smol-trixie-amd64-live.iso.sha256
  )
  echo "Built: $DIST/smol-trixie-amd64-live.iso"
done
if (( found == 0 )); then
  echo "live-build did not create an ISO; inspect $WORK." >&2
  exit 1
fi
