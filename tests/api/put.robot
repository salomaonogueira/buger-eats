*** Settings ***
Documentation         PUT/partners
Resource              ../../resources/base.resource

*** Test Cases ***
Should enable a partner
    [Documentation]     Habilita um parceiro e valida se o status retornado é 200.
    [Tags]              enable partner
    ${partner}          Factory Enable Partner
    ${partner_id}       Create a new partner   ${partner}
    ${response}         Enable Partner         ${partner_id}
    Status Should Be    200
    Delete Partner      ${partner_id}
    Status Should Be    204

Should disable a partner
    [Documentation]     Desabilita um parceiro e valida se o status retornado é 200.
    [Tags]              disable partner
    ${partner}          Factory Disable Partner
    ${partner_id}       Create a new partner  ${partner}
    Enable Partner      ${partner_id}
    ${response}         Disable Partner       ${partner_id}
    Status Should Be    200
    Delete Partner      ${partner_id}
    Status Should Be    204

Should return 404 on enable a partner
    [Documentation]     Valida que não é possível habilitar um parceiro que não existe.
    [Tags]              enable partner
    ${partner}          Factory 404 Partner
    ${partner_id}       Create a new partner  ${partner}
    Delete Partner      ${partner_id}
    ${response}         Enable Partner        ${partner_id}
    Status Should Be    404

Should return 404 on disable a partner
    [Documentation]     Valida que não é possível desabilitar um parceiro que não existe.
    [Tags]              disable partner
    ${partner}          Factory 404 Partner
    ${partner_id}       Create a new partner  ${partner}
    Delete Partner      ${partner_id}
    ${response}         Disable Partner       ${partner_id}
    Status Should Be    404

Delete message from RabbitMQ
    [Documentation]     Deleta todas as mensagens da fila do RabbitMQ
    [Tags]              rabbitmq
    Get Messages
    Purge Request