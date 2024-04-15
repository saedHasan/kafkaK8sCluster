#!/bin/bash

PARENT_PATH=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd $PARENT_PATH/..

# Set Topics
kubectl apply -n kafka -f ./resources/topics.yaml 

# Set Users
kubectl apply -n kafka -f ./resources/users.yaml 
