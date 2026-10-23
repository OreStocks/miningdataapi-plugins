#!/usr/bin/env bash
# Build the ZIP that goes into the OpenAI plugin portal (Upload plugin →
# With MCP). Only the portable layout is packaged: plugin.json, mcp.json,
# skills/ and assets/. The Claude Code files (.claude-plugin/, .mcp.json,
# commands/) stay out so the package is not flagged as desktop-only.
#
# Usage: scripts/build-openai-package.sh            → dist/miningdataapi-<version>.zip
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
plugin="$root/plugins/miningdata"
cd "$plugin"

python3 - <<'PY'
import json, os, sys
m = json.load(open("plugin.json"))
ext = m["extensions"]["com.openai"]
problems = []
iface = ext.get("interface", {})
review = ext.get("review", {})
if not review.get("demo_recording_url", "").startswith("https://"):
    problems.append("extensions.com.openai.review.demo_recording_url is missing; add the reviewer-accessible walkthrough video URL before building")
for key in ("logo", "composerIcon"):
    path = iface.get(key, "")
    if not path.startswith("./") or not os.path.isfile(path):
        problems.append(f"interface.{key} must be a ./-relative path to an existing file (got {path!r})")
pos = review.get("test_cases", {}).get("positive", [])
neg = review.get("test_cases", {}).get("negative", [])
if len(pos) != 5 or len(neg) != 3:
    problems.append(f"review needs exactly 5 positive and 3 negative test cases (have {len(pos)}/{len(neg)})")
if problems:
    print("package not ready:", file=sys.stderr)
    for p in problems:
        print("  - " + p, file=sys.stderr)
    sys.exit(1)
print(m["version"])
PY

version="$(python3 -c 'import json; print(json.load(open("plugin.json"))["version"])')"
out_dir="$root/dist"
out="$out_dir/miningdataapi-$version.zip"
mkdir -p "$out_dir"
rm -f "$out"
zip -r -X "$out" plugin.json mcp.json skills assets -x '*.DS_Store' >/dev/null
echo "built $out"
unzip -l "$out"
