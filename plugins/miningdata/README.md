# Mining Data API plugin for Claude Code and ChatGPT

One package, two layouts: the Claude Code manifest (`.claude-plugin/`,
`.mcp.json`, `commands/`) and the portable Agent Plugins manifest OpenAI
reads (`plugin.json`, `mcp.json`, `skills/*/agents/openai.yaml`). Both point
at the same MCP server (`https://api.miningdataapi.com/mcp`) and share the
`mining-data` skill. It ships no hooks, no agents, no scripts and no secrets.

Requires an active Mining Data API subscription. Free accounts can install
the plugin and list its tools, but every data tool returns
`subscription_required` with an upgrade link until the organisation is on a
paid plan.

## Install

```
/plugin marketplace add OreStocks/miningdataapi-plugins
/plugin install miningdata@orestocks
/mcp                       # pick "miningdata" and sign in in the browser
```

The sign-in runs through the Mining Data API portal (OAuth 2.1). No API key
is needed; Claude Code keeps the token in its credential store.
`claude mcp logout miningdata` forgets it, and uninstalling the plugin
removes it too.

To use an API key instead (CI, shared machines), skip the plugin and run:

```
claude mcp add --transport http miningdata https://api.miningdataapi.com/mcp \
  --header "Authorization: Bearer os_live_…"
```

## ChatGPT

ChatGPT does not install from this repository. Two paths:

- Personal use: ChatGPT → Settings → Security and login → Developer mode,
  then Plugins → Add → Create MCP App with the server URL and OAuth. The
  server itself is the plugin; the skill here is optional context.
- Public listing: OreStocks submits the server through the OpenAI plugin
  portal (Create plugin → With MCP) and uploads this folder's `skills/` in
  the same draft. Uploading this folder as an archive also works but is
  marked Desktop only because it declares `mcp.json`.

## Commands (Claude Code)

- `/miningdata:screen-drills gold 30`
- `/miningdata:company-brief RIO.AX`

Both commands are limited to the Mining Data API tools (`allowed-tools`);
they cannot run shell commands or touch files.

## What it can access

Read-only mining data your plan includes. The tools cannot write anything,
and nothing on your machine is sent to the server except the tool arguments
Claude composes (filters, ids, tickers). See [SECURITY.md](../../SECURITY.md).

## Layout

```
plugin.json                          portable manifest (OpenAI reads this; listing metadata under extensions.com.openai)
mcp.json                             portable remote MCP server (streamable-http, https, OAuth)
.claude-plugin/plugin.json           Claude Code manifest
.mcp.json                            Claude Code remote MCP server entry
skills/mining-data/SKILL.md          how to query the dataset well (shared)
skills/mining-data/agents/openai.yaml OpenAI skill interface + MCP dependency
commands/*.md                        Claude Code slash commands
```
