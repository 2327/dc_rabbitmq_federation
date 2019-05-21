#!/usr/bin/env bash

. .env

rmq_url=localhost:15690
exchange=test


echo '"{
    \"properties\":{\"delivery_mode\":2},
    \"routing_key\":\"QueueName\",
    \"payload\":\"HI\",
    \"payload_encoding\":\"string\"
    }"' > payload.json


curl -v -u ${QUEUE_USER}:${QUEUE_PASS} -H "Accept: application/json" -H "Content-Type:application/json" -X POST -d @payload.json http://${rmq_url}/api/exchanges/${QUEUE_VHOST}/${exchange}/publish
# -s
