# Mining Data API plugin for Claude Code and ChatGPT

One package, two layouts: the Claude Code manifest (`.claude-plugin/`,
`.mcp.json`, `commands/`) and the portable Agent Plugins manifest OpenAI
reads (`plugin.json`, `mcp.json`, `skills/*/agents/openai.yaml`, `assets/`).
Both point at the same MCP server (`https://api.miningdataapi.com/mcp`) and
share the `mining-data` skill. It ships no hooks, no agents, no scripts and
no secrets.

Requires an active Mining Data API subscription. Free accounts can install
the plugin and list its tools, but every data tool returns
`subscription_required` with a link to the public pricing page until the
organisation is on a paid plan. The plugin never starts a purchase itself.


## Install

```
/plugin marketplace add OreStocks/miningdataapi-plugins
/plugin install miningdataapi@orestocks
/mcp                       # pick "miningdataapi" and sign in in the browser
```

The sign-in runs through the Mining Data API portal (OAuth 2.1). No API key
is needed; Claude Code keeps the token in its credential store.
`claude mcp logout miningdataapi` forgets it, and uninstalling the plugin
removes it too.

To use an API key instead (CI, shared machines), skip the plugin and run:

```
claude mcp add --transport http miningdataapi https://api.miningdataapi.com/mcp \
  --header "Authorization: Bearer os_live_…"
```

## ChatGPT

ChatGPT does not install from this repository. Two paths:

- Personal use: ChatGPT → Settings → Security and login → Developer mode,
  then Plugins → Add → Create MCP App with the server URL and OAuth. The
  server itself is the plugin; the skill here is optional context.
- Public listing: OreStocks uploads the portable package built by
  `scripts/build-openai-package.sh` to the OpenAI plugin portal
  (platform.openai.com/plugins → Upload new or existing plugin → With MCP).

### Submission checklist

What the package already carries (`plugin.json` → `extensions.com.openai`):
listing text and URLs, icons in `assets/`, brand colours, the five positive
and three negative review test cases, `commerce: false`, release notes.
`mcp.json` declares OAuth with dynamic client registration; the server
advertises its registration endpoint through discovery.

Before building the ZIP:

1. Record the reviewer walkthrough video and set
   `extensions.com.openai.review.demo_recording_url` in `plugin.json`
   (the build script refuses to package without it).
2. Bump `version` in both `plugin.json` and `.claude-plugin/plugin.json`
   and add a `CHANGELOG.md` entry; the portal rejects re-uploads with the
   same version.

In the portal, outside the ZIP:

3. Verified developer or business identity in the OpenAI organization
   settings (the directory shows it as the developer name).
4. Domain verification: copy the token from the MCPs tab, set it as the
   `OPENAI_APPS_CHALLENGE` variable on the API's `prod` GitHub environment,
   redeploy, and confirm `https://api.miningdataapi.com/.well-known/openai-apps-challenge`
   returns it as plain text.
5. Reviewer credentials under Review details: a dedicated prod account on a
   paid plan with sample data, signing in with email and password only (no
   Google sign-in, MFA or magic link). Keep it alive for later reviews.
6. Submit for review and accept the policy attestations. After approval,
   press Publish plugin.

Tool changes on the server need no new package: OpenAI rescans daily, or
press Rescan under Issues after a deploy. The MCP URL cannot change after
submission without contacting OpenAI support.

## Commands (Claude Code)

- `/miningdataapi:screen-drills gold 30`
- `/miningdataapi:company-brief RIO.AX`

Both commands are limited to the Mining Data API tools (`allowed-tools`);
they cannot run shell commands or touch files.

## What it can access

Read-only mining data your plan includes. The tools cannot write anything,
and nothing on your machine is sent to the server except the tool arguments
Claude composes (filters, ids, tickers). See [SECURITY.md](../../SECURITY.md).

## Layout

```
plugin.json                          portable manifest (OpenAI reads this; listing + review metadata under extensions.com.openai)
mcp.json                             portable remote MCP server (streamable-http, https, OAuth via dynamic client registration)
assets/*.svg                         directory listing icons (logo, composer icon, light and dark)
.claude-plugin/plugin.json           Claude Code manifest
.mcp.json                            Claude Code remote MCP server entry
skills/mining-data/SKILL.md          how to query the dataset well (shared)
skills/mining-data/agents/openai.yaml OpenAI skill interface + MCP dependency
commands/*.md                        Claude Code slash commands
```
