# docker_ros2_stack_deployer
Used to deploy several ros2 docker container on different hosts.


This repo is a base to deploy a stack of ros2 docker containers on different hosts.  
It uses docker compose and docker context to deploy the containers on different hosts.

The Compose files are based on the individual repos, however some parameters are overwritten.

For example in the "local" compose.yaml the build is done locally with `context: .` which is now changes to build remotely from the git repo.

Also the volume mounts used for development are removed.

This is done by using the docker compose include and overwrite feature.

