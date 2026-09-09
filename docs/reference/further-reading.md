--8<-- "_snippets/disclaimer.md"

# Further reading & sources

A curated, categorized list of official Cloudflare resources for going deeper than this framework does. Every link was checked to confirm it resolves and is the correct canonical page as of writing — if you find one that's gone stale, open an issue or pull request.

## Start here: the developer platform

- [Cloudflare Developer Platform documentation](https://developers.cloudflare.com/) — the root of all product documentation and the source this entire framework is built from
- [Workers overview](https://developers.cloudflare.com/workers/) — the compute primitive nearly everything else in this framework connects to
- [How Workers works](https://developers.cloudflare.com/workers/reference/how-workers-works/) — the V8 isolate model, and why it behaves differently from container-based serverless platforms
- [Choosing a data or storage product](https://developers.cloudflare.com/workers/platform/storage-options/) — Cloudflare's own comparison of D1, Durable Objects, KV, R2, and Hyperdrive, useful for the same storage-selection questions the [Reliability](../pillars/reliability.md) and [Performance Efficiency](../pillars/performance-efficiency.md) pillars raise

## Reference architecture and design guides

- [Cloudflare Reference Architecture](https://developers.cloudflare.com/reference-architecture/) — official diagrams and design guides, organized by solution area
- [Reference Architecture: Find by solution](https://developers.cloudflare.com/reference-architecture/by-solution/) — a solution-indexed way into the same library
- [Reference Architecture: Serverless diagrams](https://developers.cloudflare.com/reference-architecture/diagrams/serverless/) — full-stack applications, serverless global APIs, and serverless ETL pipelines, the closest official counterparts to this framework's [workload pages](../workloads/index.md)
- [Reference Architecture: Multi-vendor architecture](https://developers.cloudflare.com/reference-architecture/architectures/multi-vendor/) — the source for this framework's [Multi-CDN & hybrid front door](../workloads/multi-cdn-hybrid.md) page
- [Reference Architecture: Designing ZTNA access policies](https://developers.cloudflare.com/reference-architecture/design-guides/designing-ztna-access-policies/) — policy design depth beyond this framework's [Zero Trust / SASE](../workloads/zero-trust-sase.md) page

## Product deep-dives referenced throughout this framework

- [Pages overview](https://developers.cloudflare.com/pages/) and [Pages Functions](https://developers.cloudflare.com/pages/functions/)
- [Framework guides](https://developers.cloudflare.com/workers/framework-guides/) — current, fast-moving guidance on running Next.js, React Router, Astro, and other frameworks on Workers
- [D1](https://developers.cloudflare.com/d1/), [Durable Objects](https://developers.cloudflare.com/durable-objects/), [R2](https://developers.cloudflare.com/r2/), [Workers KV](https://developers.cloudflare.com/kv/), [Hyperdrive](https://developers.cloudflare.com/hyperdrive/)
- [Queues](https://developers.cloudflare.com/queues/)
- [Workers AI](https://developers.cloudflare.com/workers-ai/) and [Vectorize](https://developers.cloudflare.com/vectorize/)
- [API Shield](https://developers.cloudflare.com/api-shield/) and [WAF](https://developers.cloudflare.com/waf/)
- [Load Balancing](https://developers.cloudflare.com/load-balancing/)
- [Cloudflare One](https://developers.cloudflare.com/cloudflare-one/) (Access, Gateway, Tunnel, Cloudflare One Client — formerly WARP)

## Learning and background

- [Cloudflare Learning Center](https://www.cloudflare.com/learning/) — vendor-neutral explanations of underlying concepts (anycast, CDNs, origin servers, DDoS, Zero Trust) that this framework assumes some familiarity with
- [Cloudflare Blog](https://blog.cloudflare.com/) — product announcements and technical deep-dives, useful for understanding *why* a product works the way it does, not just how to configure it

## Community

- [Cloudflare Community forum](https://community.cloudflare.com/) — the official forum for asking questions and searching prior discussions with Cloudflare staff and other users
- [Cloudflare Developers Discord](https://discord.com/invite/cloudflaredev) — the official Cloudflare Developers Discord server, focused on Workers and the broader developer platform

## Related frameworks

See [Related Frameworks](related-frameworks.md) for how this repository relates to the companion [Cloudflare Adoption Framework](https://github.com/kevinevans1/cloudflare-adoption-framework) and the independent [Architecting on Cloudflare](https://architectingoncloudflare.com/) resource.
