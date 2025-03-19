*** Settings ***
Documentation         Testes de Login
Resource              ../../resources/base.resource

Suite Teardown    Close Browser

*** Test Cases ***
Should login successfully
    [Documentation]    Valida o login com credenciais corretas
    [Tags]    login
    Go to login page
    Submit login form    ${USERNAME}    ${PASSWORD}
    Take Screenshot

Should not login with invalid username
    [Documentation]    Testa o login com um nome de usuário inválido
    [Tags]    login
    Go to login page
    Submit login form    ${INVALID_USERNAME}    ${PASSWORD}
    Validate Error Message    ${ERROR_LOGIN}     Usuário e/ou senha invalidos.
    Take Screenshot

Should not login with invalid password
    [Documentation]    Testa o login com senha incorreta
    [Tags]    login
    Go to login page
    Submit login form    ${USERNAME}    ${INVALID_PASSWORD}
    Validate Error Message    ${ERROR_LOGIN}     Usuário e/ou senha invalidos.
    Take Screenshot

Should not login with empty username
    [Documentation]    Testa o login com campo de nome de usuário vazio
    [Tags]    login
    Go to login page
    Submit login form    ${EMPTY}    ${PASSWORD}
    Validate Error Message    ${ERROR_USERNAME_REQUIRED}    Oops! Informe o nome de usuário.
    Take Screenshot

Should not login with empty password
    [Documentation]    Testa o login com campo de senha vazio
    [Tags]    login
    Go to login page
    Submit login form    ${USERNAME}    ${EMPTY}
    Validate Error Message    ${ERROR_PASSWORD_REQUIRED}    Oops! Informe a senha secreta.
    Take Screenshot

Should not login with empty fields
    [Documentation]    Testa o login com ambos os campos vazios
    [Tags]    login
    Go to login page
    Submit login form    ${EMPTY}    ${EMPTY}
    Validate Error Message    ${ERROR_USERNAME_REQUIRED}    Oops! Informe o nome de usuário.
    Take Screenshot
