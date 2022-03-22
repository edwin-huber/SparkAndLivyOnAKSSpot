# this sets all the settings used in later scripts
$env:ACR_NAME="<your ACR Name>"
$env:SUBCRIPTION_ID="<your subscription ID>"
$env:RESOURCE_GROUP="<your resource group name>"
$env:SSH_PUBLIC_KEY="<an SSH public key>"
$env:VNET_NAME="aksspotnet"
$env:SUBNET_NAME="akssubnet"
$env:AKS_CLUSTER_NAME="aksspot"
# using the appId of the principal
$env:SERVICE_PRINCIPAL="<the service principal>"
$env:SERVICE_PRINCIPAL_SECRET="<the service principal password>"