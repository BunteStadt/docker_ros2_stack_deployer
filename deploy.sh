#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Define the SSH IP addresses for the contexts
CONTEXT1="ssh://user@192.168.1.101"
CONTEXT2="ssh://user@192.168.1.102"
CONTEXT3="ssh://user@192.168.1.103"

# Define names for the contexts
CONTEXT1_NAME="remote-host-1"
CONTEXT2_NAME="remote-host-2"
CONTEXT3_NAME="remote-host-3"

# Define the paths to the docker-compose files
COMPOSE1="compose1.yaml"
COMPOSE2="compose2.yaml"
COMPOSE3="compose3.yaml"

# Create Docker contexts
echo "Creating Docker contexts..."
docker context create $CONTEXT1_NAME --docker "host=$CONTEXT1"
docker context create $CONTEXT2_NAME --docker "host=$CONTEXT2"
docker context create $CONTEXT3_NAME --docker "host=$CONTEXT3"

# Deploy the Docker Compose files on each context
echo "Deploying services..."
docker --context $CONTEXT1_NAME compose -f $COMPOSE1 up -d
docker --context $CONTEXT2_NAME compose -f $COMPOSE2 up -d
docker --context $CONTEXT3_NAME compose -f $COMPOSE3 up -d

echo "Deployment complete!"

# List running containers in each context
docker --context $CONTEXT1_NAME ps
docker --context $CONTEXT2_NAME ps
docker --context $CONTEXT3_NAME ps
