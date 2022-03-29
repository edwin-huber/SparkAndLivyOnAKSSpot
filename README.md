# Spark And Livy On AKS Spot Instances

This repo is collating the work we are doing with a partner to enable their Spark / Livy pipeline to run on Azure Spot instances via AKS.

![Solution Architecture Diagram](./img/Solution%20Architecture.jpg)

## Deployment and Configuration

You will find the deployment scripts to create the environment depicted above in this repo.
The scripts are numbered 0 - N, and are expected to be run in order.
You will need the output from the first script ([0.](/DeploymentScripts/0.create-service-principal-and-ssh-key-pair.ps1)) to fill out some of the environment variables used in the second script ([1.](/DeploymentScripts/1.setenv.ps1)).

These scripts were using the current version of the Azure CLI (2.34.1) at the time of writing.
Whilst written for PowerShell, we have used Az CLI to easily allow the transfer of this logic to Bash scripts if desired.

This solution relys on the use of Helm Charts to configure a Livy Spark POD, which will start workers running in the AKS spot pools.The cluster is isolated and on a private network. It uses Azure Bastion and a JIT enabled VM to manage the AKS cluster and container registry.  
Alternative topologies could use a VPN gateway to access network resources in the protected environment. 

We used and adapted the information available here to run Livy in AKS:

Working on AKS: (albeit with older version of livy / spark)
- https://github.com/anildwarepo/spark-on-aks

Useful info:
- https://github.com/JahstreetOrg/spark-on-kubernetes-helm 
  
- https://spark.apache.org/docs/latest/running-on-kubernetes.html
  
- Livy API documentation: https://livy.incubator.apache.org/docs/latest/rest-api.html

1. Build the spark and the livy docker image by filling in your docker registry in the `acrbuild.sh` script in the `DockerImage/spark` as well as `DockerImage/livy` image
2. Run both `acrbuild.sh` scripts to build and push the docker images
3. Install the livy helm chart
```
kubectl create namespace livy
helm install livy -n livy <path-to-repo>/charts/livy --set rbac.create=true
```
4. Forward port to localhost
```
kubectl port-forward -n livy livy-0 8998:8998 &
```

## Usage
1. Create interactive session
``````
curl -L -X POST 'http://localhost:8998/sessions ' -H 'Content-Type: application/json' --data-raw '{
  "conf": {
    "spark.kubernetes.executor.podTemplateFile": "/opt/livy/work-dir/executor-pod-template.yaml",
    "spark.kubernetes.driver.podTemplateFile": "/opt/livy/work-dir/driver-pod-template.yaml"
  },
  "kind": "spark"
}
'
``````
2. Create statement
``````
curl -L -X POST 'localhost:8998/sessions/:session_id/statements' -H 'Content-Type: application/json' --data-raw '{
   "code": "sc.parallelize(1 to 10).count()"
}
'
``````
3. Get result
``````
curl -L -X GET 'localhost:8998/sessions/:session_id/statements/:statement_id'
``````

 ## Next Steps / POC Items
  - Create private cluster with JIT access jump host behind bastion service (done)
  - Validate basic spark and livy operation in AKS using port forwarding - (done)
  - Update scripts with VNet Creation, bastion (done)
  - Update script to create VM Jump Host (Edwin)
  - Samples / Scripts to start Livy via port forwarding etc. (Edwin)
  - Helm modification to run Livy with Spot Tolerations (Christian)
     => See POD Templates https://spark.apache.org/docs/latest/running-on-kubernetes.html#pod-template
  - Creation of Ingress and Private Link Service  (Edwin)
     => https://docs.microsoft.com/en-us/azure/private-link/private-link-service-overview
  - Image optimization and deployment from Azure Container Registry (Lowest prio) 
     => Do not build in DockerFile! Copy Livy from release!
     => https://docs.microsoft.com/en-us/azure/container-registry/container-registry-private-link
