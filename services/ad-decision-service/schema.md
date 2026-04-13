# Ad Decision Service Schema Document

## 1. Service Scope
The Ad Decision Service owns business capabilities for the `ad-decision-service` bounded context and exposes internal APIs/events for other platform domains.

## 2. Owned Data Entities
- `ad_decision`: primary aggregate managed by this service.
- `ad_decision_revision`: immutable audit/change history for primary records.
- `ad_decision_integration_state`: outbound sync and idempotency tracking.

## 3. API Contracts
- Transport: REST/JSON over HTTPS.
- Endpoints/Methods:
  - `GET /v1/ad_decision`: list records with pagination.
  - `POST /v1/ad_decision`: create a new record.
  - `GET /v1/ad_decision/{ad_decision_id}`: fetch by identifier.
  - `PATCH /v1/ad_decision/{ad_decision_id}`: partial update.
  - `DELETE /v1/ad_decision/{ad_decision_id}`: soft delete/deactivate.

## 4. Event Contracts
- Produced events:
  - `ad_decision.created.v1`
  - `ad_decision.updated.v1`
  - `ad_decision.deleted.v1`
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
