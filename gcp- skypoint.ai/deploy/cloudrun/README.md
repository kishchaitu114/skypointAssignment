# Cloud Run deploy notes

Infrastructure is primarily managed by `gcp/terraform/modules/compute`. This folder documents optional
supplemental manifests if you prefer `gcloud run services replace` over Terraform-only deploy.

After CI pushes an image to Artifact Registry:

```bash
gcloud run services update healthcare-api-dev \
  --region=us-central1 \
  --image="${REGION}-docker.pkg.dev/${PROJECT}/healthcare/healthcare-app:${GIT_SHA}"
```

For **custom domain + HTTPS** (not fully automated in Terraform here):

1. Reserve a global static IP and create an external HTTPS load balancer (serverless NEG → Cloud Run).
2. Map DNS `A` record to the LB IP.
3. Attach a Google-managed certificate on the LB frontend.
4. Restrict Cloud Run ingress to `internal-and-cloud-load-balancing` when using LB-only public access.

See `gcp/README.md` for the full sequence.
