# you must name your service principal
$env:SERVICE_PRINCIPAL="<the service principal>"
$env:AZURE_USER="azureuser@myserver" 
$env:SSH_KEY_NAME="MyKey"
az ad sp create-for-rbac --name $env:SERVICE_PRINCIPAL
# this creates an SSH Key Pair used on the AKS cluster in the
# user's home directory used for SSH access
Push-Location
Set-Location ~
ssh-keygen -m PEM -t rsa -b 4096 -C $env:AZURE_USER -f $env:SSH_KEY_NAME
Pop-Location