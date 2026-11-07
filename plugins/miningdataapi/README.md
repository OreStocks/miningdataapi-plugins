# Mining Data API

Structured facts from the public filings of listed mining companies, inside
Claude: drill results with every hole and interval, and financial statements
with cash, expenses, runway, options and warrants. Claude cites the record
each fact comes from.

## What you can ask

- Show me ABRA.TO's latest drill results with holes, intervals and grades.
- What does ABRA.TO's latest financial statement show: cash, expenses, runway, options and warrants?
- Build a briefing on ABRA.TO: drilling, cash and runway, options and warrants.
- Which drill results came out this week, and what was the best intercept in each?
- How much of my Mining Data API quota have I used this month?

## What the plugin contains

- A remote MCP server at `https://api.miningdataapi.com/mcp`. Every tool is
  read-only.
- The `mining-data` skill, which teaches Claude the dataset's filters, what a
  result says about your plan, and how to cite records.
- Two commands for Claude Code: `/miningdataapi:company-brief <ticker>` and
  `/miningdataapi:screen-drills <commodity> [days]`.

It contains no hooks, agents, scripts or credentials.

## Sign in

You sign in with your Mining Data API account in the browser, through OAuth.
No API key is needed. In Claude Code, run `/mcp`, choose `miningdataapi` and
sign in; `claude mcp logout miningdataapi` forgets the token.

Every plan can connect, and what a tool returns follows the plan. The free
plan answers from a fixed sample month, April 2026. When something needs a
different plan, the result says so.

## What it sends and keeps

The plugin runs nothing on your machine. Claude sends the server only the tool
requests it composes: search filters, record ids and tickers. Your
conversations, prompts and files are not sent.

The server does not store the requests themselves. It keeps a usage record of
each call: the account, the tool, the time and the rows returned, for limits,
billing and misuse detection. To apply monthly company limits, it notes which
companies your organization opens each month. The
[privacy policy](https://miningdataapi.com/privacy) describes what is kept and
for how long.

## Troubleshooting

- **The tools are missing, or the server answers 401.** In Claude Code, run
  `/mcp`, choose `miningdataapi` and sign in again.
- **`dataset_not_in_plan`.** Your account does not include that dataset.
  Datasets in early access open on request through support@miningdataapi.com.
- **`plan_required`.** The request needs a different plan, and the error names
  it.
- **`budget_exhausted`, `company_cap_reached` or `daily_records_cap`.** A limit
  of your plan is reached. Ask how much of your quota you have used to see what
  is left and when it resets.
- **To revoke access**, use the AI plugins section of the Mining Data API
  portal, or remove the plugin.

## Support

- [Support](https://miningdataapi.com/support): support@miningdataapi.com, for
  help and for security reports. Please do not post exploitable details
  publicly.
- [Privacy policy](https://miningdataapi.com/privacy)
- [Terms of service](https://miningdataapi.com/terms)

## License

MIT for the files in this plugin. The Mining Data API service and its data are
governed by the [terms of service](https://miningdataapi.com/terms).
