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

# Cenário receber produto - via API -
Dado que "${email_cozinheiro}" é a minha conta de cozinheiro
    Set Test Variable       ${email_cozinheiro}

    &{headers}=             Create Dictionary       Content-Type=application/json
    &{payload}=             Create Dictionary       email=${email_cozinheiro}
    
    Create Session           api                    ${api_url}
    ${response}             Post Request            api     /sessions       data=${payload}     headers=${headers}
    Status Should Be        200                     ${response}

    ${token_cozinheiro}     Convert To String       ${response.json()['_id']}
    Set Test Variable       ${token_cozinheiro}

E "${email_cliente}" é o email do meu cliente
    Set Test Variable       ${email_cliente}

    &{headers}=             Create Dictionary       Content-Type=application/json
    &{payload}=             Create Dictionary       email=${email_cliente}
    
    Create Session           api                    ${api_url}
    ${response}             Post Request            api     /sessions       data=${payload}     headers=${headers}
    Status Should Be        200                     ${response}

    ${token_cliente}     Convert To String       ${response.json()['_id']}
    Set Test Variable       ${token_cliente}

E que "${produto}" está cadastrado no meu dashboard
    Set Test Variable       ${produto}

    &{payload}=             Create Dictionary       name=${produto}     plate=Massas    price=18.00
    ${image_file}=          Get Binary File         ../resources/images/nhoque.jpg
    &{files}=               Create Dictionary       thumbnail=${image_file}
    &{headers}=             Create Dictionary       user_id=${token_cozinheiro}

    Create Session          api                     ${api_url}
    ${response}             Post Request            api     /products       files=${files}      data=${payload}     headers=${headers}
    Status Should Be        200                     ${response}

    ${produto_id}           Convert To String       ${response.json()['_id']}
    Set Test Variable       ${produto_id}

    Go To                               ${base_url}
    Input Text                          ${INPUT_EMAIL}          ${email_cozinheiro}
    Click Element                       ${BTN_QUERO_COZINHAR}
    Wait Until Page Contains Element    ${DIV_DASHBOARD}

Quando o cliente solicita o preparo desse prato
    &{headers}=             Create Dictionary       Content-Type=application/json    user_id=${token_cliente}
    &{payload}=             Create Dictionary       payment=Dinheiro

    Create Session           api                    ${api_url}
    ${response}             Post Request            api     /products/${produto_id}/orders       data=${payload}     headers=${headers}
    Status Should Be        200                     ${response}

Então devo receber uma notificação de pedido desse produto
    ${mensagem_esp}=     Convert To String    ${email_cliente} está solicitando o preparo do seguinte prato: ${produto}.

    Wait Until Page Contains        ${mensagem_esp}     5

E posso aceitar ou rejeitar esse pedido

    Wait Until Page Contains    ACEITAR     5
    Wait Until Page Contains    REJEITAR    5