# Implementation Priority List and Roadmap (Day 1)

This document translates `plan.md` into an actionable implementation sequence for a monorepo setup.

## 1) Priority List (What to Build First)

### Priority 0 (Foundation Critical Path)

1. Access and identity backbone
   - `api-gateway`
   - `web-mobile-bff`
   - `auth-and-identity-service`
   - `access-control-rbac-service`
   - `device-and-session-service`
2. Core content flow
   - `catalog-service`
   - `creator-channel-service`
   - `publishing-workflow-service`
   - `media-upload-service`
   - `media-processing-service`
   - `media-asset-registry-service`
3. Playback and entitlement minimum viability
   - `playback-authorization-service`
   - `playback-session-service`
   - `entitlement-service`
4. Platform and event base
   - `event-ingestion-backbone`
   - `audit-log-service`

### Priority 1 (User Experience Core)

- `user-profile-service`
- `user-library-service`
- `playlist-service`
- `resume-continue-listening-service`
- `search-api-service`
- `search-indexing-pipeline`
- `discovery-service`
- `notification-service`
- `notification-preference-service`
- `webhook-ingress-service`

### Priority 2 (Growth, Analytics, Monetization)

- `recommendation-service`
- `feature-pipeline-service`
- `model-serving-ranking-service`
- `experimentation-a-b-testing-service`
- `telemetry-playback-tracking-service`
- `analytics-aggregation-service`
- `creator-analytics-api`
- `product-analytics-service`
- `billing-service`
- `financial-ledger-reconciliation-service`
- `creator-payout-service`
- `campaign-management-service`
- `ad-decision-service`
- `ad-measurement-service`

### Priority 3 (Advanced Operations and Compliance)

- `admin-bff`
- `admin-operations-service`
- `content-moderation-trust-and-safety-service`
- `copyright-audio-fingerprinting-service`
- `gdpr-data-rights-service`
- `legal-hold-compliance-service`
- `export-and-batch-processing-service`
- `scheduler-workflow-orchestration-service`
- `rss-aggregator-and-ingestion-service`
- `bulk-import-migration-service`
- `ai-transcription-service`
- `metadata-extraction-service`
- `engagement-automation-service`
- `clip-snippet-service`
- `likes-reactions-service`
- `comment-community-service`
- `social-graph-service`
- `offline-download-service`
- `deep-linking-share-resolution-service`
- `creator-studio-bff`

---

## 2) Roadmap by Architecture Part (Layer-Based)

## Part A — Client + Edge + Access Layer

**Goal:** stable, secure entry path from all clients to internal services.

- Week 1: gateway baseline, auth pre-check, BFF skeletons.
- Week 2: rate limiting, routing policies, request normalization, error contracts.
- Week 3: webhook ingress hardening, idempotency, replay protection.
- Week 4: production SLOs, synthetic checks, edge cache rules.

## Part B — Identity and Security Core

**Goal:** trusted identity and authorization everywhere.

- Week 1: login/signup, token issuance, session model.
- Week 2: RBAC policy model and permission checks.
- Week 3: device/session revoke flows and anomaly signals.
- Week 4: audit coverage and policy enforcement hooks.

## Part C — Content Supply Chain

**Goal:** ingest, process, publish, and serve media reliably.

- Week 1: media upload contracts + processing job contracts.
- Week 2: asset registry and publishing workflow states.
- Week 3: moderation and metadata integration points.
- Week 4: retry, dead-letter handling, operational runbooks.

## Part D — Playback Experience

**Goal:** low-latency playback with entitlement enforcement.

- Week 1: playback authorization and session lifecycle.
- Week 2: telemetry event model and continue-listening path.
- Week 3: offline/download policy and state sync.
- Week 4: QoE dashboards and alert thresholds.

## Part E — Discovery, Search, Recommendation

**Goal:** relevant discovery and personalization loops.

- Week 1: search API contract and indexing pipeline skeleton.
- Week 2: discovery feed logic and basic candidate generation.
- Week 3: feature pipeline + ranking serving + experiments.
- Week 4: feedback loop calibration from analytics signals.

## Part F — Monetization and Financial Controls

**Goal:** predictable revenue flows and reconciliation.

- Week 1: billing and entitlement boundaries.
- Week 2: ad decisioning and campaign lifecycle basics.
- Week 3: payout and ledger event consistency checks.
- Week 4: reconciliation automation and finance reporting contracts.

## Part G — Governance, Compliance, and Admin Ops

**Goal:** enterprise-grade trust, legal, and ops readiness.

- Week 1: admin and audit APIs.
- Week 2: GDPR requests + legal hold workflow definitions.
- Week 3: trust and safety review queues.
- Week 4: export controls and compliance evidence automation.

## Part H — Platform Engineering

**Goal:** reusable engineering platform for all services.

- Week 1: CI templates, lint/test standards, repo guardrails.
- Week 2: deploy templates, environment conventions, secrets policy.
- Week 3: observability standards (logs/metrics/traces).
- Week 4: autoscaling baselines, backup/restore drills.

---

