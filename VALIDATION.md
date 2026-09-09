# Validation Checklist

Run before publishing any new or edited content: `./scripts/validate.sh`

This exists because every rule below was learned the hard way during this project's
first writing pass — each one caught a real, shipped defect. Treat this as the
minimum bar for a new page or a substantial edit, not a nice-to-have.

## What the script checks automatically

1. **`mkdocs build --strict`** — catches broken nav entries, malformed YAML, bad
   internal links.
2. **Every external URL resolves** — a citation next to a claim is only as good as
   the link behind it. Note: some Cloudflare marketing/community pages (e.g.
   `community.cloudflare.com`, `cloudflare.com/learning/...`) return 403 to automated
   fetchers even though they're real and fine — verify manually, don't "fix" these.
   A self-referential link to this repo's own GitHub file will 404 until it's been
   pushed at least once.
3. **Every Mermaid diagram renders without a syntax error.**
4. **No hardcoded Mermaid node colors** (`style X fill:#hex`). This one bit us for
   real: custom fill colors don't get an auto-adjusted text color the way Material's
   own theme-aware Mermaid rendering does, so a diagram styled this way looks fine in
   one light/dark mode and is unreadable in the other. It happened twice — once
   across the whole original diagram set, and again in a later batch of new pages
   that reused the same pattern out of habit. **When adding a new diagram, don't
   copy a `style` line from an old one — there shouldn't be any left to copy.**
5. **No vendor-attribution violations.** This framework's *shape* (phase-based
   lifecycle / pillar-based structure) follows a pattern common across the cloud
   industry, but must never say it's modeled on a specific named competitor's
   framework (AWS, Azure, GCP) — see `NOTICE.md`. Mentioning those platforms as
   hyperscaler comparisons (positioning, cost, workload fit) is fine; attributing
   *this framework's own structure* to their framework by name is not.
6. **No salesy/marketing language** (game-changing, seamless, cutting-edge,
   world-class, etc.). This should read like a solutions architect explaining
   trade-offs to a peer, not product marketing.
7. **No language that disadvantages Cloudflare.** This is written by a Cloudflare
   employee — every "Cloudflare doesn't X" or "gap" statement should be checked that
   it's a neutral technical fact (or, more often, a gap in the *reader's own*
   process), not something that reads as criticizing Cloudflare.
8. **No placeholder artifacts** (TODO, FIXME, Lorem ipsum, "coming soon").
9. **No unbalanced code fences** — a missing closing ` ``` ` silently eats the rest
   of a page's rendering.
10. **No orphaned pages** — every file under `docs/` should be reachable from
    `mkdocs.yml`'s `nav`. This caught two real orphaned pages during this project
    (pages that were written and fact-checked but never linked from an overview
    index) — write the page **and** wire it into both the nav and the relevant
    overview/index page's table in the same change.

## What the script can't check — do these manually

- **Fact-check every specific claim against a live fetch of the actual Cloudflare
  doc it cites**, not just that the link resolves. A working link next to a wrong
  claim is worse than an obviously broken one. Prefer linking to a page over
  hardcoding a number that will go stale (a price, a quota, a limit).
- **Cross-file consistency for renamed products.** Cloudflare renames things
  (Magic WAN → Cloudflare WAN, WARP → Cloudflare One Client, Page Shield →
  Client-Side Security, CASB → Cloud & SaaS findings, AutoRAG → AI Search). When one
  of these lands, grep the *whole* repo for the old name, not just the page you're
  editing — stale names in unrelated pages are exactly the class of bug that
  survives a single-page review.
- **Read the actual rendered diagram**, not just confirm it parses. A diagram that
  renders without a syntax error can still be structurally wrong or fail to
  illustrate the point next to it.
- **Read new pages for tone** against the four checks above — the script's grep
  patterns are a floor, not a substitute for actually reading it.

## When adding a new batch of content (a scenario, a workload, a whole new section)

1. Write the pages.
2. Add them to `mkdocs.yml`'s `nav` **and** to the relevant overview/index page's
   table in the same change — don't defer this.
3. Run `./scripts/validate.sh`.
4. Fix everything under FAIL. Manually review everything under REVIEW/CHECK.
5. Do a second pass specifically re-reading the new pages for tone (salesy /
   Cloudflare-disadvantaging language) and fact-accuracy — the automated checks are
   pattern-matching, not comprehension.
6. Only then commit and push.
