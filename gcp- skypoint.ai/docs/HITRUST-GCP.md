# HITRUST control mapping — GCP (Cloud Run path)

| HITRUST domain | How it's satisfied | Where (file) |
|---|---|---|
| **Access Control (01)** | Cloud Run runtime SA with least-privilege IAM (`secretAccessor`, `artifactregistry.reader`, `cloudsql.client`); no JSON keys in git; WIF for CI | `gcp/terraform/main.tf`, `gcp/terraform/modules/compute/main.tf`, `gcp/.github/workflows/gcp-ci.yml` |
| **Audit Logging (06)** | Cloud Logging sink for NOTICE+ events | `gcp/terraform/modules/monitoring/main.tf` |
| **Encryption (10)** | Cloud SQL `ENCRYPTED_ONLY` SSL; Secret Manager for connection string; TLS at external HTTPS LB (documented) | `gcp/terraform/modules/database/main.tf`, `gcp/terraform/modules/secrets/main.tf`, `gcp/README.md` |
| **Configuration Management (09)** | Terraform modules + remote GCS state; `terraform fmt`/`validate`/`plan` in CI | `gcp/terraform/`, `gcp/.github/workflows/gcp-ci.yml` |
| **Vulnerability Management (10)** | semgrep, pip-audit, tfsec (CRITICAL gate), Trivy on image | `gcp/.github/workflows/gcp-ci.yml` |
| **Network Security (08)** | Private Cloud SQL (no public IP); VPC connector; Cloud Run ingress internal-only | `gcp/terraform/modules/network/main.tf`, `gcp/terraform/modules/database/main.tf`, `gcp/terraform/modules/compute/main.tf` |
| **Secrets Management (10)** | `random_password` → Secret Manager; env from secret ref; no secrets in tfvars/git | `gcp/terraform/main.tf`, `gcp/terraform/modules/secrets/main.tf` |
