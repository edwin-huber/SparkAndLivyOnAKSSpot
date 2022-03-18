# Spark And Livy On AKS Spot Instances

This repo is collating the work we are doing with a partner to enable their Spark / Livy pipeline to run on Azure Spot instances via AKS.

## Deployment and Configuration

  < Place Holder >  
  < Link to CLI and deployment scripts >
  
  https://spark.apache.org/docs/latest/running-on-kubernetes.html
  
 ## Next Steps / POC Items
  - Create private cluster with JIT access jump host behind bastion service (done)
  - Validate basic spark and livy operation in AKS using port forwarding - (done)
  - Image optimization and deployment from Azure Container Registry  
     => Do not build in DockerFile! Copy Livy from release!
     => https://docs.microsoft.com/en-us/azure/container-registry/container-registry-private-link
  - Helm modification to run Livy with Spot Tolerations  
     => See POD Templates https://spark.apache.org/docs/latest/running-on-kubernetes.html#pod-template
  - Creation of Ingress and Private Link Service  
     => https://docs.microsoft.com/en-us/azure/private-link/private-link-service-overview
