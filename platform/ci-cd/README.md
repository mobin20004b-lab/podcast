# CI/CD Baseline (Day 3)

This directory contains reusable CI/CD building blocks for all services.

## Goals

- Enforce repository guardrails on every pull request.
- Validate Priority 0 API contracts with real OpenAPI linting.
- Provide a reusable path for per-service CI rollout.

## Contents

- `templates/service-ci.yml`: reusable GitHub Actions workflow for service-level checks.

## Repository Integrations

- `.github/workflows/repo-guardrails.yml` runs roadmap and contract checks on PRs and `main` pushes.
- `.github/scripts/priority0-contracts.txt` is the single source of truth for Priority 0 OpenAPI files.
- `.github/scripts/validate-priority0-contracts.sh` enforces file presence and minimum required OpenAPI keys.

## Rollout Plan

1. Reuse `templates/service-ci.yml` from service workflows via `workflow_call`.
2. Extend checks with provider/consumer contract tests in Day 4.
3. Add deploy gates for environment overlays (`dev`, `staging`, `prod`).
