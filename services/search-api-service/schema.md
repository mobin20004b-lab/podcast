# Search API Service Schema Document

## 1. Service Scope
The Search API Service owns business capabilities for the `search-api-service` bounded context and exposes internal APIs/events for other platform domains.

## 2. Owned Data Entities
- `search_api`: primary aggregate managed by this service.
- `search_api_revision`: immutable audit/change history for primary records.
- `search_api_integration_state`: outbound sync and idempotency tracking.

## 3. API Contracts
- Transport: REST/JSON over HTTPS.
- Endpoints/Methods:
  - `GET /v1/search_api`: list records with pagination.
  - `POST /v1/search_api`: create a new record.
  - `GET /v1/search_api/{search_api_id}`: fetch by identifier.
  - `PATCH /v1/search_api/{search_api_id}`: partial update.
  - `DELETE /v1/search_api/{search_api_id}`: soft delete/deactivate.

## 4. Event Contracts
- Produced events:
  - `search_api.created.v1`
  - `search_api.updated.v1`
  - `search_api.deleted.v1`
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
