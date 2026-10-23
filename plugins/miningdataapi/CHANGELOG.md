# Changelog

## 1.2.0

- ChatGPT directory submission package: the portable manifest is now
  `miningdataapi` (shown as "Mining Data API"), declares OAuth with dynamic
  client registration in `mcp.json`, ships listing icons under `assets/`
  and carries the review block OpenAI imports (five positive and three
  negative test cases, release notes). `scripts/build-openai-package.sh`
  builds the ZIP to upload.
- Renamed from `miningdata` to `miningdataapi` everywhere: plugin id, MCP
  server key, tool prefix (`mcp__plugin_miningdataapi_miningdataapi__*`)
  and slash commands (`/miningdataapi:screen-drills`,
  `/miningdataapi:company-brief`). Existing installs: `/plugin uninstall
  miningdata@orestocks`, then install `miningdataapi@orestocks`.

## 1.1.0

- Portable Agent Plugins manifest for ChatGPT and Codex (`plugin.json`,
  `mcp.json`, `skills/mining-data/agents/openai.yaml`) alongside the Claude
  Code layout. Same server, same skill, no new capabilities.

## 1.0.0

- Initial release: remote MCP server over OAuth, `mining-data` skill,
  `/miningdata:screen-drills` and `/miningdata:company-brief`.
