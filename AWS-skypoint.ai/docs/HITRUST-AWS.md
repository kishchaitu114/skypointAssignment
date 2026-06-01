# HITRUST control mapping — AWS (EKS path)

| HITRUST domain | How it's satisfied | Where (file) |
|---|---|---|
| **Access Control (01)** | EKS RBAC; IRSA for pod→Secrets Manager; ECR scan on push; CI via GitHub OIDC role assumption | `aws/terraform/modules/eks/main.tf`, `aws/charts/healthcare-app/templates/serviceaccount.yaml`, `aws/.github/workflows/aws-ci.yml` |
| **Audit Logging (06)** | CloudWatch alarm scaffold; extend with EKS control plane logs + Container Insights | `aws/terraform/modules/monitoring/main.tf` |
| **Encryption (10)** | RDS `storage_encrypted`; `rds.force_ssl`; Secrets Manager JSON secret; ingress TLS via cert-manager | `aws/terraform/modules/database/main.tf`, `aws/terraform/modules/secrets/main.tf`, `aws/charts/healthcare-app/templates/ingress.yaml` |
| **Configuration Management (09)** | Terraform + Helm; S3/DynamoDB remote state; plan in CI | `aws/terraform/backend.tf`, `aws/.github/workflows/aws-ci.yml` |
| **Vulnerability Management (10)** | semgrep, pip-audit, tfsec, Trivy, ECR scan on push | `aws/.github/workflows/aws-ci.yml`, `aws/terraform/modules/registry/main.tf` |
| **Network Security (08)** | Private RDS; private EKS subnets; NetworkPolicy egress 5432 + DNS 53 | `aws/terraform/modules/network/main.tf`, `aws/charts/healthcare-app/templates/networkpolicy.yaml` |
| **Secrets Management (10)** | `random_password` → Secrets Manager; CSI + IRSA mount; no secrets in git | `aws/terraform/main.tf`, `aws/charts/healthcare-app/templates/secretproviderclass.yaml` |
