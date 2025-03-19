*** Settings ***
Documentation   POST/partners
Resource        ../../resources/base.resource

*** Test Cases ***
Should create a new partner
    [Documentation]  Cria um novo parceiro e valida se o status retornado é 201.
    [Tags]    new parner
    ${partner}           Factory New Partner
    ${response}          POST Partner    ${partner}
    Status Should Be     201
    ${partner_id}        Set Variable    ${response.json()}[partner_id]
    Delete Partner       ${partner_id}
    Status Should Be     204

Should return duplicate company name
    [Documentation]  Valida que não é possível criar um parceiro com nome já existente.
    [Tags]    duplicate company
    ${partner}        Factory Duplicate Name

    ${response}       POST Partner    ${partner}
    Status Should Be  201

    ${duplicate_response}  POST Partner    ${partner}
    Status Should Be  409
    Should Contain    ${duplicate_response.json()}[message]    Duplicate company name

    ${partner_id}     Set Variable    ${response.json()}[partner_id]
    Delete Partner    ${partner_id}
    Status Should Be  204
