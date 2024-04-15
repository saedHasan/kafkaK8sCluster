#!/bin/bash

PARENT_PATH=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd $PARENT_PATH/..

kubectl delete -f ./resources/topics.yaml -n kafka 
kubectl delete -f ./resources/users.yaml -n kafka

kubectl delete -f ./resources/kafka.yaml -n kafka
kubectl delete -f https://strimzi.io/install/latest?namespace=kafka -n kafka


kubectl delete namespace kafka