# Entitlement Service Schema Document

## 1. Service Scope
The Entitlement Service owns business capabilities for the `entitlement-service` bounded context and exposes internal APIs/events for other platform domains.

## 2. Owned Data Entities
- `entitlement`: primary aggregate managed by this service.
- `entitlement_revision`: immutable audit/change history for primary records.
- `entitlement_integration_state`: outbound sync and idempotency tracking.

## 3. API Contracts
- Transport: REST/JSON over HTTPS.
- Endpoints/Methods:
  - `GET /v1/entitlement`: list records with pagination.
  - `POST /v1/entitlement`: create a new record.
  - `GET /v1/entitlement/{entitlement_id}`: fetch by identifier.
  - `PATCH /v1/entitlement/{entitlement_id}`: partial update.
  - `DELETE /v1/entitlement/{entitlement_id}`: soft delete/deactivate.

## 4. Event Contracts
- Produced events:
  - `entitlement.created.v1`
  - `entitlement.updated.v1`
  - `entitlement.deleted.v1`
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
