*** Settings ***
Documentation         GET/partners
Resource              ../../resources/base.resource

Suite Setup           Create Partner List

*** Test Cases ***
Should create, search and delete a partner list
    [Documentation]     Cria, pesquisa e deleta uma lista de parceiros.
    [Tags]              partner list
    ${partners}       Set Variable    @{PARTNERS}
    ${partner_ids}    Set Variable    @{PARTNER_IDS}

    ${response}       GET Partner
    Status Should Be  200
    ${size}           Get Length    ${response.json()}
    Should Be True    ${size} > 0    ERRO: Nenhum parceiro encontrado na API!

    FOR    ${p}    IN    @{partners}
        ${search_response}    Search Partner    ${p}[name]
        Status Should Be      200

        ${search_json}    Set Variable      ${search_response.json()}
        ${size}           Get Length        ${search_json}
        Should Be True    ${size} > 0       ERRO: Parceiro com nome "${p}[name]" não encontrado!

        ${partner_id}     Set Variable      ${search_json}[0][_id]
        IF    "${partner_id}" not in @{partner_ids}
        Append To List    ${partner_ids}    ${partner_id}
    END

    END

    FOR    ${id}    IN    @{partner_ids}
        Delete Partner    ${id}
        Status Should Be  204
    END





