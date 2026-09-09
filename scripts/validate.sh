#!/usr/bin/env bash
# Validation checks for this documentation site, run before every publish.
# See ../VALIDATION.md for the full checklist and the reasoning behind each rule.
#
# Prerequisites (skips gracefully if missing, but install both for a real check):
#   pip install -r requirements.txt
#   npm install -g @mermaid-js/mermaid-cli
#
# Usage: ./scripts/validate.sh

set -uo pipefail
cd "$(dirname "$0")/.."

DOCS_DIR="docs"
FAIL=0

section() { echo; echo "=== $1 ==="; }

# 1. MkDocs strict build — catches broken nav entries, malformed YAML, bad internal links.
section "MkDocs strict build"
if command -v mkdocs >/dev/null 2>&1; then
  mkdocs build --strict
  [ $? -ne 0 ] && { echo "FAIL: mkdocs build --strict failed"; FAIL=1; }
else
  echo "SKIP: mkdocs not installed (pip install -r requirements.txt)"
fi

# 2. External link check — every cited URL should resolve.
section "External link check"
urls_file=$(mktemp)
grep -rhoE '\(https?://[^)]+\)' "$DOCS_DIR" --include='*.md' | sed -E 's/^\((.*)\)$/\1/' | sort -u > "$urls_file"
nonok=0
while read -r url; do
  code=$(curl -s -o /dev/null -w "%{http_code}" -L --max-time 15 -A "Mozilla/5.0 (compatible; DocLinkChecker/1.0)" "$url" 2>/dev/null)
  if [ "$code" != "200" ]; then
    echo "CHECK: $code $url"
    nonok=1
  fi
done < "$urls_file"
rm -f "$urls_file"
if [ "$nonok" -eq 1 ]; then
  echo "(A non-200 isn't automatically a failure: some Cloudflare marketing/community pages"
  echo " 403 automated fetchers even though they're real, and a self-referential link to this"
  echo " repo's own GitHub file 404s until it's been pushed. Verify manually before 'fixing'.)"
else
  echo "OK: all links resolve"
fi

# 3. Mermaid diagrams render without syntax errors.
section "Mermaid diagram syntax"
if command -v mmdc >/dev/null 2>&1; then
  tmpdir=$(mktemp -d)
  python3 - "$DOCS_DIR" "$tmpdir" <<'PYEOF'
import re, sys, os, glob
docs_dir, out_dir = sys.argv[1], sys.argv[2]
count = 0
for path in glob.glob(docs_dir + "/**/*.md", recursive=True):
    with open(path) as f:
        content = f.read()
    for i, block in enumerate(re.findall(r"```mermaid\n(.*?)```", content, re.DOTALL)):
        count += 1
        name = path.replace("/", "__") + f".{i}.mmd"
        with open(os.path.join(out_dir, name), "w") as out:
            out.write(block)
