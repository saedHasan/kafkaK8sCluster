Step 1 : Verify Installtion of dependencies: 

# Validate minikube
> minikube version

# Validate kubectl
> kubectl version

Step 2: Starting the Kubernetes cluster: 

# start minikube
> minikube start --memory=4096 # 2GB default memory isn't always enough

Step 3 : Deploy Strimzi using installation files: 

# Before deploying the Strimzi cluster operator, create a namespace called kafka:
> kubectl create namespace kafka

# apply the strmizi operator 

> kubectl create -f 'https://strimzi.io/install/latest?namespace=kafka' -n kafka

# Follow the deployment of the Strimzi cluster operator:

> kubectl get pod -n kafka

# if you want to check the deployment logs  use this command:
> kubectl logs strimzi-cluster-operator -n kafka -f

Step 4: Create an Apache Kafka cluster: 

> kubectl apply -f kafka.yaml -n kafka

# to check the pods status: 
> kubectl get pods -n kafka 
# Once everything is up and running, you can   see the Kafka broker service and the zookeeper service with these commands:
> kubectl get services -n  kafka 



