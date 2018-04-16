#!/bin/bash

#This command build the docker image to be run using the Dockerfile and local directories
docker build -t molnar/dds . 

echo "\n"
echo "Finished build, starting container...\n"
echo "\n"

#Starts the docker container, exposed port 443 and give the user a shell
docker run -it -p 443:443 molnar/dds