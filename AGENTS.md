# SMOL coding-agent guidance

SMOL is an unverified Debian 13 / LXQt / X11 source prototype. Do not claim an ISO boots or a 2 GiB target is met without evidence.

Use [SMOL app QA skill](skills/smol-app-qa/SKILL.md) as the **only** QA agent workflow. There is no standalone QA runner or evidence collector. Use Cua Driver preinstalled during ISO building. Agent sessions use local stdio MCP, not an unauthenticated internet-accessible server.

Before submitting changes, run bash scripts/validate-layout.sh and bash -n scripts/*.sh. Distinguish real boot and integration tests from source-only checks.
