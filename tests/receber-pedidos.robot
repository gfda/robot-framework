***Settings***
Documentation       Receber pedidos
...                 Sendo um cozinheiro que possui produtos no dashbaord
...                 Quero receber solicitação de prepraro dos meus produtos
...                 Para que eu possa envia-los aos meus clientes

Resource        ../resources/base.robot

Library         RequestsLibrary

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

    Log To Console          ${response.json()['_id']}
    
E "${email_cliente}" é o email do meu cliente
    Set Test Variable       ${email_cliente}

E que "${produto}" está cadastrado no meu dashboard
    Set Test Variable       ${produto}