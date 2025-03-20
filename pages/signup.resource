*** Settings ***
Documentation         Ações e elementos da página de cadastro de parceiro

Resource              ../resources/base.resource

*** Variables ***
${NAME_INPUT}               css=input[name="name"]
${EMAIL_INPUT}              css=input[name="email"]
${WHATSAPP_INPUT}           css=input[name="whatsapp"]
${REGISTER_BUTTON}          css=button >> text=Cadastre-se
${CLOSE_BUTTON}             css=button >> text=Fechar

${PARTNER_NAME}             Super Ravena
${PARTNER_EMAIL}            super_ravena@email.com
${PARTNER_WHATSAPP}         11999999999
${PARTNER_BUSINESS}         Restaurante

${PARTNER_EMAIL_INV}        super_ravena.com
${PARTNER_WHATSAPP_INV}     119999999999
${PARTNER_BUSINESS_INV}     Eletrônicos

${ERROR_EMAIL_INVALID}       text=Oops! Email com formato inválido
${ERROR_PHONE_INVALID}       text=Oops! Whatsapp com formato incorreto
${ERROR_EMPTY_NAME}          text=Informe o nome do estabelecimento
${ERROR_EMPTY_EMAIL}         text=Informe um e-mail válido
${ERROR_EMPTY_PHONE}         text=Informe o whats da empresa
${ERROR_EMPTY_BUSINESS}      text=Selecione o tipo de negócio
${CONFIRM_DELETE_MESSAGE}    text=Você confirma desse parceiro?


*** Keywords ***
Go to form page
    New Browser      browser=chromium    headless=false
    New Page         http://localhost:3000/partner
    Set Strict Mode        on
    Set Browser Timeout    30s

Submit partner form
    [Arguments]    ${name}    ${email}    ${whatsapp}    ${business_type}

    Clear Text   ${NAME_INPUT}    # Limpa qualquer valor já presente
    Fill Text    ${NAME_INPUT}       ${name}
    Fill Text    ${EMAIL_INPUT}      ${email}
    Fill Text    ${WHATSAPP_INPUT}   ${whatsapp}
    Click        css=img[alt="${business_type}"]
    Wait For Elements State    ${REGISTER_BUTTON}    visible    10
    Click        ${REGISTER_BUTTON}
    Take Screenshot
