***Settings***
Documentation   Palavras chaves de apoio

***Keywords***
Login Session
    [Arguments]    ${email}
    
    base.Open Session

    Go To                               ${base_url}
    Input Text                          ${INPUT_EMAIL}          ${email}
    Click Element                       ${BTN_QUERO_COZINHAR}
    Wait Until Page Contains Element    ${DIV_DASHBOARD}