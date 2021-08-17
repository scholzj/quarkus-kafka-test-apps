#!/bin/sh
set +x

if [[ "$USERNAME" && "$PASSWORD" ]];
then
    echo "Preparing JAAS configurtion"

    export MP_MESSAGING_INCOMING_CONSUMED_SASL_MECHANISM=SCRAM-SHA-512
    export MP_MESSAGING_INCOMING_CONSUMED_SASL_JAAS_CONFIG="org.apache.kafka.common.security.scram.ScramLoginModule required username=\"${USERNAME}\" password=\"${PASSWORD}\";"
elif [[ "$OAUTH_CLIENT_ID" && "$OAUTH_CLIENT_SECRET" ]];
then
    echo "Preparing OAUTHBEARER JAAS configuration"
    export MP_MESSAGING_INCOMING_CONSUMED_SASL_MECHANISM=OAUTHBEARER
    export MP_MESSAGING_INCOMING_CONSUMED_SASL_JAAS_CONFIG="org.apache.kafka.common.security.oauthbearer.OAuthBearerLoginModule required;"
    export MP_MESSAGING_INCOMING_CONSUMED_SASL_LOGIN_CALLBACK_HANDLER_CLASS="io.strimzi.kafka.oauth.client.JaasClientOauthLoginCallbackHandler"
fi

exec $1
