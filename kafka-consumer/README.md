# Consumer

## Configure

### Plain

```bash
export MP_MESSAGING_INCOMING_CONSUMED_BOOTSTRAP_SERVERS=$(kubectl get kafka my-cluster -n my-kafka-project -o=jsonpath='{.status.listeners[?(@.type=="external")].bootstrapServers}{"\n"}')
```

### SSL

```bash
export MP_MESSAGING_INCOMING_CONSUMED_BOOTSTRAP_SERVERS=$(kubectl get kafka my-cluster -n my-kafka-project -o=jsonpath='{.status.listeners[?(@.type=="external")].bootstrapServers}{"\n"}')
export MP_MESSAGING_INCOMING_CONSUMED_SECURITY_PROTOCOL=SSL
export MP_MESSAGING_INCOMING_CONSUMED_SSL_TRUSTSTORE_TYPE=PKCS12
export MP_MESSAGING_INCOMING_CONSUMED_SSL_TRUSTSTORE_LOCATION=/tmp/truststore.p12
export MP_MESSAGING_INCOMING_CONSUMED_SSL_TRUSTSTORE_PASSWORD="verysecret"

kubectl -n my-kafka-project get secret my-cluster-cluster-ca-cert -o jsonpath={.data.'ca\.crt'} | base64 --decode > /tmp/ca.crt
keytool -keystore $MP_MESSAGING_INCOMING_CONSUMED_SSL_TRUSTSTORE_LOCATION -storepass $MP_MESSAGING_INCOMING_CONSUMED_SSL_TRUSTSTORE_PASSWORD -noprompt -alias ca -import -file /tmp/ca.crt -storetype PKCS12
```

### SASL

```bash
export MP_MESSAGING_INCOMING_CONSUMED_SASL_MECHANISM="SCRAM-SHA-512"
export MP_MESSAGING_INCOMING_CONSUMED_SASL_JAAS_CONFIG="org.apache.kafka.common.security.scram.ScramLoginModule required username=kafka-test-apps-consumer-sasl password=ZYkyubv3II1e;"
```

### Client auth

```bash
export MP_MESSAGING_INCOMING_CONSUMED_SSL_KEYSTORE_TYPE=PKCS12
export MP_MESSAGING_INCOMING_CONSUMED_SSL_KEYSTORE_LOCATION=/Users/scholzj/development/strimzi-kafka-operator/hacking/user.p12
export MP_MESSAGING_INCOMING_CONSUMED_SSL_KEYSTORE_PASSWORD="verysecret"
```

### OAuth

```bash
export MP_MESSAGING_INCOMING_CONSUMED_BOOTSTRAP_SERVERS=XXX
export MP_MESSAGING_INCOMING_CONSUMED_SECURITY_PROTOCOL=SASL_SSL
export MP_MESSAGING_INCOMING_CONSUMED_SASL_JAAS_CONFIG="org.apache.kafka.common.security.oauthbearer.OAuthBearerLoginModule required;"
export MP_MESSAGING_INCOMING_CONSUMED_SASL_LOGIN_CALLBACK_HANDLER_CLASS=io.strimzi.kafka.oauth.client.JaasClientOauthLoginCallbackHandler
export MP_MESSAGING_INCOMING_CONSUMED_SASL_CLIENT_CALLBACK_HANDLER_CLASS="io.strimzi.kafka.oauth.client.JaasClientOauthLoginCallbackHandler"
export MP_MESSAGING_INCOMING_CONSUMED_SSL_TRUSTSTORE_TYPE=JKS
export MP_MESSAGING_INCOMING_CONSUMED_SSL_TRUSTSTORE_LOCATION="/tmp/truststore.jks"
export MP_MESSAGING_INCOMING_CONSUMED_SSL_TRUSTSTORE_PASSWORD="password"

export MP_MESSAGING_INCOMING_CONSUMED_SASL_MECHANISM="OAUTHBEARER"
export OAUTH_TOKEN_ENDPOINT_URI="XXX"
export OAUTH_CLIENT_ID="team-a-consumer"
export OAUTH_CLIENT_SECRET="XXX"
export OAUTH_USERNAME_CLAIM="preferred_username"
export OAUTH_SSL_TRUSTSTORE_PASSWORD="password"
export OAUTH_SSL_TRUSTSTORE_LOCATION="/tmp/truststore.p12"
export OAUTH_SSL_TRUSTSTORE_TYPE=JKS
```

## Run

### Dev mode

```bash
mvn quarkus:dev
```

### Local
```bash
$ mvn package -Pnative
$ ./target/kafka-consumer-1.0.0-SNAPSHOT-runner
```
