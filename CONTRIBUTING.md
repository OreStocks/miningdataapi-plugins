# Contributing

Thanks for helping. This repository is intentionally tiny; most changes are
wording in the skill and commands.

## Rules

- Keep the plugin markdown-only. No hooks, agents, scripts, binaries or
  dependencies will be accepted; see [SECURITY.md](SECURITY.md).
- `.mcp.json` points at `https://api.miningdataapi.com/mcp` and nothing
  else. No headers, no environment expansion.
- Commands and skills list the MCP tools they need in `allowed-tools`; do
  not widen to `*` or to non-MCP tools.
- Bump `version` in `plugins/miningdata/.claude-plugin/plugin.json` and
  `plugins/miningdata/CHANGELOG.md` for every user-visible change.

## Checks

```
claude plugin validate . --strict
claude plugin validate plugins/miningdata --strict
```

CI runs the same commands. A CODEOWNER review is required to merge.

## Releasing

Tag the merge commit `v<version>` (matching `plugin.json`). Users who pin a
tag pick it up when they choose; everyone else gets it on
`/plugin marketplace update`.
