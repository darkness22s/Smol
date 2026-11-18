#!/usr/bin/env bash
set -u
echo "=== SMOL desktop diagnostics ==="
printf 'Kernel: '; uname -sr
printf 'Session: %s\n' "$(printenv XDG_SESSION_TYPE || echo unknown)"
printf 'DISPLAY: %s\n' "$(printenv DISPLAY || echo not-set)"
printf 'Approx whole-host memory in use (MiB): '
awk '/MemTotal:/ {total=$2} /MemAvailable:/ {available=$2} END {if (total>0) printf "%.0f / %.0f\n", (total-available)/1024, total/1024; else print "unavailable"}' /proc/meminfo
for cmd in python3 flatpak distrobox scrot cua-driver; do
  if command -v "$cmd" >/dev/null 2>&1; then
    printf '[ok] %s\n' "$cmd"
  else
    printf '[optional/missing] %s\n' "$cmd"
  fi
done
if command -v cua-driver >/dev/null 2>&1; then
  cua-driver doctor || true
else
  echo "To opt in to Cua Driver, run smol-install-cua."
fi
