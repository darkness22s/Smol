# SMOL desktop: reference-inspired design

The supplied screenshot has a saturated ultramarine sky, cream-and-blue desert mesas, an angular white central wordmark and a translucent centered dock with three application icons. SMOL reproduces these elements using a scalable, original SVG wallpaper and a functional Plank dock.

- Wallpaper: image/config/includes.chroot/usr/share/backgrounds/smol/smol.svg
- Wordmark: SMOL instead of the screenshot's SAMEN, keeping SMOL's established name.
- Dock: Plank configured to stay at the bottom center, 58-pixel icons, a semi-transparent glass theme.
- Buttons: Chromium (browser), PCManFM-Qt (files), LXQt Configuration Center (settings).
- Effects: picom xrender compositor for lightweight alpha transparency.
- Default LXQt panel: disabled in the user session to avoid a second bottom bar.

This is a source configuration, not a validated screenshot of the booted desktop. LightDM, LXQt module suppression, transparency, dock placement and icons must be checked in the ISO GUI session.

A custom desktop is allowed to exceed the idle RAM target if tested; measure instead of assuming a fixed budget. For a machine without acceleration, picom can be disabled in LXQt Session Settings.
