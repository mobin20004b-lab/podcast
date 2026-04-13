# Kubernetes Deployment Baseline (Day 3)

This base layer defines minimum Kubernetes objects shared across environments.

## Included Baseline

- `namespace.yaml`: standard namespace for platform workloads.
- `resource-quota.yaml`: starter quota for safe multitenant usage.
- `limit-range.yaml`: default compute requests/limits.
- `kustomization.yaml`: base bundle entrypoint.

## Environment Overlays

Day 3 now includes overlay entrypoints at:

- `infra/kubernetes/overlays/dev/kustomization.yaml`
- `infra/kubernetes/overlays/staging/kustomization.yaml`
- `infra/kubernetes/overlays/prod/kustomization.yaml`

These overlays currently apply namespace, labels, and name suffix conventions and can be extended with environment-specific patches.
