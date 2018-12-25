#!/bin/bash

JET_REPO_PATH=$(git rev-parse --show-toplevel)

if [ $? -ne 0 ]; then
    exit $?
fi

xhost +

CONTAINER_ID=$(docker run -it -d -v $JET_REPO_PATH:/jet -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY -e NO_AT_BRIDGE=1 --privileged hoverjet/jet bash)
if [ $? -ne 0 ]; then
    exit $?
fi

xauth list | while read line; do docker exec -it $CONTAINER_ID xauth add $line; if [ $? -ne 0 ]; then
    echo '"^ Not actually an error" - Ben'
fi; done

docker exec -it $CONTAINER_ID bash

docker stop $CONTAINER_ID
