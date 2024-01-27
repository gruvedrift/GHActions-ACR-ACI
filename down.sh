set -e

echo 'Deleting Azure resources...'
terraform destroy -auto-approve;
