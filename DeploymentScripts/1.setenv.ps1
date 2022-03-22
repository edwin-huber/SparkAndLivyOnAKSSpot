# this sets all the settings used in later scripts
$env:ACR_NAME="<your ACR Name>"
$env:SUBCRIPTION_ID="<your subscription ID>"
$env:RESOURCE_GROUP="<your resource group name>"
# this is the ssh key that we shall use for the AKS cluster
$env:SSH_PUBLIC_KEY="<an SSH public key>"
$env:VNET_NAME="aksspotnet"
# this is the VNet subnet into which we shall deploy the AKS cluster
$env:SUBNET_NAME="akssubnet"
$env:AKS_CLUSTER_NAME="aksspot"
# using the appId of the principal
$env:SERVICE_PRINCIPAL_SECRET="<the service principal password>"