# you must name your service principal
$env:SERVICE_PRINCIPAL="<the service principal>"
$env:AZURE_USER="azureuser@myserver" 
$env:SSH_KEY_NAME="MyKey"
az ad sp create-for-rbac --name $env:SERVICE_PRINCIPAL
Push-Location
Set-Location ~
ssh-keygen -m PEM -t rsa -b 4096 -C $env:AZURE_USER -f $env:SSH_KEY_NAME
Pop-Location