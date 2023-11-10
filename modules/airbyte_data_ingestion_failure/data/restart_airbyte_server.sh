#!/bin/bash

# Set variables
NAMESPACE=${NAMESPACE}
DEPLOYMENT=${DEPLOYMENT_NAME}

# Restart Airbyte server
kubectl rollout restart deployment/$DEPLOYMENT -n $NAMESPACE

# Check deployment status
STATUS=$(kubectl rollout status deployment/$DEPLOYMENT -n $NAMESPACE)

# Verify deployment status
if [[ $STATUS == *"successfully rolled out"* ]]; then
   echo "Airbyte server restarted successfully."
else
   echo "Airbyte server restart failed."
fi