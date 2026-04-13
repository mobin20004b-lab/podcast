# Feature Pipeline Service Schema Document

## 1. Service Scope
The Feature Pipeline Service owns business capabilities for the `feature-pipeline-service` bounded context and exposes internal APIs/events for other platform domains.

## 2. Owned Data Entities
- `feature_pipeline`: primary aggregate managed by this service.
- `feature_pipeline_revision`: immutable audit/change history for primary records.
- `feature_pipeline_integration_state`: outbound sync and idempotency tracking.

## 3. API Contracts
- Transport: REST/JSON over HTTPS.
- Endpoints/Methods:
  - `GET /v1/feature_pipeline`: list records with pagination.
  - `POST /v1/feature_pipeline`: create a new record.
  - `GET /v1/feature_pipeline/{feature_pipeline_id}`: fetch by identifier.
  - `PATCH /v1/feature_pipeline/{feature_pipeline_id}`: partial update.
  - `DELETE /v1/feature_pipeline/{feature_pipeline_id}`: soft delete/deactivate.

## 4. Event Contracts
- Produced events:
  - `feature_pipeline.created.v1`
  - `feature_pipeline.updated.v1`
  - `feature_pipeline.deleted.v1`
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
