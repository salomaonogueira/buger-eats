*** Settings ***
Documentation         DELETE/partners
Resource              ../../resources/base.resource

*** Test Cases ***
Should remove a partner
    [Documentation]     Remove um parceiro e valida se o status retorna 204.
    [Tags]              remove partner
    ${partner}          Factory Remove Partner
    ${partner_id}       Create a new partner   ${partner}
    Delete Partner      ${partner_id}
    Status Should Be    204

Should return 404 on remove partner
    [Documentation]     Valida que não é possível remover um parceiro que não existe.
    [Tags]              remove partner
    ${partner}          Factory 404 Partner
    ${partner_id}       Create a new partner   ${partner}
    Delete Partner      ${partner_id}
    Delete Partner      ${partner_id}
    Status Should Be    404

