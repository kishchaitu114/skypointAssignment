# EKS add-ons (install once per cluster)

```bash
helm repo add jetstack https://charts.jetstack.io && helm repo update
helm install cert-manager jetstack/cert-manager -n cert-manager --create-namespace --set installCRDs=true

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx && helm repo update
helm install ingress-nginx ingress-nginx/ingress-nginx -n ingress-nginx --create-namespace

# AWS Secrets Manager CSI driver + IRSA (see AWS docs for latest chart)
helm repo add secrets-store-csi-driver https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts
helm install csi-secrets-store secrets-store-csi-driver/secrets-store-csi-driver -n kube-system

kubectl apply -f aws/k8s/cluster-issuer.yaml
```

Edit the ACME email in `cluster-issuer.yaml` before applying.
