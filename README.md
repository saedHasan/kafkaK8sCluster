# Step 1 : Verify Installtion of dependencies: 

 Validate minikube
> minikube version

Validate kubectl
> kubectl version

# Step 2: Starting the Kubernetes cluster: 

start minikube
> minikube start --memory=4096 # 2GB default memory isn't always enough

# Step 3 : Deploy Strimzi using installation files: 

Before deploying the Strimzi cluster operator, create a namespace called kafka:
> kubectl create namespace kafka

apply the strmizi operator 

> kubectl create -f 'https://strimzi.io/install/latest?namespace=kafka' -n kafka

Follow the deployment of the Strimzi cluster operator:

> kubectl get pod -n kafka

if you want to check the deployment logs  use this command:

> kubectl logs strimzi-cluster-operator -n kafka -f

# Step 4: Create an Apache Kafka cluster: 

> kubectl apply -f kafka.yaml -n kafka

to check the pods status: 

> kubectl get pods -n kafka 

Once everything is up and running, you can   see the Kafka broker service and the zookeeper service with these commands:

> kubectl get services -n  kafka 

# Step 5:Create user
> kubectl apply -f users.yaml -n kafka-st --validate=false

# Step 6: Create topics 
> kubectl apply -f topic.yaml -n kafka-st --validate=false

# Step 7: Get certificate for client and server

> kubectl get secret my-cluster-cluster-ca-cert -n kafka-st -o jsonpath="{.data.ca\.p12}" | base64 --decode > ca.p12

<!-- save the file ca.p12 and  passphrase in a secure place --> 
# Step 8: Get the cert password decoded 

> kubectl get secret my-cluster-cluster-ca-cert -n kafka-st -o jsonpath="{.data.ca\.password}" | base64 -d

# Step 9: get the pass for my-user created: 

> kubectl get secret my-user -n kafka-st -o jsonpath="{.data.password}" | base64 -d

# Step 10: Since we are using loadbalancer in kafka cluster listner, we need to run below command in a separate  terminal window: 
> minikube tunnel

# Step 11: Conffigure the client code with below  details as an example if you want to connect to broker from code level. 

        properties.put(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG, "127.0.0.1:9094");
        properties.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG, "org.apache.kafka.common.serialization.StringSerializer");
        properties.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG, "org.apache.kafka.common.serialization.StringSerializer");
        properties.put(CommonClientConfigs.SECURITY_PROTOCOL_CONFIG, "SASL_SSL");
        properties.put(SslConfigs.SSL_TRUSTSTORE_PASSWORD_CONFIG,"past-ca-password-here");
        properties.put(SslConfigs.SSL_TRUSTSTORE_LOCATION_CONFIG, "PATH-TO-CA/ca.p12");
        properties.put(SaslConfigs.SASL_MECHANISM, "SCRAM-SHA-512");
        properties.put(SaslConfigs.SASL_JAAS_CONFIG, "org.apache.kafka.common.security.scram.ScramLoginModule required username=\"PAST-USER-NAME-HERE\" password=\"PAST-USER-PASS-HERE\";");



