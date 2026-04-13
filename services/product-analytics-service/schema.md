# Product Analytics Service Schema Document

## 1. Service Scope
The Product Analytics Service owns business capabilities for the `product-analytics-service` bounded context and exposes internal APIs/events for other platform domains.

## 2. Owned Data Entities
- `product_analytics`: primary aggregate managed by this service.
- `product_analytics_revision`: immutable audit/change history for primary records.
- `product_analytics_integration_state`: outbound sync and idempotency tracking.

## 3. API Contracts
- Transport: REST/JSON over HTTPS.
- Endpoints/Methods:
  - `GET /v1/product_analytics`: list records with pagination.
  - `POST /v1/product_analytics`: create a new record.
  - `GET /v1/product_analytics/{product_analytics_id}`: fetch by identifier.
  - `PATCH /v1/product_analytics/{product_analytics_id}`: partial update.
  - `DELETE /v1/product_analytics/{product_analytics_id}`: soft delete/deactivate.

## 4. Event Contracts
- Produced events:
  - `product_analytics.created.v1`
  - `product_analytics.updated.v1`
  - `product_analytics.deleted.v1`
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
