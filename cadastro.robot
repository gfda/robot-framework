***Settings***

Documentation   Suite dos testes de cadastro

Library    SeleniumLibrary

***Test Cases***
Cadastro simples
    Dado que acesso a página principal
    Quando submeto o meu email "test@mail.com"
    Então devo ser autenticado

***Keywords***
Dado que acesso a página principal
    Open Browser    http://ninjachef-qaninja-io.umbler.net/    Chrome   executable_path=drivers/chromedriver