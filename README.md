# SMOL Linux

**Small desktop. Big automation.**

SMOL is an experimental Debian 13 (Trixie) Linux live distribution built around a lightweight LXQt/X11 desktop, common Linux applications, and the Cua Driver computer-use platform.

**Cua Driver is included by default at ISO build time.** For application testing there is **one agent skill**: [SMOL app QA](skills/smol-app-qa/SKILL.md). No standalone QA runner, evidence collector, screenshot archive, or QA daemon.

## Status

Source prototype. A successful ISO build, GUI boot, Cua integration and memory performance have not yet been validated. Goals are <700 MiB at idle and <=2 GiB for defined basic tasks; not guarantees for arbitrary apps, browsers, or local models.

## Build on Debian 13 amd64

    sudo apt update
    sudo apt install -y live-build debootstrap squashfs-tools xorriso grub-efi-amd64-bin grub-pc-bin
    sudo bash scripts/build-iso.sh

A successful build creates dist/smol-trixie-amd64-live.iso. The image is live-only, not a disk installer. During the build, the image chroot downloads and installs Cua Driver system-wide from the official upstream release; it fails if the driver cannot be installed. An internet connection is required.

## App compatibility

Debian apt packages, Flatpak, compatible AppImages and Distrobox userspaces. No Linux distro can literally run every Linux binary regardless of architecture, drivers or dependencies.

## Agent integration and QA

Cua Driver is preinstalled in SMOL. In the logged-in X11 desktop session:

    cua-driver doctor
    cua-driver call list_apps

An authorized local agent connects through stdio MCP using the command cua-driver mcp (example in agent/cua-driver.mcp.json). The [SMOL app QA skill](skills/smol-app-qa/SKILL.md) teaches the agent to operate applications and verify outcomes from fresh UI observations, returning PASS/FAIL/BLOCKED directly to the user.

The driver is built in, but SMOL does not publish unauthenticated network access to the desktop.

## Automated source checks

    bash scripts/validate-layout.sh
    bash -n scripts/*.sh

GitHub Actions checks these on every push and pull request. These source checks are not a replacement for building and boot-testing an ISO.

## License

Original SMOL code and artwork: MIT (LICENSE). Debian, Cua Driver and other upstream packages retain their own licenses. SMOL is independent of Debian and Cua.
