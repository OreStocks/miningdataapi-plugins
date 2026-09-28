# OreStocks plugins for Claude Code

Public home of the Claude Code marketplace `orestocks`. The Mining Data API
itself is closed source; this repository holds only the thin client-side
plugin: a pointer to the remote MCP server, a skill and two slash commands.

| Plugin | What it does | Requires |
|---|---|---|
| [`miningdata`](plugins/miningdata) | Mining Data API in Claude Code: drill results, financings, financial statements, projects, technical reports, spin-outs | Active [Mining Data API](https://miningdataapi.com) subscription |

## Install

```
/plugin marketplace add OreStocks/miningdataapi-plugins
/plugin install miningdata@orestocks
/mcp
```

ChatGPT and Claude (web, desktop, mobile) do not need this repository: add
`https://api.miningdataapi.com/mcp` as a connector and sign in. Steps at
<https://miningdataapi.com/plugins>.

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

## Development

```
claude plugin validate . --strict
claude plugin validate plugins/miningdata --strict
```

Changes go through pull requests with a required review. See
[CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT for everything in this repository. The Mining Data API service and
dataset are governed by the Mining Data API terms of service.
