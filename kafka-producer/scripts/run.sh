#!/bin/sh
set +x

if [[ "$USERNAME" && "$PASSWORD" ]];
then
    echo "Preparing JAAS configurtion"

    export MP_MESSAGING_OUTGOING_PRODUCED_SASL_MECHANISM=SCRAM-SHA-512
    export MP_MESSAGING_OUTGOING_PRODUCED_SASL_JAAS_CONFIG="org.apache.kafka.common.security.scram.ScramLoginModule required username=\"${USERNAME}\" password=\"${PASSWORD}\";"
fi

exec $1
