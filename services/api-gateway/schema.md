# API Gateway Schema Document

## 1. Service Scope
The API Gateway owns business capabilities for the `api-gateway` bounded context and exposes internal APIs/events for other platform domains.

## 2. Owned Data Entities
- `api_gateway`: primary aggregate managed by this service.
- `api_gateway_revision`: immutable audit/change history for primary records.
- `api_gateway_integration_state`: outbound sync and idempotency tracking.

## 3. API Contracts
- Transport: REST/JSON over HTTPS.
- Endpoints/Methods:
  - `GET /v1/api_gateway`: list records with pagination.
  - `POST /v1/api_gateway`: create a new record.
  - `GET /v1/api_gateway/{api_gateway_id}`: fetch by identifier.
  - `PATCH /v1/api_gateway/{api_gateway_id}`: partial update.
  - `DELETE /v1/api_gateway/{api_gateway_id}`: soft delete/deactivate.

## 4. Event Contracts
- Produced events:
  - `api_gateway.created.v1`
  - `api_gateway.updated.v1`
  - `api_gateway.deleted.v1`
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
