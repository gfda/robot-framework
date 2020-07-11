***Settings***
Documentation   Aqui teremos a estrutura base do projeto, o selenium é importado aqui

Library     SeleniumLibrary

Resource    kws.robot
Resource    helpers.robot

***Keywords***
## Hooks
Open Session
    Open Browser    about:blank    Chrome    executable_path=../drivers/chromedriver

Close Session
    Close Browser