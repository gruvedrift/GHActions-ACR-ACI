# Exit on error
set -e

echo 'Initializing Terraform...'
terraform init;

echo 'Cleaning up and formatting configuration file...'
terraform fmt;

echo 'Validating Terraform configuration file...'
terraform validate;

echo 'Plan changes to infrastructure...'
terraform plan;

echo 'Apply configuration to infrastructure...'
terraform apply -auto-approve;
