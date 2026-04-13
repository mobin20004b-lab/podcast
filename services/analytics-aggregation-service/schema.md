# Analytics Aggregation Service Schema Document

## 1. Service Scope
The Analytics Aggregation Service owns business capabilities for the `analytics-aggregation-service` bounded context and exposes internal APIs/events for other platform domains.

## 2. Owned Data Entities
- `analytics_aggregation`: primary aggregate managed by this service.
- `analytics_aggregation_revision`: immutable audit/change history for primary records.
- `analytics_aggregation_integration_state`: outbound sync and idempotency tracking.

## 3. API Contracts
- Transport: REST/JSON over HTTPS.
- Endpoints/Methods:
  - `GET /v1/analytics_aggregation`: list records with pagination.
  - `POST /v1/analytics_aggregation`: create a new record.
  - `GET /v1/analytics_aggregation/{analytics_aggregation_id}`: fetch by identifier.
  - `PATCH /v1/analytics_aggregation/{analytics_aggregation_id}`: partial update.
  - `DELETE /v1/analytics_aggregation/{analytics_aggregation_id}`: soft delete/deactivate.

## 4. Event Contracts
- Produced events:
  - `analytics_aggregation.created.v1`
  - `analytics_aggregation.updated.v1`
  - `analytics_aggregation.deleted.v1`
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
