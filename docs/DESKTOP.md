# SMOL desktop: reference-inspired design

SMOL's full ISO is based on Debian 13, LXQt, Openbox and X11. Its desktop aims to reproduce the supplied blue-sky/canyon reference with a white SMOL wordmark and a centered, translucent three-icon dock.

## Wallpaper: reliable in QEMU

The source artwork lives at `image/config/includes.chroot/usr/share/backgrounds/smol/smol.svg`. The `0300-render-wallpaper.hook.chroot` build hook converts this SVG into `/usr/share/backgrounds/smol/smol.png` using `rsvg-convert`, and fails the build if conversion fails. The PCManFM-Qt `lxqt` profile is configured system-wide and for new users to use that PNG in `fit` mode. At login, `smol-desktop-session` starts the desktop module and applies the wallpaper explicitly.

## Dock: stable, always visible

The earlier Plank setup was appearing as a clipped strip in QEMU. SMOL now uses **Tint2**: a fixed-size, bottom-center dock rendered on the top window layer without any auto-hide. Configuration: `/etc/xdg/smol/tint2rc`.

- Chromium (real browser), Files (PCManFM-Qt), Settings (LXQt Configuration Center).
- Icons stay clickable and visible even when compositing is unavailable; optional Picom makes the dock translucent.
- The default LXQt panel remains disabled to keep a clean three-button desktop.

## Validation

After booting the newly built ISO in QEMU, confirm the blue wallpaper and all three dock icons appear. Open Chromium from the left icon and test a web page; run `cua-driver doctor` in a terminal.

If the wallpaper does not appear, try:

```bash
pcmanfm-qt --desktop --profile=lxqt
pcmanfm-qt --profile=lxqt --set-wallpaper=/usr/share/backgrounds/smol/smol.png --wallpaper-mode=fit
```

If the dock is missing:

```bash
tint2 -c /etc/xdg/smol/tint2rc
```

Visual and Cua-driver runtime behavior require a VM test; a successful ISO build cannot prove them by itself.
