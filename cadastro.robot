***Settings***

Documentation   Suite dos testes de cadastro

Library         SeleniumLibrary

Test Setup    Open Session
Test Teardown    Close Session

***Test Cases***
Cadastro simples
    Dado que acesso a página principal
    Quando submeto o meu email "test@mail.com"
    Então devo ser autenticado

***Keywords***
Dado que acesso a página principal
    Go To    http://ninjachef-qaninja-io.umbler.net/

Quando submeto o meu email "${email}"
    Input Text    id:email    ${email}
    Click Element    css:button[type=submit]

Então devo ser autenticado
    Wait Until Page Contains Element     class:dashboard

## Hooks
Open Session
    Open Browser    about:blank    Chrome    executable_path=drivers/chromedriver

Close Session
    Close Browser