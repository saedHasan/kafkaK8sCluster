#!/bin/bash

PARENT_PATH=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd $PARENT_PATH/..

# Setup Kafka Strimzi Operator   
kubectl create -f https://strimzi.io/install/latest?namespace=kafka -n kafka

sleep 15

# Setup Kafka Cluster
kubectl apply -f ./resources/kafka.yaml -n kafka


./scripts/configure.sh