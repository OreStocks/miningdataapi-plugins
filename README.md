# Mining Data API plugin for Claude Code

Public home of the Claude Code marketplace `miningdataapi`. The Mining Data API
itself is closed source; this repository holds only the thin client-side
plugin: a pointer to the remote MCP server, a skill and two slash commands.

| Plugin | What it does | Requires |
|---|---|---|
| [`miningdataapi`](plugins/miningdataapi) | Mining Data API in Claude Code: drill results and financial statements | A Mining Data API account on any plan |

## Install

```
/plugin marketplace add OreStocks/miningdataapi-plugins
/plugin install miningdataapi@miningdataapi
/mcp
```

The same folder carries the portable Agent Plugins manifest OpenAI reads
(`plugin.json`, `mcp.json`, `skills/*/agents/openai.yaml`), which is what
is listed in the ChatGPT plugin directory as
<https://chatgpt.com/plugins/plugin_asdk_app_6adb8169bdec8191b6c394a846b084b5>.
ChatGPT users install it there; Claude (web, desktop, mobile) users add
`https://api.miningdataapi.com/mcp` as a custom connector and sign in.
Neither needs this repository. Steps at <https://miningdataapi.com/plugins>.

## Trust

- The plugin contains no hooks, agents, scripts, binaries or credentials.
  Everything it can do is visible in a few small text files.
- The MCP server is reached over https only and authenticates you with
  OAuth 2.1 through the Mining Data API portal. Tokens stay in Claude Code's
  credential store.
- Every tool is read-only and annotated as such.
- Releases are tagged and the manifests are validated in CI with
  `claude plugin validate --strict`. Pin a tag in your own marketplace if
  you want to review updates before taking them.

Security policy and reporting: [SECURITY.md](SECURITY.md).

## ChatGPT listing

Maintainer notes for the ChatGPT plugin directory. Paths are relative to
`plugins/miningdataapi/`.

ChatGPT does not install from this repository. Two paths:

- Personal use: ChatGPT → Settings → Security and login → Developer mode,
  then Plugins → Add → Create MCP App with the server URL and OAuth. The
  server itself is the plugin; the skill here is optional context.
- Public listing: we upload the portable package built by
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
5. Reviewer credentials under Review details: a dedicated prod account on the
   Business plan (one review test case is a commodity screen, which lower
   plans answer with a count), signing in with email and password only (no
   Google sign-in, MFA or magic link). Keep it alive for later reviews.
6. Submit for review and accept the policy attestations. After approval,
   press Publish plugin.

Tool changes on the server need no new package: OpenAI rescans daily, or
press Rescan under Issues after a deploy. The MCP URL cannot change after
submission without contacting OpenAI support.

## Development

```
claude plugin validate . --strict
claude plugin validate plugins/miningdataapi --strict
```

Changes go through pull requests with a required review. See
[CONTRIBUTING.md](CONTRIBUTING.md).

### Layout of `plugins/miningdataapi/`

```
README.md                            Claude Directory listing description
plugin.json                          portable manifest (OpenAI reads this; listing + review metadata under extensions.com.openai)
mcp.json                             portable remote MCP server (streamable-http, https, OAuth via dynamic client registration)
assets/*.svg                         directory listing icons (logo, composer icon, light and dark)
.claude-plugin/plugin.json           Claude Code manifest
.mcp.json                            Claude Code remote MCP server entry
skills/mining-data/SKILL.md          how to query the dataset well (shared)
skills/mining-data/agents/openai.yaml OpenAI skill interface + MCP dependency
commands/*.md                        Claude Code slash commands
```

## License

MIT for everything in this repository. The Mining Data API service and
dataset are governed by the Mining Data API terms of service.
