***Settings***
Documentation       Receber pedidos
...                 Sendo um cozinheiro que possui produtos no dashbaord
...                 Quero receber solicitação de prepraro dos meus produtos
...                 Para que eu possa envia-los aos meus clientes

Resource        ../resources/base.robot

Library         RequestsLibrary
Library         OperatingSystem

Test Setup      Open Session
Test Teardown   Close Session

***Test Cases***
Receber novo pedido
    Dado que "test@mail.com" é a minha conta de cozinheiro
    E "test-client@mail.com" é o email do meu cliente
    E que "Nhoque Molho Paprica" está cadastrado no meu dashboard
    Quando o cliente solicita o preparo desse prato
    Então devo receber uma notificação de pedido desse produto
    E posso aceitar ou rejeitar esse pedido

***Keywords***
Dado que "${email_cozinheiro}" é a minha conta de cozinheiro
    Set Test Variable       ${email_cozinheiro}

    &{headers}=             Create Dictionary       Content-Type=application/json
    &{payload}=             Create Dictionary       email=${email_cozinheiro}
    
    Create Session           api                     http://ninjachef-api-qaninja-io.umbler.net
    ${response}             Post Request            api     /sessions       data=${payload}     headers=${headers}
    Status Should Be        200                     ${response}

    ${token_cozinheiro}     Convert To String       ${response.json()['_id']}
    Set Test Variable       ${token_cozinheiro}

E "${email_cliente}" é o email do meu cliente
    Set Test Variable       ${email_cliente}

    &{headers}=             Create Dictionary       Content-Type=application/json
    &{payload}=             Create Dictionary       email=${email_cliente}
    
    Create Session           api                     http://ninjachef-api-qaninja-io.umbler.net
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

    Create Session          api                     http://ninjachef-api-qaninja-io.umbler.net
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

    Create Session           api                     http://ninjachef-api-qaninja-io.umbler.net
    ${response}             Post Request            api     /products/${produto_id}/orders       data=${payload}     headers=${headers}
    Status Should Be        200                     ${response}

Então devo receber uma notificação de pedido desse produto
    ${mensagem_esp}=     Convert To String    ${email_cliente} está solicitando o preparo do seguinte prato: ${produto}.

    Wait Until Page Contains        ${mensagem_esp}     5

E posso aceitar ou rejeitar esse pedido

    Wait Until Page Contains    ACEITAR     5
    Wait Until Page Contains    REJEITAR    5