# SMOL desktop: reference-inspired design

The reference image has a saturated blue sky, desert mesas, a bold white wordmark and a translucent centered dock. SMOL retains these elements as an original vector wallpaper and a functional Plank dock.

- Wallpaper: image/config/includes.chroot/usr/share/backgrounds/smol/smol.svg
- Wordmark: SMOL, matching the distro name.
- Dock: Plank, bottom center with 58-pixel icons and a transparent theme.
- Buttons: NetSurf (lightweight browser), PCManFM-Qt (files), LXQt Configuration Center (settings).
- Effects: picom XRender compositor.
- LXQt panel: disabled to avoid a second bottom bar.

**Size trade-off:** Chromium was removed from the live image to target a roughly 700 MB ISO. NetSurf does not have Chromium's modern JavaScript/web-application compatibility. After boot, install Chromium via `sudo apt update && sudo apt install chromium` if browser QA requires it. Flatpak and Distrobox can also be installed separately.

The desktop design has not been verified by an actual graphical boot test. The dock, launcher, display manager, X11 session, desktop wallpaper and Cua Driver still need runtime testing.
