---
name: smol-app-qa
description: Test Linux GUI apps on SMOL using bundled Cua Driver; assert UI outcomes from live observations and report directly in the conversation.
---

# SMOL app QA agent skill

This is the **only** SMOL application QA facility. Do not create evidence folders, screenshot archives, log collectors, JSON reports, test daemons or automated QA recorders. Return a short PASS/FAIL/BLOCKED assessment to the user after actually testing the application.

## Prerequisites

- Run in a disposable SMOL graphical session under an unprivileged test user.
- Cua Driver is bundled by default. Never try to install it as an opt-in step.
- Confirm the active X11/XWayland desktop and AT-SPI environment. Use cua-driver doctor and cua-driver call list_apps to check desktop access.
- Use the active local Cua Driver MCP tools or the cua-driver call CLI for computer interaction; the local stdio MCP server command is cua-driver mcp.
- If the agent cannot observe the real UI, mark the test BLOCKED rather than guessing.

## Agent workflow

1. Identify the target application, its launch method and the specific behaviors the user wants tested.
2. Start the app in the testing desktop. Use Cua to locate its actual window and obtain a fresh UI snapshot.
3. Perform actions with Cua: focus controls, click, type, navigate and submit. Follow the tools available in the active Cua Driver MCP schema or CLI help; do not guess argument names.
4. Request a fresh snapshot after every meaningful action. Old window selectors and element indices can go stale.
5. Compare observed UI values and states to expected outcomes. Do not answer from general knowledge and pretend the UI confirmed it.
6. Report the result for each scenario as PASS, FAIL, or BLOCKED with the observed behavior and remaining uncertainty. No evidence files are required.
7. Close the app when appropriate and leave the test session clean.

## Default tests if none specified

Check that the app launches, presents its main window, responds to its primary action, and shows the expected changed state. For a calculator, enter 6 times 7 through the real UI and verify the displayed result is 42 from a new snapshot.

## Safety

Only test apps and actions the user has authorized. Never approve privilege prompts, make payments, remove user data, access personal accounts, or expose the desktop on a public network without explicit authorization. Use a clean VM for untrusted apps. If a safe test cannot be performed, say BLOCKED.

Upstream Cua Driver quickstart: https://cua.ai/docs/cua-driver/quickstart
