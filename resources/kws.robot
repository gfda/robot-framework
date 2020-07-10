***Settings***
Documentation   Aqui teremos todas as keywords de automação dos comportamentos

***Keywords***
Dado que acesso a página principal
    Go To    http://ninjachef-qaninja-io.umbler.net/

Quando submeto o meu email "${email}"
    Input Text    id:email    ${email}
    Click Element    css:button[type=submit]

Então devo ser autenticado
    Wait Until Page Contains Element     class:dashboard

Então devo ver a mensagem "${expect_message}"
    Wait Until Element Contains    class:alert    ${expect_message}