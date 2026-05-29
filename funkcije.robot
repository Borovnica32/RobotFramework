*** Settings ***
Library    SeleniumLibrary
Library    Collections

*** Keywords *** 
Log In User
    Go To    http://saturnmerkur.ddns.net/zverina/prijava
    Input Text        id:upime     testuser
    Input Password    id:passwd    testuser

    Click Element     xpath://button[contains(text(), "Log in")]

    Wait Until Page Contains   Glavana staran    10s
    Log To Console    \nUser logged in
    Sleep    5s

Log Out User
    Go To    http://saturnmerkur.ddns.net/zverina/profil

    Wait Until Page Contains   Profile    10s

    Click Element    xpath://a[contains(text(), "Log out")]

    Wait Until Page Contains   Glavana staran    10s
    Log To Console    \nUser logged out
    Sleep    5s

List UCS Sets
    [Arguments]    ${data}    ${body}
    ${USCTheme}=    Create List

    FOR    ${item}    IN    @{data}
        IF    $item.get("subtheme") == "Ultimate Collector Series"
            Append To List    ${USCTheme}    ${item}
        END
    END

    ${count}=    Get Length    ${USCTheme}

    ${valentina}=    Evaluate    json.dumps($body, indent=4)    json

    Log To Console    \n${valentina}
    Log To Console    \nUCS Sets: ${count}

