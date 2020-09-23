# Producer

## Configure

### Plain

```bash
export MP_MESSAGING_OUTGOING_PRODUCED_BOOTSTRAP_SERVERS=my-cluster-kafka-bootstrap-myproject.127.0.0.1.nip.io:443
```

### SSL

```bash
export MP_MESSAGING_OUTGOING_PRODUCED_SECURITY_PROTOCOL=SSL
export MP_MESSAGING_OUTGOING_PRODUCED_SSL_TRUSTSTORE_TYPE=JKS
export MP_MESSAGING_OUTGOING_PRODUCED_SSL_TRUSTSTORE_LOCATION=/Users/scholzj/development/strimzi-kafka-operator/hacking/truststore.jks
export MP_MESSAGING_OUTGOING_PRODUCED_SSL_TRUSTSTORE_PASSWORD=123456
export MP_MESSAGING_OUTGOING_PRODUCED_SSL_KEYSTORE_TYPE=PKCS12
export MP_MESSAGING_OUTGOING_PRODUCED_SSL_KEYSTORE_LOCATION=/Users/scholzj/development/strimzi-kafka-operator/hacking/user.p12
export MP_MESSAGING_OUTGOING_PRODUCED_SSL_KEYSTORE_PASSWORD=123456



export MP_MESSAGING_OUTGOING_PRODUCED_TOPIC_SASL_MECHANISM=
export MP_MESSAGING_OUTGOING_PRODUCED_TOPIC_SASL_JAAS_CONFIG=
```

## Run

## Dev mode

```bash
mvn quarkus:dev
```

## Local
```bash
$ mvn package -Pnative
$ ./target/kafka-producer-1.0.0-SNAPSHOT-runner
```
