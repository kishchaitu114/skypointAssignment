region      = "us-east-1"
environment = "prod"
prefix      = "healthcare"

tfstate_bucket           = "healthcare-tfstate-ACCOUNT_ID"
tfstate_key              = "healthcare/aws/prod/terraform.tfstate"
tfstate_dynamodb_table   = "healthcare-tfstate-lock"

vpc_cidr             = "10.41.0.0/16"
availability_zones   = ["us-east-1a", "us-east-1b"]
private_subnet_cidrs = ["10.41.1.0/24", "10.41.2.0/24"]
public_subnet_cidrs  = ["10.41.101.0/24", "10.41.102.0/24"]

ecr_repository_name         = "healthcare-app"
db_identifier               = "hc-pg-prod"
db_instance_class           = "db.t3.small"
db_name                     = "healthcare"
db_username                 = "pgadmin"
db_allocated_storage        = 50
secrets_manager_secret_name = "healthcare/database-url-prod"

eks_cluster_name        = "healthcare-eks-prod"
eks_node_instance_types = ["t3.medium"]
eks_node_desired_size   = 2
eks_node_min_size       = 2
eks_node_max_size       = 8

enable_cloudwatch_alarms = true
