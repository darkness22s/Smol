# SMOL Linux

SMOL is an experimental, lightweight, agent-friendly Linux distribution project built on Debian 13 (Trixie), LXQt, and X11. It aims for less than 2 GiB RAM during selected basic tasks, broad Linux app compatibility, and repeatable agent-driven GUI QA via Cua Driver.

This is early-stage source code, not a tested downloadable operating system. ISO building, actual boot, RAM use, and Cua Driver interoperability must be validated on physical hardware and VMs.

## Initial architecture

- Debian live-build creates an amd64 live ISO from a minimal LXQt/X11 package set.
- SMOL branding is applied through desktop defaults and an original SVG wallpaper.
- Cua Driver is installed on demand by the local user and exposed to trusted agents over stdio MCP. It is not silently preinstalled or exposed on a network port.
- An opt-in QA runner captures launch logs, optional screenshots, timing, and process RAM observations.

Read docs/ARCHITECTURE.md and docs/QUICKSTART.md after the project scaffolding is committed.

## Status

**Prototype / unverified.** The build scripts and integration are a starting point, not a supported release.

## License

Original SMOL code and art: MIT (see LICENSE). Upstream Debian packages, Cua Driver, and other dependencies retain their own licenses.
