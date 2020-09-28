#!/bin/sh
set +x

if [[ "$USERNAME" && "$PASSWORD" ]];
then
    echo "Preparing JAAS configurtion"

    export QUARKUS_KAFKA_STREAMS_SASL_MECHANISM=SCRAM-SHA-512
    export QUARKUS_KAFKA_STREAMS_SASL_JAAS_CONFIG="org.apache.kafka.common.security.scram.ScramLoginModule required username=\"${USERNAME}\" password=\"${PASSWORD}\";"
fi

exec $1
