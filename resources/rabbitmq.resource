*** Settings ***
Documentation         RabbitMQ Helper Api
Library               RequestsLibrary

*** Variables ***
${REBBITMQ_URL}        https://fuji.lmq.cloudamqp.com/api/queues/rtypuput/email
${REBBITMQ_TOKEN}      Basic cnR5cHVwdXQ6U0dKWFdGcnVqcFltUVo3NWUtWGFpM19wcmZuci10MGQ=
${EMPTY_PAYLOAD}       {}
&{RABBITMQ_HEADERS}    content-type=application/json    Authorization=${REBBITMQ_TOKEN}

*** Keywords ***
Purge Request
    ${headers}    Create Dictionary    &{RABBITMQ_HEADERS}

    ${response}   DELETE
    ...           ${REBBITMQ_URL}/contents
    ...           headers=${headers}
    ...           data=${EMPTY_PAYLOAD}
    RETURN        ${response}

*** Keywords ***
Get Messages
    ${payload}    Evaluate
    ...           {"count": 1, "ack_mode": "reject_requeue_true", "encoding": "auto", "truncate": 50000}

    ${headers}    Create Dictionary    &{RABBITMQ_HEADERS}

    ${response}   POST
    ...           url=${REBBITMQ_URL}/get
    ...           headers=${headers}
    ...           json=${payload}
    RETURN        ${response}

