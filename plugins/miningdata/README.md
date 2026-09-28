# Mining Data API plugin for Claude Code

Adds the Mining Data API MCP server (`https://api.miningdataapi.com/mcp`), a
skill that teaches Claude the filter vocabulary and citation rules, and two
slash commands. It ships no hooks, no agents, no scripts and no secrets.

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

## Commands

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
.claude-plugin/plugin.json   manifest
.mcp.json                    remote MCP server (https, OAuth)
skills/mining-data/SKILL.md  how to query the dataset well
commands/*.md                slash commands
```
