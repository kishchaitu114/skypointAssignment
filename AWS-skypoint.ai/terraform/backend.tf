# Remote state: S3 + DynamoDB state locking.
#
# One-time bootstrap:
#   export AWS_REGION="us-east-1"
#   export TF_STATE_BUCKET="healthcare-tfstate-${AWS_ACCOUNT_ID}"
#   aws s3api create-bucket --bucket "$TF_STATE_BUCKET" --region "$AWS_REGION"
#   aws s3api put-bucket-versioning --bucket "$TF_STATE_BUCKET" \
#     --versioning-configuration Status=Enabled
#   aws dynamodb create-table \
#     --table-name healthcare-tfstate-lock \
#     --attribute-definitions AttributeName=LockID,AttributeType=S \
#     --key-schema AttributeName=LockID,KeyType=HASH \
#     --billing-mode PAY_PER_REQUEST
#
#   terraform init \
#     -backend-config="bucket=${TF_STATE_BUCKET}" \
#     -backend-config="key=healthcare/aws/dev/terraform.tfstate" \
#     -backend-config="region=${AWS_REGION}" \
#     -backend-config="dynamodb_table=healthcare-tfstate-lock"

terraform {
  backend "s3" {}
}
