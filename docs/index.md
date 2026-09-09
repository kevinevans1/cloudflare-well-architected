--8<-- "_snippets/disclaimer.md"

# Cloudflare Well-Architected

Welcome — this is a practical, community-maintained guide to designing and reviewing workloads on Cloudflare, written for anyone from a solo developer shipping a first Worker to a team running a formal architecture review. New to some of the terminology? The [Glossary](reference/glossary.md) has you covered.

**Cloudflare Well-Architected** is an independent set of design pillars and review guidance for engineers and architects building a workload on Cloudflare's edge-native, serverless-first platform — Workers, Pages, R2, D1, Durable Objects, Queues — plus the network, security, and Zero Trust products around it.

It follows a pillar-based structure — Reliability, Security, Cost Optimization, Operational Excellence, Performance Efficiency — because a fixed set of lenses applied consistently beats an ad hoc design review. Cloudflare isn't a VM-hour cloud:

- Compute runs as V8 isolates, not containers or VMs.
- Storage is a family of purpose-built primitives with different consistency models (KV, D1, Durable Objects, R2), not a general-purpose block/object/relational split.
- The network *is* the deployment target, not a set of regions you pick from.

The pillars here are written against that reality.

## Who this is for

This framework is for the person who owns a **specific workload decision**: the engineer designing a new API on Workers, the architect choosing between Durable Objects and D1 for session state, the team running a pre-production design review. It works two ways:

- **During design**, as a set of questions and trade-offs to work through pillar by pillar before you commit to an architecture.
- **As a review**, using the companion [Design Review Checklist](design-review-checklist.md) against a workload that already exists.

See [How to Use This Framework](how-to-use.md) for the detailed workflow.

## How this differs from Cloudflare's own architecture resources

Cloudflare publishes two adjacent resources:

| Resource | What it is | How it differs from this framework |
|---|---|---|
| Cloudflare's official [Reference Architecture library](https://developers.cloudflare.com/reference-architecture/) | First-party documentation: **Reference Architectures** (end-to-end designs), **Reference Architecture Diagrams** (visual patterns), **Design Guides** (strategic decisions), **Implementation Guides** (step-by-step builds), plus a "Find by solution" index | Authoritative, but not a cross-cutting *evaluation framework* — a fixed set of lenses applied regardless of which reference architecture your workload resembles. Use a matching reference architecture for the design; use this framework's pillars to pressure-test it afterward. |
| [architectingoncloudflare.com](https://architectingoncloudflare.com/) | Third-party, explicitly unaffiliated with Cloudflare — a deep single-author take on the **developer platform**: Workers, Durable Objects, D1, R2, Queues, Workflows, Containers, Realtime, Workers AI/Vectorize/Agents | Excludes security and networking (WAF, DDoS, Zero Trust, Magic Transit). This framework is broader but shallower per topic, since a real workload's risk and cost posture depends on both the developer platform and the network/security/Zero Trust surface. |

In short: reference architectures tell you *what to build*; this framework gives you *the lenses to check what you built*.

## The five pillars

| Pillar | What it covers on Cloudflare |
|---|---|
| [Reliability](pillars/reliability.md) | Failover, redundancy, and consistency when your origin and state don't automatically inherit the edge network's redundancy |
| [Security](pillars/security.md) | Defense in depth: network-layer DDoS, WAF/bot/rate-limiting, application-layer validation, Zero Trust, and data protection |
| [Cost Optimization](pillars/cost-optimization.md) | Usage-based CPU-time and request pricing that behaves nothing like VM-hour billing — and how to over- or under-spend on it |
| [Operational Excellence](pillars/operational-excellence.md) | Infrastructure as code, CI/CD, observability, and safe rollout for Workers and network configuration |
| [Performance Efficiency](pillars/performance-efficiency.md) | Using the anycast network, Smart Placement, caching, and data-locality trade-offs deliberately, not by default |

Start at [Pillars Overview](pillars/index.md) for a visual summary and the trade-offs between pillars, or jump into whichever pillar matches your decision.

## The org-level companion

This framework operates at the **workload level** — one service, one team, one design decision. Responsible for how an entire organization adopts Cloudflare — landing zone, account structure, governance, cross-team standards? That's a different scope, covered by the companion project:

**[Cloudflare Adoption Framework](https://github.com/kevinevans1/cloudflare-adoption-framework)** covers the org-wide adoption lifecycle (Strategy → Plan → Foundation → Adopt → Govern → Secure → Manage). It gets the organization ready and governed; this project gets one workload built well inside that environment.

## Further reading

- [Cloudflare Reference Architecture library](https://developers.cloudflare.com/reference-architecture/)
- [architectingoncloudflare.com](https://architectingoncloudflare.com/)
- [Cloudflare Adoption Framework](https://github.com/kevinevans1/cloudflare-adoption-framework)
