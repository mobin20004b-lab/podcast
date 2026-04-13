# Comment Community Service Schema Document

## 1. Service Scope
The Comment Community Service owns business capabilities for the `comment-community-service` bounded context and exposes internal APIs/events for other platform domains.

## 2. Owned Data Entities
- `comment_community`: primary aggregate managed by this service.
- `comment_community_revision`: immutable audit/change history for primary records.
- `comment_community_integration_state`: outbound sync and idempotency tracking.

## 3. API Contracts
- Transport: REST/JSON over HTTPS.
- Endpoints/Methods:
  - `GET /v1/comment_community`: list records with pagination.
  - `POST /v1/comment_community`: create a new record.
  - `GET /v1/comment_community/{comment_community_id}`: fetch by identifier.
  - `PATCH /v1/comment_community/{comment_community_id}`: partial update.
  - `DELETE /v1/comment_community/{comment_community_id}`: soft delete/deactivate.

## 4. Event Contracts
- Produced events:
  - `comment_community.created.v1`
  - `comment_community.updated.v1`
  - `comment_community.deleted.v1`
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
