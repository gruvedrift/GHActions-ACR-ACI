# Simple Ktor Webapp CI/CD with Terraform resource provisioning and deployment to Azure Container Instances

## Guide 
### 1. Install required software
   * You will need a Microsoft Azure account. Go create a free one, if you don't have one: [Free Account](https://azure.microsoft.com/en-us/free)
   * Install [Terraform](https://developer.hashicorp.com/terraform/install)
   * Install [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)

### 2. Login to Microsoft Azure

~~~
az login
~~~

### 3. Create Azure infrastructure
   * Run the `up.sh` script in order to create a `Azure Resource Group` , `Azure Container Registry` and `Azure Container Instance`

### 4. Obtain ACR password 
Our pipeline runner need some credentials in order to communicate with Azure. One of them is the password for ACR.<br>
Run the following command: 
~~~
az acr credential show --name gruvedriftcontainerregistry
~~~
Store the _first_ password in a GitHub Secret:`ACR_PASSWORD` and our ACR username: `ACR_USERNAME`.
In addition to those two, I recommend you create a GitHub secret for the registry name as well.<br>
It should look like this: `${ACR_USERNAME}.azurecr.io`. Store it in `ACR_REGISTRY`.

### 5. Obtain ACR Subscription ID
Run the following command and store output in a GitHub Secret: `ACR_SUBSCRIPTION_ID`
~~~
az acr show --name gruvedriftcontainerregistry --query "id" --output tsv
~~~

### 6. Create Service Principal
We will use the `Azure Login Action` in our pipeline. For that, we need a service principal, which is a secure identity with privileges.
~~~
az ad sp create-for-rbac --name gruvedrift --scopes ${ACR_SUBSCRIPTION_ID} --role acrpush
~~~
Note down the following output and store in GitHub secret: 
   * `appid` -> `AZURE_CLIENT_ID`
   * `password` -> `AZ_CLIENT_PASSWORD`
   * `tenant` -> `AZURE_TENANT_ID`


### GitHub Secret table
| GITHUB SECRET           | GITHUB SECRET               |
|-------------------------|-----------------------------|
| `ACR_USERNAME`          | gruvedriftcontainerregistry |
| `ACR_PASSWORD`          | Obtained in step #4         |
| `ACR_REGISTRY`          | Obtained in step #4         |
| `ACR_SUBSCRIPTION_ID`   | Obtained in step #5         |
| `AZURE_CLIENT_ID`       | Obtained in step #6         |
| `AZURE_CLIENT_PASSWORD` | Obtained in step #6         |
| `AZURE_TENANT_ID`       | Obtained in step #6         |

### 7. Enjoy the Ment
On any push to main branch, a new image will be built and pushed to the Azure Container Registry.

