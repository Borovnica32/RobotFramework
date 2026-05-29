*** Settings ***
Library    SeleniumLibrary

*** Keywords *** 
Log In User
    Go To    http://saturnmerkur.ddns.net/zverina/prijava
    Input Text        id:upime     testuser
    Input Password    id:passwd    testuser

    Click Element     xpath://button[contains(text(), "Log in")]

    Wait Until Page Contains   Glavana staran    10s
    Log To Console    User logged in
    Sleep    5s

Log Out User
    Go To    http://saturnmerkur.ddns.net/zverina/profil

    Wait Until Page Contains   Profile    10s

    Click Element    xpath://a[contains(text(), "Log out")]

    Wait Until Page Contains   Glavana staran    10s
    Log To Console    User logged out
    Sleep    5s

