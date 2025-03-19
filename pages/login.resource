*** Settings ***
Documentation         Ações e elementos da página de cadastro de parceiro

Resource              ../resources/base.resource

*** Variables ***
${LOGIN_BUTTON}                css=button >> text=Entrar
${USERNAME_INPUT}              css=input[name="username"]
${PASSWORD_INPUT}              css=input[name="password"]
${ERROR_LOGIN}                 css=#page-login > div > main > form > div > span
${ERROR_USERNAME_REQUIRED}     css=#page-login > div > main > form > div > span
${ERROR_PASSWORD_REQUIRED}     css=#page-login > div > main > form > div > span


*** Keywords ***
Go to page
    [Arguments]    ${url}
    New Browser      browser=chromium    headless=false
    New Page         ${url}

Go to login page
    Go to page    http://localhost:3000/login

Submit login form
    [Arguments]    ${username}    ${password}

    Clear Text    ${USERNAME_INPUT}
    Fill Text     ${USERNAME_INPUT}    ${username}
    Clear Text    ${PASSWORD_INPUT}
    Fill Text     ${PASSWORD_INPUT}    ${password}
    Click         ${LOGIN_BUTTON}

Validate Error Message
    [Arguments]    ${selector}    ${expected_message}

    Wait For Elements State    ${selector}    visible    5
    ${message}    Get Text     ${selector}
    Should Be Equal    ${message}    ${expected_message}


