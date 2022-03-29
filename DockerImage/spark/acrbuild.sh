#!/bin/bash
CONTAINER_REGISTRY=<your-container-registry>
az acr build -t $CONTAINER_REGISTRY/spark:3.0.3 -r $CONTAINER_REGISTRY .
