#!/bin/bash
set +x

# Parameters:
# $1: Path to the new truststore
# $2: Truststore password
# $3: Public key to be imported
# $4: Alias of the certificate
function create_truststore {
   keytool -keystore $1 -storepass $2 -noprompt -alias $4 -import -file $3 -storetype PKCS12
}

# Parameters:
# $1: Path to the new keystore
# $2: Truststore password
# $3: Public key to be imported
# $4: Private key to be imported
# $5: Alias of the certificate
function create_keystore {
   RANDFILE=/tmp/.rnd openssl pkcs12 -export -in $3 -inkey $4 -name $HOSTNAME -password pass:$2 -out $1
}

if [ "$CA_CRT" ];
then
    echo "Preparing truststore"
    export SMALLRYE_MESSAGING_SINK_TEST_TOPIC_SECURITY_PROTOCOL=SSL
    export SMALLRYE_MESSAGING_SINK_TEST_TOPIC_SSL_TRUSTSTORE_PASSWORD=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c32)
    echo "$CA_CRT" > /tmp/ca.crt
    create_truststore /tmp/truststore.p12 $SMALLRYE_MESSAGING_SINK_TEST_TOPIC_SSL_TRUSTSTORE_PASSWORD /tmp/ca.crt ca
    export SMALLRYE_MESSAGING_SINK_TEST_TOPIC_SSL_TRUSTSTORE_TYPE=PKCS12
    export SMALLRYE_MESSAGING_SINK_TEST_TOPIC_SSL_TRUSTSTORE_LOCATION=/tmp/truststore.p12
fi

if [[ "$USER_CRT" && "$USER_KEY" ]];
then
    echo "Preparing keystore"
    export SMALLRYE_MESSAGING_SINK_TEST_TOPIC_SECURITY_PROTOCOL=SSL
    export SMALLRYE_MESSAGING_SINK_TEST_TOPIC_SSL_KEYSTORE_PASSWORD=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c32)
    echo "$USER_CRT" > /tmp/user.crt
    echo "$USER_KEY" > /tmp/user.key
    create_keystore /tmp/keystore.p12 $SMALLRYE_MESSAGING_SINK_TEST_TOPIC_SSL_KEYSTORE_PASSWORD /tmp/user.crt /tmp/user.key /opt/kafka/cluster-certs/cluster-ca.crt $HOSTNAME
    export SMALLRYE_MESSAGING_SINK_TEST_TOPIC_SSL_KEYSTORE_TYPE=PKCS12
    export SMALLRYE_MESSAGING_SINK_TEST_TOPIC_SSL_KEYSTORE_LOCATION=/tmp/keystore.p12
fi

if [[ "$USERNAME" && "$PASSWORD" ]];
then
    echo "Preparing JAAS configurtion"
    export SMALLRYE_MESSAGING_SOURCE_TEST_TOPIC_SASL_MECHANISM=SCRAM-SHA-512
    export SMALLRYE_MESSAGING_SOURCE_TEST_TOPIC_SASL_JAAS_CONFIG="org.apache.kafka.common.security.scram.ScramLoginModule required username=\"${USERNAME}\" password=\"${PASSWORD}\";"
fi

exec $1
