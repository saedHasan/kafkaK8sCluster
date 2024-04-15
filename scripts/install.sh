#!/bin/bash

PARENT_PATH=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd $PARENT_PATH/..
    
kubectl create -f https://strimzi.io/install/latest?namespace=kafka -n kafka

# sleep 15

kubectl apply -f ./resources/kafka.yaml -n kafka

