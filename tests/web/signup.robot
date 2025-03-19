*** Settings ***
Documentation         Página de cadastro de parceiro

Resource              ../../resources/base.resource

Suite Teardown    Close Browser

*** Test Cases ***
Should create a new partner
    [Documentation]    Cadastra um parceiro com sucesso
    [Tags]    signup
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

Should not allow duplicate partner
    [Documentation]    Não permitir cadastrar parceiro já cadastrado
    [Tags]    signup
    Go to form page
    Submit partner form
    ...    ${PARTNER_NAME}
    ...    ${PARTNER_EMAIL}
    ...    ${PARTNER_WHATSAPP}
    ...    ${PARTNER_BUSINESS}

    Wait For Elements State    text=Oops...    visible    5
    Wait For Elements State    text=Parceiro já cadastrado!    visible    5
    Click    ${CLOSE_BUTTON}
    Take Screenshot

Should not allow invalid email
    [Documentation]    Não permitir cadastrar parceiro com parceiro com email inválido
    [Tags]    signup
    Go to form page
    Submit partner form
    ...    ${PARTNER_NAME}
    ...    ${PARTNER_EMAIL_INV}
    ...    ${PARTNER_WHATSAPP}
    ...    ${PARTNER_BUSINESS}

    Wait For Elements State    ${ERROR_EMAIL_INVALID}   visible    5
    Take Screenshot

Should not allow invalid phone number
    [Documentation]    Não permitir cadastrar parceiro com número inválido
    [Tags]    signup
    Go to form page
    Submit partner form
    ...    ${PARTNER_NAME}
    ...    ${PARTNER_EMAIL}
    ...    ${PARTNER_WHATSAPP_INV}
    ...    ${PARTNER_BUSINESS}

    Wait For Elements State    ${ERROR_PHONE_INVALID}  visible    5
    Take Screenshot

Should not allow empty fields
    [Documentation]    Não permitir cadastrar parceiro sem preenchimento
    [Tags]    signup
    Go to form page
    Click    ${REGISTER_BUTTON}
    Wait For Elements State    ${ERROR_EMPTY_NAME}      visible  5
    Wait For Elements State    ${ERROR_EMPTY_EMAIL}     visible  5
    Wait For Elements State    ${ERROR_EMPTY_PHONE}     visible  5
    Wait For Elements State    ${ERROR_EMPTY_BUSINESS}  visible  5
    Take Screenshot

Should delete a partner
    [Documentation]    Deletar parceiro
    [Tags]    admin
    Start Admin Session
    Fill Text    css=input[name="searchField"]    ${PARTNER_NAME}
    Click        text=Buscar
    Wait For Elements State
    ...    css=button[class="button button-danger"]    visible    5
    Take Screenshot
    Click    css=button[class="button button-danger"]
    Wait For Elements State
    ...      xpath=//h2[@id='swal2-title' and text()='${PARTNER_NAME}']
    ...      visible    1
    Wait For Elements State
    ...    ${CONFIRM_DELETE_MESSAGE}
    ...    visible    1
    Click    text=Sim, por favor!
    Take Screenshot