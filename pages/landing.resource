*** Settings ***
Documentation         Ações e elementos da página inicial

Resource              ../resources/base.resource

*** Variables ***
${LOGO_IMG}            img[alt="Buger Eats"]
${LOGIN_LINK}        a[href="/login"]
${PARTNER_BUTTON}      a[href="/partner"]


*** Keywords ***
Start session
    New Browser      browser=chromium    headless=false
    New Page         http://localhost:3000/

Validate H1 Text
    [Arguments]    ${expected_text}
    Wait For Elements State    h1    visible    5
    ${h1_text}    Get Text    h1
    Should Be Equal    ${h1_text}    ${expected_text}


Validate Main Buttons
    Wait For Elements State    ${LOGO_IMG}          visible
    Wait For Elements State    ${LOGIN_LINK}        visible
    Wait For Elements State    ${PARTNER_BUTTON}    visible
