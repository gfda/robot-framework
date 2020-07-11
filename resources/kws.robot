***Settings***
Documentation   Aqui teremos todas as keywords de automação dos comportamentos

***Keywords***
Dado que acesso a página principal
    Go To    ${base_url}

Quando submeto o meu email "${email}"
    Input Text       ${INPUT_EMAIL}         ${email}
    Click Element    ${BTN_QUERO_COZINHAR}

Então devo ser autenticado
    Wait Until Page Contains Element     ${DIV_DASHBOARD}

Então devo ver a mensagem "${expect_message}"
    Wait Until Element Contains    ${DIV_ALERT}    ${expect_message}

## Cadastro de Pratos

Dado que "${produto}" é um dos meus pratos
    Set Test Variable    ${produto}

Quando eu faço o cadastro desse item
    Wait Until Element Is Visible    ${BTN_ADD}                 5
    Click Element                    ${BTN_ADD}
    Choose File                      ${INPUT_UPLOAD_IMG}        ${CURDIR}/images/${produto['img']}
    Input Text                       ${INPUT_NOME}              ${produto['nome']}
    Input Text                       ${INPUT_PRATO}             ${produto['tipo']}
    Input Text                       ${INPUT_PRECO}             ${produto['preco']}
    Click Element                    ${BTN_CADASTRAR}

Então devo ver este prato no meu dashboard
    Wait Until Element Contains      ${DIV_LISTA_PROD}          ${produto['nome']}