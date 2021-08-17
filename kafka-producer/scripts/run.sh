#!/bin/sh
set +x

if [[ "$USERNAME" && "$PASSWORD" ]];
then
    echo "Preparing SCRAM-SHA-512 JAAS configuration"

    export MP_MESSAGING_OUTGOING_PRODUCED_SASL_MECHANISM=SCRAM-SHA-512
    export MP_MESSAGING_OUTGOING_PRODUCED_SASL_JAAS_CONFIG="org.apache.kafka.common.security.scram.ScramLoginModule required username=\"${USERNAME}\" password=\"${PASSWORD}\";"
elif [[ "$OAUTH_CLIENT_ID" && "$OAUTH_CLIENT_SECRET" ]];
then
    echo "Preparing OAUTHBEARER JAAS configuration"
    export MP_MESSAGING_OUTGOING_PRODUCED_SASL_MECHANISM=OAUTHBEARER
    export MP_MESSAGING_OUTGOING_PRODUCED_SASL_JAAS_CONFIG="org.apache.kafka.common.security.oauthbearer.OAuthBearerLoginModule required;"
    export MP_MESSAGING_OUTGOING_PRODUCED_SASL_LOGIN_CALLBACK_HANDLER_CLASS="io.strimzi.kafka.oauth.client.JaasClientOauthLoginCallbackHandler"
fi

exec $1
