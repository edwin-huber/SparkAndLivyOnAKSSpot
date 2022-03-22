# converted from the bash script.
# https://docs.microsoft.com/en-us/cli/azure/aks?view=azure-cli-latest#az-aks-create

# cluster needs to be created as private => still needs modification
az aks create --resource-group $env:RESOURCE_GROUP --name $env:AKS_CLUSTER_NAME --node-count 1 -s Standard_B2ms --ssh-key-value $env:SSH_PUBLIC_KEY --network-plugin azure --service-cidr 10.4.0.0/16 --dns-service-ip 10.4.0.10 --docker-bridge-address 172.17.0.1/16 --vnet-subnet-id "/subscriptions/$env:SUBCRIPTION_ID/resourceGroups/$env:RESOURCE_GROUP/providers/Microsoft.Network/virtualNetworks/$env:VNET_NAME/subnets/$env:SUBNET_NAME" --service-principal $env:SERVICE_PRINCIPAL --client-secret $env:SERVICE_PRINCIPAL_SECRET --location WestEurope --enable-private-cluster