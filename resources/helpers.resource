*** Settings ***
Documentation         helpers
Resource              ../resources/services.resource

*** Keywords ***
Create a new partner
    [Arguments]      ${partner}
    ${response}      POST Partner    ${partner}
    ${partner_id}    Set Variable    ${response.json()}[partner_id]
    RETURN           ${partner_id}

Delete Partner By Name
    [Arguments]         ${name}
    ${deleted_count}    Evaluate    delete_partner_by_name("${name}")    modules=resources.factories.partner
    Log To Console      Foram deletados: ${deleted_count} parceiros com nome "${name}"