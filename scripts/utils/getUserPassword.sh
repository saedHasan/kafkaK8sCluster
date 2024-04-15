#!/bin/bash

PARENT_PATH=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd $PARENT_PATH/../..


USER_NAME=$1

if [ -z "$USER_NAME" ]
then
    echo "Please provide a user name"
    exit 1
fi

kubectl get secret $USER_NAME -n kafka -o jsonpath="{.data.password}" | base64 --decode > ./artifacts/passwords/$USER_NAME.txt