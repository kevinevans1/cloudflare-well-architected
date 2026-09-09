--8<-- "_snippets/disclaimer.md"

# How to Use This Framework

This framework operates at the **workload level**: one service, one team, one architecture decision. It's not a maturity model for your whole organization, and it's not a substitute for the Cloudflare docs for the product you're using — it's a set of lenses to make sure you've asked the right questions before (or after) you ship.

There are two ways to use it.

## 1. As a design-time framework

Designing a new workload — a new API on Workers, a migration onto Pages and D1, a Zero Trust replacement for a VPN? Work through the five pillars *before* you commit to an architecture:

1. Read [Reliability](pillars/reliability.md), [Security](pillars/security.md), [Cost Optimization](pillars/cost-optimization.md), [Operational Excellence](pillars/operational-excellence.md), and [Performance Efficiency](pillars/performance-efficiency.md) in whatever order matches your risk profile — a public-facing API might start with Security, a latency-sensitive service with Performance Efficiency.
2. For each pillar, use **Design principles** to shape the architecture and **Common pitfalls** as a pre-mortem. Most pitfalls are patterns that are *easy* to fall into on Cloudflare specifically, because the platform makes the wrong option as easy to reach for as the right one — KV's low ceremony makes it tempting for data that actually needs strong consistency, for example.
3. Where pillars conflict — and they will; see [Pillars Overview](pillars/index.md#trade-offs-between-pillars) — make the trade-off explicit and write it down. A design review should see *why* you chose a single-region D1 database over a globally replicated one, not just that you did.

## 2. As a review checklist for an existing workload

Running a design review, an audit, or a pre-production gate on an existing workload? Use the [Design Review Checklist](design-review-checklist.md) — a workload-agnostic checklist, organized the same way as the **Self-assessment questions** on each pillar page, that turns them into one pass-through, checkbox-style document for a review meeting. It complements rather than replaces those questions; go back to the relevant pillar page when an answer needs more depth. Answer it honestly and specifically: "yes, we use Load Balancing with health checks against two origins in different providers" is useful; "yes" alone is not.

Run the checklist:

- Before a workload goes to production for the first time.
- After a material architecture change (new data store, new region, new traffic pattern).
- On a recurring cadence for workloads that handle production traffic or sensitive data — many teams fold this into a quarterly review.

## How this relates to the Adoption Framework

This project's companion, the [Cloudflare Adoption Framework](https://github.com/kevinevans1/cloudflare-adoption-framework), operates one level up: the org-wide adoption lifecycle (Strategy, Plan, Foundation, Adopt, Govern, Secure, Manage) — account structure, landing zone, cross-team guardrails, governance. The relationship is directional but not strictly sequential:

- The Adoption Framework's **Foundation** and **Govern** phases typically set the guardrails a workload operates inside — approved products, mandatory Zero Trust posture, org-sanctioned Terraform modules. Read those before making workload-level decisions that assume freedoms your organization hasn't granted.
- This framework's pillars then apply *within* those guardrails, one workload at a time.
- Feedback runs the other way too: hitting the same pillar trade-off across every workload — every team improvising its own WAF baseline, say — signals the organization needs a Govern-phase standard, not five more one-off decisions.

In short: use the Adoption Framework to get the organization ready for Cloudflare; use this framework to get one workload right on top of it.

## Further reading

- [Design Review Checklist](design-review-checklist.md)
- [Pillars Overview](pillars/index.md)
- [Cloudflare Adoption Framework](https://github.com/kevinevans1/cloudflare-adoption-framework)
- [Cloudflare Reference Architecture library](https://developers.cloudflare.com/reference-architecture/)
