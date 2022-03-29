#!/bin/bash
CONTAINER_REGISTRY=<your-container-registry>
az acr build -t $CONTAINER_REGISTRY/livy:1.0 -r $CONTAINER_REGISTRY .
