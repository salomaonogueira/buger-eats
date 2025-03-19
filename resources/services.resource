*** Settings ***
Documentation         Camada de serviços

Library               RequestsLibrary
Resource              ../resources/base.resource

*** Variables ***
${URL_BASE}        http://localhost:3333/partners
&{HEADERS}         Content-Type=application/json
    ...            auth_user=qa
    ...            auth_password=ninja

${USERNAME}          administrador
${PASSWORD}          qaninja#123
${INVALID_USERNAME}  administrado
${INVALID_PASSWORD}  qaninja#1234

*** Keywords ***
POST Partner
    [Arguments]     ${payload}
    ${response}     POST    ${URL_BASE}
    ...             json=${payload}
    ...             headers=${HEADERS}
    ...             expected_status=any
    RETURN          ${response}

GET Partner
    ${response}     GET    ${URL_BASE}
    ...             headers=${HEADERS}
    ...             expected_status=any
    RETURN          ${response}

Search Partner
    [Arguments]    ${name}
    ${query}       Create Dictionary     name=${name}
    ${response}    GET    ${URL_BASE}    params=${query}
    ...            headers=${HEADERS}
    ...            expected_status=any
    RETURN         ${response}

Enable Partner
    [Arguments]    ${partner_id}
    ${response}    PUT    ${URL_BASE}/${partner_id}/enable
    ...            headers=${HEADERS}
    ...            expected_status=any
    RETURN         ${response}

Disable Partner
    [Arguments]     ${partner_id}
    ${response}     PUT    ${URL_BASE}/${partner_id}/disable
    ...             headers=${HEADERS}
    ...             expected_status=any
    RETURN          ${response}

Delete Partner
    [Arguments]    ${partner_id}
    ${response}    DELETE    ${URL_BASE}/${partner_id}
    ...            headers=${HEADERS}
    ...            expected_status=any
    RETURN         ${response}

Create Partner List
    ${partners}       Factory Partner List
    @{partner_ids}    Create List

    FOR  ${p}   IN   @{partners}
         ${response}       POST Partner      ${p}
         Status Should Be  201
         ${partner_id}     Set Variable      ${response.json()}[partner_id]
         Append To List    ${partner_ids}    ${partner_id}
    END

    Set Suite Variable     @{PARTNERS}       ${partners}
    Set Suite Variable     @{PARTNER_IDS}    ${partner_ids}

