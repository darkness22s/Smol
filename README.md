# SMOL Linux

**Small desktop. Big automation.**

SMOL is an experimental Debian 13 (Trixie) Linux live distribution with LXQt/X11 and **Cua Driver bundled by default** for agent-friendly computer use. It targets <=2 GiB RAM during a defined set of basic tasks; this has not yet been measured.

## Lightweight ISO target

The default SMOL build now **targets a 700 MB ISO (700,000,000 bytes)**. This is an engineering target, **not a guaranteed build size**. GitHub Actions reports the actual ISO size after building; the image is always uploaded even if it exceeds the target, so that developers can inspect the result.

To reduce size versus the initial ~1.8 GB image:

- Do not install Debian's recommended packages automatically.
- Use XZ SquashFS compression and omit saved apt indexes and source indexes.
- Remove bundled Chromium, Flatpak, Distrobox, Git, and other optional tools; install them with apt when needed.
- Use the smaller NetSurf browser on the dock instead of Chromium.
- Omit the separate firmware bundle by default. Some real hardware, especially Wi-Fi adapters, may need firmware installed later. Do not assume full hardware support.

These are **image-content** trade-offs; SMOL can still run compatible apt applications and can add Flatpak / Distrobox / Chromium later. NetSurf lacks many modern web app features. Apps and kernel drivers are not universally compatible across architectures.

## Desktop styling

Inspired by the supplied desert-blue reference: bold **SMOL** wordmark, vivid wallpaper, and a working translucent three-icon dock for **NetSurf**, **Files** and **Settings**. See [docs/DESKTOP.md](docs/DESKTOP.md).

## Build ISO

On Debian 13 amd64:

    sudo apt update
    sudo apt install -y live-build debootstrap squashfs-tools xorriso grub-efi-amd64-bin grub-pc-bin
    sudo bash scripts/build-iso.sh

Output if successful: `dist/smol-trixie-amd64-live.iso` and a SHA-256 file. GitHub Actions `Build SMOL ISO` builds automatically on pushes and uploads the ISO ZIP as an artifact (with a 7-day retention period).

This is a **live-only source prototype**, not a disk installer. ISO creation alone does not demonstrate successful booting, desktop appearance, or Cua agent operation. The image build downloads and installs the upstream Cua Driver and fails if it cannot be installed.

## Agent-driven GUI testing

Cua Driver is installed in the live image by default. Connect trusted agents locally via stdio MCP; do not expose uncontrolled remote desktop access.

    cua-driver doctor
    cua-driver mcp

SMOL has one application QA skill, at [skills/smol-app-qa/SKILL.md](skills/smol-app-qa/SKILL.md). There is no separate QA recording or evidence service.

To install larger applications after boot (requires network access and writable session):

    sudo apt update
    sudo apt install chromium flatpak distrobox

For Distrobox, also install/configure a container engine such as Podman. For AppImage compatibility, SMOL includes `libfuse2t64`.

## Validation

    bash scripts/validate-layout.sh
    bash -n scripts/*.sh

Automated source and ISO-build checks are not substitutes for a VM boot test, a driver smoke test and a measured RAM budget.

SMOL-original code and artwork: MIT (LICENSE). Upstream Debian and Cua components retain their own licenses. SMOL is independent of both.
