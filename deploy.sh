#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e


# Create Docker contexts
echo "Creating Docker contexts..."

# Remove existing Docker contexts if they exist
for context in local robot hades; do
    if docker context ls --format '{{.Name}}' | grep -q "^${context}$"; then
        docker context rm "${context}" > /dev/null 2>&1
    fi
done

##################################################################################################
# Create new remote hosts here
##################################################################################################
# Create new Docker contexts to execute the Docker Compose files on remote hosts

docker context create local
docker context create robot --docker "host=ssh://robot@192.168.1.101"
docker context create hades --docker "host=ssh://hades@192.168.1.101"



# Deploy the Docker Compose files on each context
echo "Deploying services..."

docker context use local
docker compose -f compose_local.yaml up -d

docker context use robot
docker compose -f compose_robot.yaml up -d

docker context use hades
docker compose -f compose_hades.yaml up -d

docker context use default
echo "Deployment complete!"