print(f"Extracted {count} diagrams")
PYEOF
  fail_diagrams=0
  shopt -s nullglob
  for f in "$tmpdir"/*.mmd; do
    if ! mmdc -i "$f" -o "${f%.mmd}.svg" --quiet 2>/tmp/mmdc_err.txt; then
      echo "FAIL: $(basename "$f")"; cat /tmp/mmdc_err.txt; fail_diagrams=1; FAIL=1
    fi
  done
  shopt -u nullglob
  [ "$fail_diagrams" -eq 0 ] && echo "OK: all diagrams render"
  rm -rf "$tmpdir"
else
  echo "SKIP: mmdc not installed (npm install -g @mermaid-js/mermaid-cli)"
fi

# 4. No hardcoded Mermaid node colors. Custom `style X fill:#hex` lines don't get an
#    auto-adjusted text color, so they read fine in one theme mode and are unreadable
#    in the other (this broke every diagram in this repo once already — see VALIDATION.md).
section "Hardcoded Mermaid colors"
hits=$(grep -rn "^[[:space:]]*style [A-Za-z0-9_]* fill:" "$DOCS_DIR" --include='*.md' || true)
if [ -n "$hits" ]; then
  echo "FAIL: hardcoded style/fill lines found — remove them and let Material's"
  echo "      theme-aware Mermaid rendering handle node colors instead:"
  echo "$hits"
  FAIL=1
else
  echo "OK"
fi

# 5. Vendor-naming / attribution check. This framework's structure is modeled on a
#    genre of adoption/well-architected frameworks, but must never attribute that
#    structure to a specific named competitor (AWS/Azure/GCP) by name.
section "Vendor attribution check"
hits=$(grep -rniE "azure|aws cloud adoption|aws well-architected|google cloud('s)? (adoption|architecture)" "$DOCS_DIR" --include='*.md' || true)
if [ -n "$hits" ]; then
  echo "REVIEW: AWS/Azure/GCP mentioned — fine if it's a hyperscaler-comparison point"
  echo "        (positioning, workload fit, cost), NOT fine if it attributes this"
  echo "        framework's own structure/inspiration to their named framework:"
  echo "$hits"
else
  echo "OK"
fi

# 6. Salesy / marketing language check.
section "Salesy language check"
hits=$(grep -rniE "game-changing|revolutionar|seamless|effortless|unparalleled|cutting-edge|industry-leading|world-class|blazing|unmatched|unrivaled|next-generation|state-of-the-art" "$DOCS_DIR" --include='*.md' | grep -viE "magic transit|magic wan|magic firewall" || true)
if [ -n "$hits" ]; then
  echo "REVIEW: possible marketing language — this should read like a solutions"
  echo "        architect explaining trade-offs, not ad copy:"
  echo "$hits"
else
  echo "OK"
fi

# 7. Cloudflare-disadvantaging language check.
section "Cloudflare-disadvantage language check"
hits=$(grep -rniE "cloudflare (fails|lacks|falls short|is behind|is inferior|doesn't|does not|hasn't|has not)" "$DOCS_DIR" --include='*.md' || true)
if [ -n "$hits" ]; then
  echo "REVIEW: confirm each of these reads as a neutral technical fact, not criticism"
  echo "        of Cloudflare (this repo is written by a Cloudflare employee):"
  echo "$hits"
else
  echo "OK"
fi

# 8. Placeholder / leftover artifacts.
section "Placeholder artifacts"
hits=$(grep -rniE "TODO|FIXME|lorem ipsum|XXX|placeholder|\[insert|TBD\b|coming soon" "$DOCS_DIR" --include='*.md' || true)
if [ -n "$hits" ]; then
  echo "FAIL: placeholder text found:"
  echo "$hits"
  FAIL=1
else
  echo "OK"
fi

# 9. Unbalanced code fences (a missing closing ``` silently eats the rest of the page).
section "Code fence balance"
fence_fail=0
while IFS= read -r f; do
  n=$(grep -c '^```' "$f")
  if [ $((n % 2)) -ne 0 ]; then
    echo "FAIL: odd fence count in $f ($n)"
    fence_fail=1
    FAIL=1
  fi
done < <(find "$DOCS_DIR" -name '*.md')
[ "$fence_fail" -eq 0 ] && echo "OK"

# 10. New/orphaned pages — every .md file under docs/ should be reachable from mkdocs.yml's nav.
section "Orphaned pages check"
if command -v python3 >/dev/null 2>&1; then
  python3 - "$DOCS_DIR" <<'PYEOF'
import re, sys, glob, yaml
docs_dir = sys.argv[1] if len(sys.argv) > 1 else "docs"
with open("mkdocs.yml") as f:
    text = f.read()
nav_paths = set(re.findall(r":\s*([\w\-/]+\.md)\s*$", text, re.MULTILINE))
all_files = {p.replace(docs_dir + "/", "") for p in glob.glob(docs_dir + "/**/*.md", recursive=True)}
all_files = {p for p in all_files if not p.startswith("_snippets/")}
orphans = all_files - nav_paths
if orphans:
    print("REVIEW: pages that exist but aren't in mkdocs.yml's nav (unreachable from the site):")
    for o in sorted(orphans):
        print(f"  - {o}")
else:
    print("OK: every page is reachable from nav")
PYEOF
else
  echo "SKIP: python3 not available"
fi

echo
if [ "$FAIL" -eq 0 ]; then
  echo "=== VALIDATION PASSED (review any REVIEW/CHECK lines above manually) ==="
else
  echo "=== VALIDATION FAILED — see FAIL lines above ==="
  exit 1
fi
