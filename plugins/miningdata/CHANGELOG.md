# Changelog

## 1.2.0

- ChatGPT directory submission package: the portable manifest is now
  `miningdataapi` (shown as "MiningDataAPI"), declares OAuth with dynamic
  client registration in `mcp.json`, ships listing icons under `assets/`
  and carries the review block OpenAI imports (five positive and three
  negative test cases, release notes). `scripts/build-openai-package.sh`
  builds the ZIP to upload. The Claude Code plugin id stays `miningdata`.

## 1.1.0

- Portable Agent Plugins manifest for ChatGPT and Codex (`plugin.json`,
  `mcp.json`, `skills/mining-data/agents/openai.yaml`) alongside the Claude
  Code layout. Same server, same skill, no new capabilities.

## 1.0.0

- Initial release: remote MCP server over OAuth, `mining-data` skill,
  `/miningdata:screen-drills` and `/miningdata:company-brief`.
