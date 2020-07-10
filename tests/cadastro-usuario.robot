***Settings***

Documentation    Suite dos testes de cadastro

Resource         ../resources/base.robot
Test Setup       Open Session
Test Teardown    Close Session

***Test Cases***
Cadastro simples
    Dado que acesso a página principal
    Quando submeto o meu email "test@mail.com"
    Então devo ser autenticado

Email incorreto
    Dado que acesso a página principal
    Quando submeto o meu email "test$mail.com"
    Então devo ver a mensagem "Oops. Informe um email válido!"

Email vazio
    Dado que acesso a página principal
    Quando submeto o meu email "${EMPTY}"
    Então devo ver a mensagem "Oops. Informe um email válido!"