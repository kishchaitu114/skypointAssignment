# Remote state: Google Cloud Storage with object versioning + optional lock via
# Terraform Cloud or native GCS (use a dedicated state bucket per org policy).
#
# One-time bootstrap (run once per org/project; do NOT commit bucket contents):
#   export PROJECT_ID="<your-gcp-project>"
#   export REGION="us-central1"
#   gcloud config set project "$PROJECT_ID"
#   gsutil mb -p "$PROJECT_ID" -l "$REGION" -b on gs://healthcare-tfstate-${PROJECT_ID}
#   gsutil versioning set on gs://healthcare-tfstate-${PROJECT_ID}
#
# Then init with:
#   terraform init \
#     -backend-config="bucket=healthcare-tfstate-<PROJECT_ID>" \
#     -backend-config="prefix=healthcare/gcp/dev"

terraform {
  backend "gcs" {}
}
