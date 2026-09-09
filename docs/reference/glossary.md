--8<-- "_snippets/disclaimer.md"

# Glossary

Terms as used specifically within this framework, each checked against Cloudflare's own documentation. Where a term is a general industry concept, the link points to Cloudflare's own explanation of it in context rather than a generic dictionary definition.

**Alarm (Durable Objects)**
: A scheduled wake-up for a single Durable Object, set with `setAlarm()` and delivered to its `alarm()` handler at (or after) the requested time. Alarms have at-least-once execution and retry automatically with exponential backoff if the handler throws. See [Durable Objects: Alarms API](https://developers.cloudflare.com/durable-objects/api/alarms/).

**Anycast**
: A network routing technique where the same IP address is announced from many locations, and network routers deliver each request to the topologically nearest one. It's the mechanism behind Cloudflare's network sending a request to the closest available data center. See [What is Anycast?](https://www.cloudflare.com/learning/cdn/glossary/anycast-network/).

**Binding**
: The mechanism by which a Worker gets access to a resource — a KV namespace, an R2 bucket, a D1 database, another Worker, a secret — configured declaratively rather than connected to over the network at runtime. See [Workers: Bindings](https://developers.cloudflare.com/workers/runtime-apis/bindings/).

**Blast radius**
: The scope of what's affected when a single component fails or is compromised — a Durable Object failure, a leaked credential, an over-broad Access policy. See [Reliability](../pillars/reliability.md) and [Security](../pillars/security.md) for how this framework applies the concept.

**Cache API**
: A Workers runtime API (`caches.default` / `caches.open()`) for programmatically reading from and writing to Cloudflare's cache from inside a Worker, distinct from Cloudflare's automatic edge caching of static content. See [Cache · Cloudflare Workers docs](https://developers.cloudflare.com/workers/runtime-apis/cache/).

**Cold start**
: The latency penalty a compute platform pays to initialize a new execution environment before handling a request. Workers largely avoid it by running in lightweight V8 isolates rather than spinning up a new container or VM per invocation. See [Eliminating cold starts with Cloudflare Workers](https://blog.cloudflare.com/eliminating-cold-starts-with-cloudflare-workers/).

**Custom Domain (Workers)**
: A Workers routing mode that points every path under a domain or subdomain directly to a Worker, with Cloudflare managing the DNS record and certificate. Used when the Worker *is* the application's origin, as opposed to a Route. See [Custom Domains](https://developers.cloudflare.com/workers/configuration/routing/custom-domains/).

**D1**
: Cloudflare's managed serverless database, built on SQLite's query engine, accessed from Workers via a binding and offering point-in-time recovery through Time Travel. See [D1 overview](https://developers.cloudflare.com/d1/).

**Dead-letter queue (DLQ)**
: A secondary queue that receives messages from a Cloudflare Queue after they've exhausted their configured `max_retries` on the original consumer, so they can be inspected or reprocessed instead of silently discarded. See [Dead Letter Queues](https://developers.cloudflare.com/queues/configuration/dead-letter-queues/).

**Durable Object**
: A class of Worker providing a single, addressable instance with its own persistent storage and in-memory state, guaranteeing all requests to it are handled serially by that one instance. Used for state that needs strong consistency or coordination — sessions, counters, collaborative documents. See [What are Durable Objects?](https://developers.cloudflare.com/durable-objects/concepts/what-are-durable-objects/).

**Edge**
: In this framework, "the edge" refers to Cloudflare's globally distributed network of data centers where requests are received, cached, filtered, and (via Workers) executed — as opposed to a single, centralized origin server. See [What is a CDN edge server?](https://www.cloudflare.com/learning/cdn/glossary/edge-server/).

**Egress**
: The cost or fee charged for data leaving a cloud provider's network. Called out specifically in this framework because R2's pricing model has no egress fees, which materially changes cost tradeoffs for data-lake and multi-read patterns compared to storage products that charge for it. See [R2 overview](https://developers.cloudflare.com/r2/).

**Eventual consistency**
: A consistency model where a write isn't guaranteed to be immediately visible everywhere it's read. Workers KV is eventually consistent: a write is usually visible immediately at its own location, but may take up to roughly a minute (or a configured cache TTL) to propagate globally. See [How KV works](https://developers.cloudflare.com/kv/concepts/how-kv-works/).

**Hyperdrive**
: A Cloudflare service that pools and reuses connections to an existing regional Postgres or MySQL database (on any cloud or provider) and places that pool close to the database, so Workers can query it without opening a new connection per invocation. See [Hyperdrive overview](https://developers.cloudflare.com/hyperdrive/).

**Isolate**
: The V8 execution context Workers run inside of — a lightweight, memory-isolated sandbox that starts far faster than a container or VM, letting a single machine run many isolates concurrently. See [How Workers works](https://developers.cloudflare.com/workers/reference/how-workers-works/).

**KV (Workers KV)**
: Cloudflare's globally distributed, eventually-consistent key-value store, optimized for high-volume reads of data that tolerates brief staleness — configuration, feature flags, cached values. See [Workers KV overview](https://developers.cloudflare.com/kv/).

**Origin**
: The server or service that ultimately holds the source of truth for content or application logic that Cloudflare fronts — a traditional web server behind a Route, an existing database behind Hyperdrive, or a private network reachable via Tunnel. See [What is an origin server?](https://www.cloudflare.com/learning/cdn/glossary/origin-server/).

**Pillar**
: One of the five categories this framework organizes design guidance under — Reliability, Security, Cost Optimization, Operational Excellence, and Performance Efficiency. See [Pillars overview](../pillars/index.md).

**Preview deployment**
: A unique, shareable URL generated automatically for a branch or pull request in Cloudflare Pages (and the equivalent preview URL feature for Workers), separate from the production deployment, so changes can be reviewed before merging. See [Preview deployments](https://developers.cloudflare.com/pages/configuration/preview-deployments/).

**Queue**
: A Cloudflare Queues resource that a producer Worker writes messages to and one or more consumer Workers read batches of messages from asynchronously, with configurable batching, retries, and delays. See [Cloudflare Queues overview](https://developers.cloudflare.com/queues/).

**R2**
: Cloudflare's S3-API-compatible object storage product, notable in this framework's cost guidance for having no egress fees. See [R2 overview](https://developers.cloudflare.com/r2/).

**Route (Workers)**
: A Workers routing mode that attaches a Worker to specific URL patterns on an existing proxied hostname, letting the Worker act in front of (and fall through to) an origin server that isn't the Worker itself. See [Routes](https://developers.cloudflare.com/workers/configuration/routing/routes/).

**Smart Placement**
: A Workers/Pages Functions feature that automatically runs a Worker's `fetch` handler in the Cloudflare location closest to its backend dependency, instead of the location closest to the end user, when doing so reduces overall latency. See [Placement](https://developers.cloudflare.com/workers/configuration/placement/).

**Strong consistency**
: A consistency model where a write is immediately visible to every subsequent read. Durable Objects provide this for the state owned by a single object instance — why they're the right tool for coordination and correctness-sensitive state that KV's eventual consistency can't safely support. See [What are Durable Objects?](https://developers.cloudflare.com/durable-objects/concepts/what-are-durable-objects/).

**Vectorize**
: Cloudflare's globally distributed vector database, used to store and query embeddings for semantic search, recommendations, or providing an LLM with retrieved context. See [Vectorize overview](https://developers.cloudflare.com/vectorize/).

**WebSocket Hibernation**
: An extension of the standard WebSocket API for Durable Objects that lets an object holding an open WebSocket connection be evicted from memory during idle periods without closing the connection, so it isn't billed for active compute time while idle. See [What are Durable Objects?](https://developers.cloudflare.com/durable-objects/concepts/what-are-durable-objects/).

**Worker**
: A unit of serverless code running on Cloudflare's V8-isolate-based runtime, invoked per request (or on a schedule, queue message, or other trigger) with no persistent process between invocations. See [Workers overview](https://developers.cloudflare.com/workers/).

**Workload**
: As used throughout this framework, a recognizable shape of application or system — a static site, a full-stack app, an API, an event-driven pipeline, a Zero Trust deployment — that a concrete reference architecture and pillar guidance can be attached to. See [Workloads overview](../workloads/index.md).

**Zero Trust**
: A security model in which no request is implicitly trusted based on network location; every request to a resource is authenticated and authorized based on identity and context, whether it originates inside or outside a traditional network perimeter. See [Cloudflare One overview](https://developers.cloudflare.com/cloudflare-one/).

## Further reading

- [Cloudflare Developer Platform documentation](https://developers.cloudflare.com/)
- [Cloudflare Learning Center](https://www.cloudflare.com/learning/)
