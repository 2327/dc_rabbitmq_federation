Rabbitmq federation setup example

**Scenario 1**
Your app has a connection to RabbitMQ Server A and uses virtual host named “Foo” but would like to consume a message from an exchange on RabbitMQ Server B which is using the default virtual host. In this situation all the federation configuration will be done on RabbitMQ Server A again. The only big different from scenario 1 is the virtual host needs to be specified in the ampq endpoint and upstream.

Federation Upstreams Setup.

    Navigate to Admin > Federation Upstreams
    Add a new upstream.
    Select Foo virtual host
    Enter a name for your upstream (will be used in next steps for policy)
    amqp://serverbname:port/%2F (the %2F is a ‘/’ which connects to the default virtual host)
    Click Add upstream.


**Scenario 2**

Your app has a connection to RabbitMQ Server A but would like to consume a message from an exchange on RabbitMQ Server B without managing multiple bus connections. In this situation all the federation configuration will be done on RabbitMQ Server A.

Federation Upstreams Setup.

    Navigate to Admin > Federation Upstreams
    Add a new upstream.
    Enter a name for your upstream (will be used in next steps for policy)
    amqp://serverbname:port next to URI.(use actual amqp endpoint)
    Click Add upstream.


**Federation Policy Setup.**

    Navigate to Admin > Policies > Add a policy.
    Enter a descriptive name next to “Name”
    In “Pattern” you want to use a regex to match the exchange name you want to consume messages from. (Example ^ExchangeNameYouWantToFederate$)
    choose “Exchanges” from the “Apply to” drop down list
    For “Policy” enter federation-upstream: [upstream name from setup above] “Policy”.
    Click Add policy.


**Load setting on boot**


**Test configuration**
```
curl -u guest:guest -H "content-type:application/json" \
    -X POST -d'{"properties":{"delivery_mode":2},"routing_key":"QueueName","payload":"HI","payload_encoding":"string"}' \
    http://localhost:MGMT_PORT/api/exchanges/%2f/amq.default/publish
```
