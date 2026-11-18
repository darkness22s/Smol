# SMOL Linux

**Small desktop. Big automation.**

SMOL is an experimental Debian 13 (Trixie) live distribution for lean desktop use, broad Linux app compatibility, and AI-assisted GUI quality assurance. The first prototype uses LXQt + X11 and an opt-in Cua Driver installer.

**Status: source prototype, not a tested OS release.** ISO creation, actual booting, Cua functionality, and memory targets have not yet been validated.

## Goals

- Target under 700 MiB of RAM at idle and at most 2048 MiB for a defined basic-task suite; neither is a guarantee.
- Support Debian apt packages, Flatpak, AppImage where compatible, and Distrobox environments. Not every Linux binary is universally runnable.
- Integrate upstream Cua Driver for trusted agents via local stdio MCP, while keeping network-facing automation disabled.
- Make QA easier with a launcher/evidence recorder for logs, screenshots (with consent), and RAM measurements.

## Build on Debian 13 amd64

    sudo apt update
    sudo apt install -y live-build debootstrap squashfs-tools xorriso grub-efi-amd64-bin grub-pc-bin
    sudo bash scripts/build-iso.sh

If successful, the live ISO is copied to dist/smol-trixie-amd64-live.iso. There is no disk installer yet.

## Developer checks

    bash scripts/validate-layout.sh
    python3 -m unittest discover -s tests -v
    bash -n scripts/*.sh

## On SMOL: enable agents and QA

Open the application-menu item "Install Cua Driver (opt-in)" or run:

    smol-install-cua
    smol-doctor

Connect a trusted local MCP client with command "cua-driver" and argument "mcp" (see agent/cua-driver.mcp.json). Installation is deliberately not automatic at boot.

    smol-qa --name calculator --duration 20 --screenshot -- galculator

The QA runner produces evidence for an agent or human to inspect; it does not fabricate a visual test verdict.

Read docs/QUICKSTART.md, docs/ARCHITECTURE.md, docs/AGENTS.md and docs/SECURITY.md.

## License

SMOL-original code and artwork: MIT (LICENSE). Third-party components remain under their respective licenses. SMOL is unaffiliated with Debian and Cua.
