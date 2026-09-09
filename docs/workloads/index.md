--8<-- "_snippets/disclaimer.md"

# Workloads overview

The [pillars](../pillars/index.md) describe *how to think* about reliability, security, cost, operations, and performance on Cloudflare. This section applies that thinking to *specific, recognizable shapes* of workload — the kind of thing you'd actually sketch on a whiteboard before opening the dashboard.

Each workload page follows the same structure:

- **What it is and why Cloudflare** — the problem shape and why the platform's edge-native, serverless-first model fits it (or doesn't)
- **Reference architecture** — a concrete component diagram showing which products connect to which, and how data actually flows
- **Applying the pillars** — workload-specific guidance for the pillars that matter most for this shape, linking back to the full pillar pages for depth
- **When this isn't the right fit** — honest limits and anti-patterns, because not every workload belongs on every platform

## How to use this section

**If you already know your shape**, jump straight to the matching page. Most real systems are a composite of two or three of these — a SaaS product might combine [full-stack Workers](fullstack-workers.md) for the app, an [API layer](apis-and-backends.md) for third-party integrations, and an [event-driven pipeline](event-driven-pipelines.md) for background jobs. Read the pieces that apply and skip the rest.

**If you're starting from a blank page**, treat this as a pattern library. Skim the diagrams first — the shape of the boxes and arrows usually tells you faster than the prose whether an architecture matches what you're building. Then read the "when this isn't the right fit" section on your closest match before committing; it will save you a rewrite later.

**If you're running a design review**, pair the relevant workload page(s) with the workload-agnostic [Design Review Checklist](../design-review-checklist.md), which is organized the same way as the self-assessment questions from all five pillars, turned into one scannable, checkbox-style list for a review meeting.

## The workload shapes covered here

| Page | Core Cloudflare products | Typical use case |
|---|---|---|
| [Static sites & SPAs](static-sites.md) | Pages, Pages Functions | Marketing sites, docs sites, JAMstack front ends |
| [Full-stack apps on Workers](fullstack-workers.md) | Workers, Workers Static Assets, D1, Durable Objects, R2, KV | SaaS products, dashboards, server-rendered apps |
| [APIs & backends](apis-and-backends.md) | Workers, D1/Durable Objects/Hyperdrive, API Shield, Rate Limiting | Public/partner APIs, mobile backends |
| [Event-driven & data pipelines](event-driven-pipelines.md) | Queues, R2, Workers, Durable Objects alarms, Workers AI | Async processing, ETL, ingestion pipelines |
| [Zero Trust / SASE](zero-trust-sase.md) | Access, Gateway, Tunnel, Cloudflare One Client (formerly WARP) | Internal app access, corporate internet security |
| [Multi-CDN & hybrid front door](multi-cdn-hybrid.md) | DNS, Load Balancing, Tunnel, CNI | Enterprises running Cloudflare alongside another vendor |
| [Startup workload](startup-workload.md) | Workers, KV, D1 | Early-stage products optimizing for speed and low fixed cost |
| [AI & RAG workload](ai-rag-workload.md) | AI Gateway, Workers AI, Vectorize, AI Search, Agents SDK | Chatbots, retrieval-augmented search, AI agents |

None of these are mutually exclusive, or the *only* correct way to build the thing they describe — they're a starting point for a design conversation, not a template to copy verbatim.

## Further reading

- [Cloudflare Reference Architecture](https://developers.cloudflare.com/reference-architecture/) — the official diagram and design-guide library this section draws on and complements
- [Cloudflare Reference Architecture: Serverless diagrams](https://developers.cloudflare.com/reference-architecture/diagrams/serverless/)
- [Cloudflare Developer Platform documentation](https://developers.cloudflare.com/)
