# Consumer

## Configure

### Plain

```bash
export MP_MESSAGING_INCOMING_CONSUMED_BOOTSTRAP_SERVERS=$(kubectl get kafka my-cluster -n my-kafka-project -o=jsonpath='{.status.listeners[?(@.type=="external")].bootstrapServers}{"\n"}')
```

### SSL

```bash
export MP_MESSAGING_INCOMING_CONSUMED_SECURITY_PROTOCOL=SSL
export MP_MESSAGING_INCOMING_CONSUMED_SSL_TRUSTSTORE_TYPE=JKS
export MP_MESSAGING_INCOMING_CONSUMED_SSL_TRUSTSTORE_LOCATION=/Users/scholzj/development/strimzi-kafka-operator/hacking/truststore.jks
export MP_MESSAGING_INCOMING_CONSUMED_SSL_TRUSTSTORE_PASSWORD=123456
export MP_MESSAGING_INCOMING_CONSUMED_SSL_KEYSTORE_TYPE=PKCS12
export MP_MESSAGING_INCOMING_CONSUMED_SSL_KEYSTORE_LOCATION=/Users/scholzj/development/strimzi-kafka-operator/hacking/user.p12
export MP_MESSAGING_INCOMING_CONSUMED_SSL_KEYSTORE_PASSWORD=123456
```

### SASL

```bash
export MP_MESSAGING_INCOMING_CONSUMED_SASL_MECHANISM="SCRAM-SHA-512"
export MP_MESSAGING_INCOMING_CONSUMED_SASL_JAAS_CONFIG="org.apache.kafka.common.security.scram.ScramLoginModule required username=kafka-test-apps-consumer-sasl password=ZYkyubv3II1e;"
```

### OAuth

```bash
export MP_MESSAGING_INCOMING_CONSUMED_SASL_MECHANISM="OAUTHBEARER"
export MP_MESSAGING_INCOMING_CONSUMED_SASL_JAAS_CONFIG="org.apache.kafka.common.security.oauthbearer.OAuthBearerLoginModule required unsecuredLoginStringClaim_sub=alice;"
```

## Run

### Dev mode

```bash
mvn quarkus:dev
```

### Local
```bash
$ mvn package -Pnative
$ ./target/kafka-producer-1.0.0-SNAPSHOT-runner
```
