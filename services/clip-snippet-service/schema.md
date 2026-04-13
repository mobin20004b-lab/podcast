# Clip Snippet Service Schema Document

## 1. Service Scope
The Clip Snippet Service owns business capabilities for the `clip-snippet-service` bounded context and exposes internal APIs/events for other platform domains.

## 2. Owned Data Entities
- `clip_snippet`: primary aggregate managed by this service.
- `clip_snippet_revision`: immutable audit/change history for primary records.
- `clip_snippet_integration_state`: outbound sync and idempotency tracking.

## 3. API Contracts
- Transport: REST/JSON over HTTPS.
- Endpoints/Methods:
  - `GET /v1/clip_snippet`: list records with pagination.
  - `POST /v1/clip_snippet`: create a new record.
  - `GET /v1/clip_snippet/{clip_snippet_id}`: fetch by identifier.
  - `PATCH /v1/clip_snippet/{clip_snippet_id}`: partial update.
  - `DELETE /v1/clip_snippet/{clip_snippet_id}`: soft delete/deactivate.

## 4. Event Contracts
- Produced events:
  - `clip_snippet.created.v1`
  - `clip_snippet.updated.v1`
  - `clip_snippet.deleted.v1`
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
