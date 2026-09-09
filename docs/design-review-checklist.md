--8<-- "_snippets/disclaimer.md"

# Design review checklist

A consolidated, workload-agnostic checklist for running a design review before a workload ships to production on Cloudflare. It's organized by the same five pillars as the rest of this framework, and complements — not replaces — the "Self-assessment questions" at the end of each [pillar page](pillars/index.md), which go deeper on the reasoning behind each question. Scroll through this page in the review meeting; use the pillar pages when an answer needs more explanation.

This checklist is inspired by the interactive self-assessment tools several major cloud providers publish alongside their own well-architected guidance. Unlike those, this is a **static, self-service checklist** — no scoring engine or dashboard, just questions worth asking out loud before you ship.

How to use it: go pillar by pillar. For each unchecked box, either fix the gap, explicitly accept the risk (and write down why), or mark it not applicable. Not every item applies to every workload shape — see the relevant [workload page](workloads/index.md) for which pillars matter most for what you're building.

## Reliability

- [ ] Have you identified every single point of failure — a single Durable Object, Tunnel connector, or regional database — and decided if that's acceptable?
- [ ] Does the workload define behavior for when a downstream dependency (external API, Hyperdrive-fronted database, identity provider) is unavailable?
- [ ] Are retries idempotent-safe, and do they use backoff rather than tight retry loops that could amplify an outage?
- [ ] If the workload uses Queues, is a dead-letter queue configured and actively monitored, not just present?
- [ ] If the workload uses Durable Objects, have you confirmed which entities need strong consistency and would break under eventual consistency?
- [ ] Have you tested what happens on a partial regional outage, not just a full one?
- [ ] Is there a rollback path for the most recent deployment that doesn't depend on the thing that just broke?
- [ ] Are health checks (Load Balancing, Tunnel) configured to detect real application failure, not just "the process is running"?
- [ ] Have you load-tested (or at least estimated) behavior at your actual expected peak, not just average traffic?
- [ ] Is there a documented, tested disaster-recovery or data-restore procedure for anything storing durable state (D1, R2, Durable Object storage)?
- [ ] Does anyone other than the original author understand how to recover this system at 3am?

## Security

- [ ] Is every request input validated at the edge or in the Worker before it reaches business logic or a data store?
- [ ] Are secrets stored as Wrangler/platform secrets rather than in environment variables checked into source control?
- [ ] Is authentication enforced on every route that needs it, including ones added after the initial design review?
- [ ] If the workload exposes an API, is there schema validation in front of it, not just application-level checks?
- [ ] Are JWTs and tokens validated against a live signing-key endpoint, not a hardcoded key that can go stale after rotation?
- [ ] Is rate limiting applied at a layer that stops abuse before it costs you compute (WAF/edge), not only inside application code?
- [ ] Does every `target="_blank"` link in any user-facing surface include `rel="noopener noreferrer"`?
- [ ] Have you reviewed WAF managed and custom rules for this workload, rather than inheriting a zone-wide default that may not fit it?
- [ ] If the workload touches Zero Trust-protected resources, are Access policies deny-by-default with explicit allow rules, not the reverse?
- [ ] Is there a clear owner for rotating credentials, API tokens, and service bindings tied to this workload?
- [ ] Have you checked for and removed any debug endpoints, verbose error responses, or admin routes that shouldn't reach production?

## Cost Optimization

- [ ] Do you know which component of this architecture will be the largest cost driver at 10x current traffic, before it happens?
- [ ] Is any data stored in a product (KV, R2, D1, Durable Objects) that doesn't match its consistency and access-pattern needs, driving unnecessary cost?
- [ ] If the workload uses Durable Objects with WebSockets, is Hibernation enabled so idle connections aren't billed as active compute?
- [ ] Are you caching everything that's safely cacheable, rather than re-computing or re-fetching on every request?
- [ ] Is retry/backoff logic bounded, so a downstream failure can't cause runaway invocation costs?
- [ ] Have you checked the current, canonical pricing and limits page for every product in this architecture, rather than relying on a remembered number?
- [ ] Is there a budget alert or usage dashboard for this workload, so a cost regression is caught by monitoring rather than by the invoice?
- [ ] Have you removed or downgraded any preview/staging resources that don't need production-tier configuration?
- [ ] If the workload spans multiple environments (dev/staging/prod), are non-production environments actually cheaper to run, not identical copies of production?
- [ ] Does the design avoid paying for a managed service where a static or cached alternative would fully satisfy the requirement?

## Operational Excellence

- [ ] Is the entire configuration (Workers, bindings, DNS, Access/Gateway policies) defined as code and stored in version control, not clicked together in a dashboard?
- [ ] Does every production deployment go through a preview/staging step first, with a real URL someone can check before it ships?
- [ ] Is there a rollback procedure that's been exercised at least once, not just documented?
- [ ] Are logs and metrics for this workload actually being looked at, not just collected?
- [ ] Is there an alert for the failure modes you identified in the Reliability section, not just for total outage?
- [ ] Does the on-call or support rotation for this workload have access to the dashboards, logs, and runbooks they'd need during an incident?
- [ ] Are schema/contract changes (API shape, message format, database schema) versioned so they don't break a producer or consumer still on the older version?
- [ ] Is there a documented owner for this workload who isn't "whoever built it originally"?
- [ ] Have dependency and framework-adapter versions been reviewed for known issues, particularly in fast-moving areas like framework support on Workers?
- [ ] Is there a change log or release process so "what changed and when" is answerable without archaeology?

## Performance Efficiency

- [ ] Have you identified which parts of this workload are latency-sensitive, and designed caching/placement accordingly rather than uniformly?
- [ ] If a Worker's real bottleneck is a round trip to a specific backend region, has Smart Placement been evaluated for it?
- [ ] Is static content actually being served as static content, not re-generated by compute on every request?
- [ ] For Durable Objects, have you accounted for the latency of routing every request to a single object's location, for far-away users?
- [ ] Is the Cache API (or Cloudflare's edge cache) used deliberately — correct cache keys and TTLs — rather than left at defaults?
- [ ] Have you tested real-world performance from the regions your actual users are in, not just from your own location?
- [ ] If the workload uses Hyperdrive or another connection-pooled path to a regional database, is the pool sized against the database's real connection ceiling?
- [ ] Are payload sizes (API responses, images, bundles) reviewed for anything unnecessarily large for its purpose?
- [ ] Is there a performance budget or target (e.g. time-to-first-byte, API p95 latency) that this design was actually measured against?

## Further reading

- [Pillars overview](pillars/index.md)
- [Workloads overview](workloads/index.md)
