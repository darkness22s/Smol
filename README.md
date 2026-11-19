# SMOL Linux

**Small desktop. Big automation.**

SMOL is a Debian 13 (Trixie) live Linux distribution prototype with LXQt/X11 and **Cua Driver bundled by default** to support agent-controlled GUI testing. The current ISO is the **full edition**; the previous 700 MB limit is no longer a goal.

## Desktop

The blue desert reference design is implemented as a vector SMOL wallpaper that is also rendered as a PNG at ISO build time for compatibility with PCManFM-Qt and QEMU. A fixed, always-visible **Tint2** dock replaces the Plank configuration that was clipped in QEMU. The three dock buttons launch **Chromium**, **Files** and **Settings**. See [docs/DESKTOP.md](docs/DESKTOP.md).

## Full edition

Chromium is present in the image rather than replaced with NetSurf. The full ISO also includes Flatpak, Distrobox, Git, CLI automation tools, the Debian package manager and common desktop dependencies. Not every Linux binary can run natively on every architecture, and Distrobox depends on a container runtime.

## Build ISO

On Debian 13 amd64:

```bash
sudo apt update
sudo apt install -y live-build debootstrap squashfs-tools xorriso grub-efi-amd64-bin grub-pc-bin
sudo bash scripts/build-iso.sh
```

On success, get `dist/smol-trixie-amd64-live.iso` and its `sha256`. On GitHub, the [Build SMOL ISO workflow](https://github.com/darkness22s/Smol/actions/workflows/build-iso.yml) runs for every push to `main`. Its artifacts contain the ISO and checksum.

The ISO is **live-only**, not a disk installer. A successful build proves package/image assembly, **not** runtime desktop rendering or reliable computer-use functionality. Please boot-test on QEMU or real hardware.

## Cua Driver and app QA skill

Cua is installed in the image during the build, and available to trusted local agents through stdio MCP:

```bash
cua-driver doctor
cua-driver mcp
```

The only SMOL QA agent workflow is [skills/smol-app-qa/SKILL.md](skills/smol-app-qa/SKILL.md). No separate QA evidence logger or recorder is included.

## Validation

```bash
bash scripts/validate-layout.sh
bash -n scripts/*.sh
```

CI also validates bundled Chromium/Tint2/PCManFM-Qt and the wallpaper PNG conversion hook during the ISO build.

SMOL targets low idle RAM but has not passed a measured 2 GB workload test. Large Chromium pages and other applications may exceed that budget.

Original SMOL code and artwork are MIT licensed (LICENSE). Third-party code remains under its respective licenses.
