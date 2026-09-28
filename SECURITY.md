# Security

## Reporting a vulnerability

Email **security@miningdataapi.com** (or support@miningdataapi.com). Please
include steps to reproduce and do not open a public issue for anything
exploitable. We acknowledge reports within two business days.

## What this repository can and cannot do

This repository ships a Claude Code plugin. Claude Code runs plugin
components with the user's privileges, so we keep the attack surface as
small as the format allows:

| Component | Present | Notes |
|---|---|---|
| Remote MCP server (`.mcp.json`) | Yes | One https URL, no headers, no environment variables. OAuth handled by Claude Code. |
| Skill | Yes | Markdown only. Restricts itself to the plugin's MCP tools via `allowed-tools`. |
| Slash commands | Yes | Markdown only. Each lists exactly the MCP tools it may call. No shell preprocessing. |
| Hooks | No | The plugin never executes commands on your machine. |
| Agents | No | |
| Scripts, binaries, node modules | No | |
| Credentials | No | Sign-in happens in your browser through the Mining Data API portal. |

If a future version adds any of the "No" rows, the change log and the
plugin's version will say so explicitly.

## How to verify

1. `claude plugin validate plugins/miningdata --strict` checks the manifest
   and that no file escapes the plugin directory.
2. Read the three markdown files and `.mcp.json`; that is the whole plugin.
3. Pin a tag: in your own marketplace entry use
   `{"source": "github", "repo": "OreStocks/miningdataapi-plugins", "ref": "v1.0.0"}`
   so `/plugin marketplace update` never pulls an unreviewed change.

## What the server can see

Only what Claude sends as tool arguments: filters, record ids, tickers,
company names, SQL text on enterprise plans. The server is read-only and
never receives files, environment variables or local paths. Requests are
rate limited per user and logged with your organisation id for usage
accounting, in line with the Mining Data API terms.

## Prompt injection

Dataset content comes from public filings and is treated as untrusted. The
skill instructs Claude to treat tool results as data, never as
instructions, and the commands are locked to read-only tools so a poisoned
record cannot escalate into file or shell access. Report suspicious content
to support@miningdataapi.com and we will quarantine the record.

## Revoking access

- `claude mcp logout miningdata` clears the token on your machine.
- The Mining Data API dashboard, "AI plugins" section, lists connected apps
  and revokes them server-side (all sessions and refresh tokens end).
- Uninstalling the plugin removes its stored credentials.

## Supply chain

- Pull requests require a review from a CODEOWNER; the default branch is
  protected and commits are expected to be signed.
- CI validates both manifests on every push and pull request.
- Releases are git tags matching the plugin version.
- There are no dependencies to update.
