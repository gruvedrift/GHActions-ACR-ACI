## HOW TO DO THIS 

1) Write Dockerfile
   1) `docker build -t coop-de-grace:v1 .`
2) Test that it runs on Docker Desktop 
   1) `docker run -p 8080:8080 coop-de-grace:v1`
3) Create A resource 
4) Create ACR
   1) `az acr create --resource-group gruvedrift-resource-group --name coopacrv1 --sku Basic`
   2) Enable admin user and azure will create passwords for you
   3) Tag docker image with details of your azure registry: `docker tag coop-de-grace:v1 coopacrv1.azurecr.io/coop-de-grace:v1`
   4) Log into ACR with user and password from _access key_ tab: `coopacrv1.azurecr.io`
   5) Username: `${azure container registry name}`
   6) Password: `${azure containe registry passweod}`
   7) Push the docker image to ACR: `docker push coopacrv1.azurecr.io/coop-de-grace:v1`
5) Create Azure Container Instance 
   1) Create Azure Container Instance 
   2) Container name  



_Note to self: docker build --platform=linux/amd64 -t <image-name>:<version>-amd64

### TODO 

Find out how to build linux images with arm64 architecture for azure.


1) Create resource via Terraform 
2) Create ACR via Terraform 
3) Create ACI via Terraform

4) Script everything together 
