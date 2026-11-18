# SMOL Linux

**Small desktop. Big automation.**

SMOL is an experimental Debian 13 (Trixie) live Linux distribution with LXQt/X11 and **Cua Driver built in** for agent-friendly computer use. This source project targets ≤2 GiB RAM for a defined set of basic tasks; the figure is not yet verified, and arbitrary apps can exceed it.

## Desktop styling

Inspired by the supplied desktop reference: a saturated blue sky, bright canyon desert, bold white **SMOL** wordmark, and **centered translucent three-icon dock**. Unlike a screenshot, all three icons are functional: **Chromium**, **Files**, and **Settings**. See [Desktop design](docs/DESKTOP.md). The design is encoded as default files in the live ISO.

## Build SMOL ISO

On Debian 13 (amd64):

    sudo apt update
    sudo apt install -y live-build debootstrap squashfs-tools xorriso grub-efi-amd64-bin grub-pc-bin
    sudo bash scripts/build-iso.sh

On success: dist/smol-trixie-amd64-live.iso (and SHA-256). GitHub Actions has an automated ISO build workflow under Actions → Build SMOL ISO; if it completes, its ZIP artifact contains the ISO and checksum.

**Prototype status:** neither the ISO nor its graphical appearance and Cua integration has been confirmed boot-tested. No disk installer is included yet. The build downloads third-party Cua Driver during the image build and fails if it is unavailable.

## AI application testing

Cua is installed in the image by default; agent connections remain local to the test desktop unless an authorized operator explicitly configures a secure transport.

    cua-driver doctor
    cua-driver mcp

Use the **single** agent QA skill at [skills/smol-app-qa/SKILL.md](skills/smol-app-qa/SKILL.md). There is no separate QA evidence logger, recorder or daemon. Broad Linux app support includes apt, Flatpak, compatible AppImages and Distrobox, within the usual architecture/dependency limits.

## Validation

    bash scripts/validate-layout.sh
    bash -n scripts/*.sh

The source CI performs syntax and configuration checks; real installation, boot and GUI tests are separate milestones.

SMOL-original code and artwork: MIT (LICENSE). All upstream components retain their own licenses. SMOL is an independent project.
