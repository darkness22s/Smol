#!/usr/bin/env bash
set -u
echo "=== SMOL diagnostics ==="
printf 'Kernel: '; uname -sr
printf 'Session: %s\n' "$(printenv XDG_SESSION_TYPE || echo unknown)"
printf 'DISPLAY: %s\n' "$(printenv DISPLAY || echo not-set)"
printf 'Approx host memory used (MiB): '
awk '/MemTotal:/ {total=$2} /MemAvailable:/ {available=$2} END {if (total>0) printf "%.0f / %.0f\n", (total-available)/1024, total/1024; else print "unavailable"}' /proc/meminfo
if command -v cua-driver >/dev/null 2>&1; then
  echo "[ok] Built-in Cua Driver available"
  cua-driver doctor || true
else
  echo "[error] Built-in Cua Driver missing"
  exit 1
fi
