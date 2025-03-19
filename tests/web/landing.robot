*** Settings ***
Documentation         Página inicial
Resource              ../../resources/base.resource

Suite Setup           Start session
Suite Teardown        Close Browser


*** Test Cases ***
Should validate homepage elements
    [Documentation]    Valida os principais elementos da página inicial
    Validate H1 Text    Seja parceiro do Buger Eats
    Get Text    main p    Equal    Clientes a um clique de distância e seu negócio vendendo como nunca.
    Validate Main Buttons
    Take Screenshot

Should navigate to partner registration
    [Documentation]    Verifica a navegação até a página de cadastro
    Click    main a[href="/partner"]
    Wait For Elements State    h1    visible
    ${texto_h1}    Get Text    h1
    Should Contain    ${texto_h1}    Um mundo de usuários
    Should Contain    ${texto_h1}    agora ao seu alcance
    Take Screenshot
    Close Browser

Should redirect to login page
    [Documentation]    Testa o redirecionamento para a página de login
    Start session
    Click    css=header a[href="/login"]
    Wait For Elements State    h1    visible
    Validate H1 Text    Login
    Take Screenshot
