*** Settings ***
Documentation         Ações e elementos da página de admin

Resource              ../resources/base.resource

*** Keywords ***
Validar Visibilidade dos Elementos
    Wait For Elements State    img[alt="Buger Eats"]       visible    5
    Wait For Elements State    text=Gestão de Parceiros    visible    5
    Wait For Elements State    css=input[placeholder="Busque por nome ou email..."]    visible    1
    Wait For Elements State    text=Buscar    visible    5
    Wait For Elements State    text=Status    visible    5
    Wait For Elements State    text=Nome      visible    5
    Wait For Elements State    xpath=//th[normalize-space(text())="Email"]    visible    5
    Wait For Elements State    text=Whatsapp  visible    5
    Wait For Elements State    xpath=//th[normalize-space(text())="Negócio"]  visible    5

Start Admin Session
    Start session
    Click    css=header a[href="/login"]
    Submit login form    administrador    qaninja#123
    Wait For Elements State    text=Gestão de Parceiros    visible    1

Cadastro de parceiro com sucesso
    Go to form page
    Submit partner form
    ...    ${PARTNER_NAME}
    ...    ${PARTNER_EMAIL}
    ...    ${PARTNER_WHATSAPP}
    ...    ${PARTNER_BUSINESS}

    Wait For Elements State    text=Bons negócios :)    visible    5
    Wait For Elements State    text=Enviamos um email de confirmação para: ${PARTNER_EMAIL}
    ...    visible    5
    Click    ${CLOSE_BUTTON}
    Take Screenshot

Search partner by name
    [Arguments]    ${search_value}
    Log     Searching for partner: ${search_value}

    Clear Text    css=input[name="searchField"]
    Fill Text    css=input[name="searchField"]    ${search_value}
    Click        text=Buscar
    Wait For Elements State    text=${search_value}    visible    5

    Log     Partner search completed successfully

Validate Input Placeholder
    [Arguments]    ${selector}    ${expected_placeholder}
    ${placeholder}    Get Attribute    ${selector}    placeholder
    Should Be Equal    ${placeholder}    ${expected_placeholder}
