--8<-- "_snippets/disclaimer.md"

# Related frameworks and resources

This framework doesn't exist in isolation. Here's how it relates to the other resources you're likely to encounter while designing on Cloudflare.

## The Cloudflare Adoption Framework (companion repository)

[Cloudflare Adoption Framework](https://github.com/kevinevans1/cloudflare-adoption-framework) is a separate, companion project covering the **org-wide adoption lifecycle**: how an organization plans, migrates to, and operates on Cloudflare over time. It covers Zero Trust rollout sequencing, phased DNS migration, building internal platform teams, governance and landing-zone patterns, and the organizational change management that a purely technical framework doesn't cover.

The relationship between the two repositories is deliberate, mirroring a pattern common across cloud adoption guidance generally:

- An **adoption framework** operates at the org level — how do we roll this out, in what order, with what governance.
- A **well-architected framework** operates at the workload level — given a system we're building right now, how do we make it reliable, secure, cost-efficient, well-operated, and performant.

You'll typically use the Adoption Framework once, or periodically, when planning a rollout phase or a new team's onboarding — and this framework repeatedly, every time a new workload gets designed or reviewed.

Concretely: the [Zero Trust / SASE workload page](../workloads/zero-trust-sase.md) in this repository covers the *steady-state architecture* of an Access/Gateway/Tunnel/WARP deployment, and explicitly defers rollout sequencing to the Adoption Framework's Zero Trust adoption path. That's the pattern to expect elsewhere too: this repository answers "is this design sound," the Adoption Framework answers "how do we get there as an organization."

## Cloudflare's official Reference Architecture library

[developers.cloudflare.com/reference-architecture](https://developers.cloudflare.com/reference-architecture/) is Cloudflare's own, authoritative collection of reference diagrams and design guides — serverless patterns, Zero Trust/SASE architectures, AI pipelines, multi-vendor setups, and more. This framework is written to **complement, not duplicate or override** that library: where the two disagree, trust Cloudflare's. Several workload pages — notably [Multi-CDN & hybrid front door](../workloads/multi-cdn-hybrid.md), which follows Cloudflare's [multi-vendor architecture guidance](https://developers.cloudflare.com/reference-architecture/architectures/multi-vendor/) directly — point back to specific pages in that library rather than restating their content independently.

The practical difference in scope: Cloudflare's library is organized by solution and diagram, and grows as Cloudflare publishes new patterns. This framework is organized by pillar and workload shape — a lighter-weight, review-oriented companion: a place to start a design conversation and a checklist to run before shipping, with links out to the official material for full depth.

## Architecting on Cloudflare (independent third-party resource)

[architectingoncloudflare.com](https://architectingoncloudflare.com/) is a separate, independent resource — a long-form guide covering the Cloudflare developer platform, strategic assessment, architectural patterns, multi-tenant platform design, and an honest discussion of when *not* to use Cloudflare. Like this framework, it is explicitly **not produced by, affiliated with, or endorsed by Cloudflare, Inc.** — it reflects its author's independent analysis based on publicly available documentation and hands-on experience with the platform, written by someone who has disclosed working for a Cloudflare partner organization.

This framework and Architecting on Cloudflare are complementary rather than competing: this repository is narrower and more structured (five pillars, applied to specific workload shapes, with a design-review checklist), while Architecting on Cloudflare goes deeper into strategic and organizational topics in long-form chapters, including its own treatment of where the platform's limits are. If you're evaluating Cloudflare at a strategic level, it's worth reading directly rather than through a summary here.

## A note on framing

Well-architected, pillar-based guidance — organizing design review around a small set of named quality attributes like reliability, security, cost, operations, and performance — is a pattern used across the cloud industry in various forms. This framework adopts that general pattern because it's a genuinely useful way to structure a design conversation, not because it's tied to any single vendor's specific program. If you're coming from a background using a similarly structured framework elsewhere, the pillar names and self-assessment format here should feel familiar — the content itself is specific to Cloudflare's actual products and how they compose.

## Further reading

- [Cloudflare Adoption Framework](https://github.com/kevinevans1/cloudflare-adoption-framework)
- [Cloudflare Reference Architecture](https://developers.cloudflare.com/reference-architecture/)
- [Cloudflare Reference Architecture: Multi-vendor architecture](https://developers.cloudflare.com/reference-architecture/architectures/multi-vendor/)
- [Architecting on Cloudflare](https://architectingoncloudflare.com/)