## 3) Roadmap by Service Group

## Access and Aggregation Services

- `api-gateway`: implement ingress policy, route table, rate limiting, and auth pre-check.
- `web-mobile-bff`: implement home/feed orchestration, partial failure strategy, response shaping.
- `creator-studio-bff`: implement creator operations aggregation and analytics views.
- `admin-bff`: implement moderation and operational action aggregation.
- `webhook-ingress-service`: implement signature verification + dedup + event normalization.

## Identity and User Domain Services

- `auth-and-identity-service`: implement auth flows, token lifecycle, and refresh policies.
- `user-profile-service`: implement profile CRUD, privacy settings, and locale preferences.
- `access-control-rbac-service`: implement role model and permission evaluation endpoints.
- `device-and-session-service`: implement active session tracking and remote revoke.

## Catalog and Publishing Services

- `catalog-service`: implement podcast/episode metadata lifecycle.
- `creator-channel-service`: implement channel ownership and branding data.
- `publishing-workflow-service`: implement review states and publish scheduling.
- `rss-aggregator-and-ingestion-service`: implement feed parser and import dedup.
- `bulk-import-migration-service`: implement large-scale migration pipelines.

## Media Pipeline Services

- `media-upload-service`: implement pre-signed upload initiation and validation.
- `media-processing-service`: implement transcode/normalize orchestration and retries.
- `media-asset-registry-service`: implement asset metadata registry and state transitions.
- `ai-transcription-service`: implement transcription job APIs and result storage contracts.
- `metadata-extraction-service`: implement auto-tag, chapter, and entity extraction contracts.
- `copyright-audio-fingerprinting-service`: implement fingerprint generation and match workflow.
- `content-moderation-trust-and-safety-service`: implement moderation decision pipeline.

## Playback and Listener Experience Services

- `playback-authorization-service`: implement entitlement and signed playback authorization.
- `playback-session-service`: implement session heartbeat and state lifecycle.
- `telemetry-playback-tracking-service`: implement playback events ingestion contract.
- `resume-continue-listening-service`: implement position checkpoint model.
- `offline-download-service`: implement offline policy tokens and sync protocols.
- `user-library-service`: implement follows/saves subscriptions and query APIs.
- `playlist-service`: implement playlist CRUD and ordering.

## Community and Social Services

- `likes-reactions-service`: implement reaction model and aggregation counters.
- `comment-community-service`: implement comment threads and moderation flags.
- `clip-snippet-service`: implement clip generation and share metadata.
- `social-graph-service`: implement follow graph and recommendation primitives.
- `deep-linking-share-resolution-service`: implement short-link resolution and attribution.

## Search and Discovery Intelligence Services

- `search-api-service`: implement query endpoint and facet/filter contract.
- `search-indexing-pipeline`: implement index update consumers and reindex workflow.
- `discovery-service`: implement curated/trending feed composition.
- `recommendation-service`: implement personalized candidate generation.
- `feature-pipeline-service`: implement training/serving feature definitions.
- `model-serving-ranking-service`: implement online ranking inference endpoint.
- `experimentation-a-b-testing-service`: implement experiment assignment and exposure logs.

## Notification and Engagement Services

- `notification-service`: implement channel delivery orchestrator (email/push/in-app).
- `notification-preference-service`: implement user opt-in and quiet-hours policy.
- `engagement-automation-service`: implement trigger rules and campaign actions.

## Monetization Services

- `billing-service`: implement subscription and invoice lifecycle.
- `entitlement-service`: implement access grants and real-time entitlement lookup.
- `financial-ledger-reconciliation-service`: implement immutable ledger and reconciliation jobs.
- `creator-payout-service`: implement payout calculation and settlement events.
- `campaign-management-service`: implement ad campaign CRUD and targeting rules.
- `ad-decision-service`: implement ad selection contract for playback requests.
- `ad-measurement-service`: implement impression/conversion measurement pipeline.

## Analytics and Event Backbone Services

- `event-ingestion-backbone`: implement canonical event envelope and routing.
- `analytics-aggregation-service`: implement OLAP-ready rollups.
- `creator-analytics-api`: implement creator-facing analytics query APIs.
- `product-analytics-service`: implement product KPI marts and metric definitions.

## Admin, Compliance, and Batch Services

- `admin-operations-service`: implement operator actions and case workflow.
- `audit-log-service`: implement immutable audit records and retention policies.
- `gdpr-data-rights-service`: implement DSAR export/delete/rectify orchestration.
- `legal-hold-compliance-service`: implement legal hold policy enforcement.
- `export-and-batch-processing-service`: implement scheduled export pipelines.
- `scheduler-workflow-orchestration-service`: implement cross-service workflow scheduling.

---

## 4) Delivery Cadence Recommendation

- Sprint 1-2: complete Priority 0.
- Sprint 3-4: complete Priority 1 and stabilize end-to-end playback journey.
- Sprint 5-6: deliver Priority 2 monetization + recommendation loop.
- Sprint 7+: expand Priority 3 compliance, advanced creator tooling, and scale operations.
