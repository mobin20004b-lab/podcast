# Content Moderation Trust And Safety Service Schema Document

## 1. Service Scope
The Content Moderation Trust And Safety Service owns business capabilities for the `content-moderation-trust-and-safety-service` bounded context and exposes internal APIs/events for other platform domains.

## 2. Owned Data Entities
- `content_moderation_trust_and_safety`: primary aggregate managed by this service.
- `content_moderation_trust_and_safety_revision`: immutable audit/change history for primary records.
- `content_moderation_trust_and_safety_integration_state`: outbound sync and idempotency tracking.

## 3. API Contracts
- Transport: REST/JSON over HTTPS.
- Endpoints/Methods:
  - `GET /v1/content_moderation_trust_and_safety`: list records with pagination.
  - `POST /v1/content_moderation_trust_and_safety`: create a new record.
  - `GET /v1/content_moderation_trust_and_safety/{content_moderation_trust_and_safety_id}`: fetch by identifier.
  - `PATCH /v1/content_moderation_trust_and_safety/{content_moderation_trust_and_safety_id}`: partial update.
  - `DELETE /v1/content_moderation_trust_and_safety/{content_moderation_trust_and_safety_id}`: soft delete/deactivate.

## 4. Event Contracts
- Produced events:
  - `content_moderation_trust_and_safety.created.v1`
  - `content_moderation_trust_and_safety.updated.v1`
  - `content_moderation_trust_and_safety.deleted.v1`
- Consumed events:
  - `identity.user.created.v1`
  - `compliance.retention.policy.changed.v1`

## 5. Storage Model
- Primary datastore: PostgreSQL (OLTP) with UUID keys.
- Caching: Redis for hot reads and idempotency locks.
- Retention: Active records indefinitely; soft-deleted rows retained for 90 days.

## 6. Validation & Constraints
- IDs are UUIDv4.
- `status` is an enum (`active`, `inactive`, `deleted`).
- Writes require optimistic concurrency via `version` field.
- Domain events must include `event_id`, `occurred_at`, and `trace_id`.

## 7. Versioning
- Current schema version: `v1`.
- Backward compatibility notes: additive changes only within v1; breaking changes require v2 endpoints/events.
