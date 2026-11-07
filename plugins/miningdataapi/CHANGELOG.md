# Changelog

## 1.3.6

- The plugin README is the Claude Directory listing description: what you can ask, what the plugin contains, sign-in, what it sends and keeps, troubleshooting and support. The ChatGPT submission notes and the file layout moved to the repository README.
- `supportUrl` names support@miningdataapi.com, the support channel the Directory Policy asks for.

## 1.3.5

- Directory links name only pages that exist for what the field says: the homepage is miningdataapi.com, and `supportUrl` and `documentationUrl` are removed until there is a support page and plugin documentation.

## 1.3.4

- The Claude Directory listing reads its name and links from the Claude Code manifest: it now sets `displayName` (Mining Data API), `supportUrl`, `documentationUrl`, `termsOfServiceUrl` and `repository`, and the description names Claude rather than Claude Code, since the directory lists it in every Claude app.

## 1.3.3

- The Claude Code manifest declares `privacyPolicyUrl` (https://miningdataapi.com/privacy), which the Claude Directory requires of plugins that connect to a remote MCP server.

## 1.3.2

- The free sample serves records without `source_url` (the API names it in `locked`); the skill and `company-brief` cite the plain record id there and say that source links start at the next plan.

## 1.3.1

- The skill and `company-brief` no longer name financings, projects or technical reports: the server announces only the datasets on sale, and other datasets open on request.
- The OpenAI listing no longer names plans or pricing (review finding: no pricing or subscription offers in the description). The commerce note, the release notes and the screening test case describe behaviour without naming a plan.

## 1.3.0

- The listing, the skill and both commands describe what is sold at launch: drill
  results and financial statements. Financings, projects and technical reports
  are in early access on request; their tools answer `dataset_not_in_plan`.
- Plan-aware screening: `screen-drills` reads `beyond` before going on. Below
  Business the commodity filter is a screen (count only), so the command screens
  the headline flow by hand and says so; on the free plan it moves the window
  into the April 2026 sample.
- The skill names the error codes the server actually raises
  (`dataset_not_in_plan`, `plan_required`, `budget_exhausted`,
  `company_cap_reached`, `daily_records_cap`); `subscription_required` never was one.
- Citations link to `miningdataapi.com/source/...` pages, and the texts no longer
  name OreStocks. The OpenAI package carries the same scope, new default prompts
  and review test cases (the reviewer account should be on Business).
- The marketplace is now `miningdataapi`, so the plugin installs as `miningdataapi@miningdataapi`. If you added the old `orestocks` marketplace, remove it and add it again.
- The Claude Code listing names the datasets on sale and says every plan can connect.

## 1.2.3

- `screen-drills` sorts by release date and ranks on the reported intercepts: the API no longer serves a drill score.

## 1.2.2

- Citations link to the source: every record now carries `source_url`, the
  orestocks.com page of the filing or press release it was extracted from.
  The skill and both commands ask for the column and write record ids as
  links to it, so a reader can open the document (filings ask for a free
  orestocks.com sign-in) instead of trusting the summary.

## 1.2.1

- Listing text no longer mentions subscriptions or paid plans (OpenAI
  review finding); it leads with what the plugin does. `tools_triggered`
  in the review block is a string, as the Codex overlay requires.

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
