# Cloudflare Well-Architected

An independent, community-maintained set of pillars and design guidance for
building reliable, secure, cost-efficient, and performant workloads on
Cloudflare's developer platform — modeled on the structure of the AWS and
Azure Well-Architected Frameworks, adapted to Cloudflare's edge-native,
serverless-first primitives (Workers, Pages, R2, D1, Durable Objects,
Queues, Zero Trust).

**Read it here:** https://kevinevans1.github.io/cloudflare-well-architected/

> [!IMPORTANT]
> This is an independent project, not affiliated with or endorsed by
> Cloudflare, Inc. See [`NOTICE.md`](NOTICE.md) for the full disclaimer.

## What this is

Five pillars, each with concrete Cloudflare-specific design guidance and a
self-assessment checklist:

1. **Reliability** — resilience, failover, and consistency at the edge
2. **Security** — defense in depth across network, application, and Zero
   Trust layers
3. **Cost Optimization** — pricing models, egress economics, and avoiding
   over-provisioning on a platform that bills very differently from a VM-based cloud
4. **Operational Excellence** — IaC, CI/CD, observability, and safe rollout
   practices
5. **Performance Efficiency** — routing, caching, placement, and data
   locality on a global anycast network

Applied to concrete workload shapes (static sites, full-stack Workers apps,
APIs, event-driven pipelines, Zero Trust/SASE, multi-CDN front doors) with a
consolidated [design review checklist](docs/design-review-checklist.md).

See also its companion project, [**Cloudflare Adoption Framework**](https://github.com/kevinevans1/cloudflare-adoption-framework),
which covers the org-wide adoption lifecycle this framework's pillars plug
into — the same relationship the Azure Well-Architected Framework has to CAF.

## Running the site locally

```bash
pip install -r requirements.txt
mkdocs serve
```

## Contributing

Corrections and additions are welcome. Every factual claim (a limit, a
price, a specific capability) must link to the current, canonical page on
`developers.cloudflare.com` or `cloudflare.com` — see [`NOTICE.md`](NOTICE.md)
for why.
