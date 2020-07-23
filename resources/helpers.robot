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

Get API Token
    [Arguments]     ${email}

    &{headers}=             Create Dictionary       Content-Type=application/json
    &{payload}=             Create Dictionary       email=${email}
    
    Create Session          api                     ${api_url}
    ${response}             Post Request            api     /sessions       data=${payload}     headers=${headers}
    Status Should Be        200                     ${response}

    ${token}      Convert To String       ${response.json()['_id']}
    [Return]      ${token}