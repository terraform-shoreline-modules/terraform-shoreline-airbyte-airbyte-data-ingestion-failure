
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Airbyte Data Ingestion Failure

Airbyte Data Ingestion Failure is a type of incident where Airbyte, an open-source data integration platform, fails to ingest data from one or more sources. This can happen due to several reasons such as connectivity issues, source API changes, incorrect configuration, or platform limitations. As a result, the data that needs to be ingested into the target system cannot be processed, which can cause delays, errors, or data loss. This type of incident requires immediate attention and resolution to ensure that the data pipeline is functioning correctly and the data is available for downstream applications.

### Parameters

```shell
export AIRBYTE_POD_NAME="PLACEHOLDER"
export AIRBYTE_SERVICE_NAME="PLACEHOLDER"
export DATABASE_POD_NAME="PLACEHOLDER"
export NAMESPACE="PLACEHOLDER"
export DEPLOYMENT_NAME="PLACEHOLDER"
```

## Debug

### Confirm that the Airbyte pod is running

```shell
kubectl get pods | grep ${AIRBYTE_POD_NAME}
```

### Check the logs of the Airbyte pod for any errors

```shell
kubectl logs ${AIRBYTE_POD_NAME}
```

### Verify that the Airbyte service is running

```shell
kubectl get services | grep ${AIRBYTE_SERVICE_NAME}
```

### Check the endpoints of the Airbyte service to ensure they're healthy

```shell
kubectl describe endpoints ${AIRBYTE_SERVICE_NAME}
```

### Confirm that any dependencies of the Airbyte service, such as a database, are also running

```shell
kubectl get pods | grep ${DATABASE_POD_NAME}
```

### Check the logs of the database pod for any errors

```shell
kubectl logs ${DATABASE_POD_NAME}
```

### Verify that the Airbyte pod has the correct environment variables set, such as database connection details

```shell
kubectl describe pod ${AIRBYTE_POD_NAME} | grep -A 10 "Environment:"
```

### Check the configuration files for the Airbyte pod and make sure they're correct

```shell
kubectl describe pod ${AIRBYTE_POD_NAME} | grep -A 10 "Volumes:"
```

## Repair

### Restart the Airbyte server and try the ingestion process again.

```shell
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
```