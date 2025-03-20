*** Settings ***
Documentation         Página de administrador

Resource              ../../resources/base.resource

Suite Setup    Set Browser Timeout    60s
*** Test Cases ***
Should validate required admin fields
    [Documentation]    Validar campos obrigatórios
    [Tags]    admin

    Start Admin Session
    Validar Visibilidade dos Elementos
    Get Text    text=Gestão de Parceiros    ==    Gestão de Parceiros
    Validate Input Placeholder  css=input[placeholder="Busque por nome ou email..."]
    ...    Busque por nome ou email...
    Wait For Elements State     css=tr:first-child button.button-primary   enabled    10
    Wait For Elements State     xpath=(//button[@class="button button-danger"])[1]
    Take Screenshot

Should search partner by name
    [Documentation]    Pesquisa de parceiro por nome
    [Tags]    admin
    Cadastro de parceiro com sucesso
    Start Admin Session
    Search partner by name   ${PARTNER_NAME}
    Take Screenshot
    Click          text=Sair
    Take Screenshot

Should search partner by email
    [Documentation]    Pesquisa de parceiro por email
    [Tags]    admin
    Start Admin Session
    Fill Text    css=input[name="searchField"]    ${PARTNER_EMAIL}
    Click         text=Buscar
    Sleep    1
    Take Screenshot
    Click          text=Sair
    Take Screenshot

Should activate partner
    [Documentation]    Ativação de parceiro
    [Tags]    admin
    Start Admin Session
    Search partner by name    ${PARTNER_NAME}
    Take Screenshot
    Click    css=tr:first-child button.button-primary
    Wait For Elements State
    ...            text=Parceiro ativado com sucesso!
    ...            visible    10
    Click          text=Sair
    Take Screenshot

Should deactivate partner
    [Documentation]    Inativar de parceiro
    [Tags]    admin
    Start Admin Session
    Search partner by name    ${PARTNER_NAME}
    Take Screenshot
    Click    css=tr:first-child button.button-secondary
    Wait For Elements State
    ...            text=Parceiro inativado com sucesso!
    ...            visible    10
    Take Screenshot

Should cancel partner deletion
    [Documentation]    Desistir de deletar parceiro
    [Tags]    admin
    Start Admin Session
    Search partner by name    ${PARTNER_NAME}
    Take Screenshot
    Click    css=button[class="button button-danger"]
    Wait For Elements State
    ...      xpath=//h2[@id='swal2-title' and text()='${PARTNER_NAME}']
    ...      visible    10
    Wait For Elements State
    ...      text=Você confirma desse parceiro?
    ...      visible      10
    Click    text=Não
    Take Screenshot

Should delete partner
    [Documentation]    Deletar parceiro
    [Tags]    admin
    Start Admin Session
    Search partner by name    ${PARTNER_NAME}
    Take Screenshot
    Click    css=button[class="button button-danger"]
    Wait For Elements State
    ...      xpath=//h2[@id='swal2-title' and text()='${PARTNER_NAME}']
    ...      visible    10
    Wait For Elements State
    ...    text=Você confirma desse parceiro?
    ...    visible    10
    Click    text=Sim, por favor!
    Take Screenshot