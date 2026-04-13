# Helm Deployment Assets

This folder provides reusable Helm packaging for every service under `services/`.

## Structure

- `charts/podcast-service`: shared microservice chart (Deployment, Service, ServiceAccount, Ingress, HPA).
- `services/<service>/values.yaml`: per-service values for image repo/name defaults.
- `environments/{dev,staging,prod}.yaml`: environment overlays.

## Example

```bash
helm upgrade --install user-profile-service   infra/helm/charts/podcast-service   -f infra/helm/services/user-profile-service/values.yaml   -f infra/helm/environments/dev.yaml   --namespace podcast-dev --create-namespace
```

## Batch render validation

```bash
for f in infra/helm/services/*/values.yaml; do
  svc=$(basename "$(dirname "$f")")
  helm template "$svc" infra/helm/charts/podcast-service -f "$f" -f infra/helm/environments/dev.yaml >/dev/null
  echo "validated: $svc"
done
```
