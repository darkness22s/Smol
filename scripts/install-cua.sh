#!/usr/bin/env bash
# Explicit user consent before running any upstream installer.
set -Eeuo pipefail
if [[ $EUID -eq 0 ]]; then
  echo "Run as the logged-in desktop user, not root." >&2
  exit 1
fi
if [[ -z $(printenv DISPLAY || true) ]]; then
  echo "Use a logged-in graphical X11/XWayland desktop." >&2
  exit 1
fi
if command -v cua-driver >/dev/null 2>&1; then
  echo "Cua Driver is already installed."
  cua-driver doctor
  exit 0
fi
command -v curl >/dev/null || { echo "curl is required." >&2; exit 1; }
echo "This will download and execute the third-party Cua Driver installer:"
echo "https://cua.ai/driver/install.sh"
echo "The driver can control your desktop. Review its permissions and never"
echo "expose its MCP interface to untrusted users or a public network."
read -r -p "Type INSTALL to proceed: " answer
if [[ $answer != INSTALL ]]; then
  echo "Cancelled; upstream code was not executed."
  exit 1
fi
temp=$(mktemp)
trap 'rm -f "$temp"' EXIT
curl --fail --location --silent --show-error --proto '=https' --tlsv1.2 \
  https://cua.ai/driver/install.sh --output "$temp"
bash "$temp"
if [[ -x $HOME/.local/bin/cua-driver ]]; then
  "$HOME/.local/bin/cua-driver" doctor || true
else
  echo "Restart your terminal, then run cua-driver doctor."
fi
