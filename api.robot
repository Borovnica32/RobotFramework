*** Settings ***
Library    RequestsLibrary
Library    DateTime

*** Variables ***
${dataFrom}    Star Wars
${AWSEndpoint}    https://37tc173it4.execute-api.eu-north-1.amazonaws.com/data?name=${dataFrom}

*** Test Cases ***
Get Users
    ${requestStart}=    Get Current Date

    ${response}=    GET    ${AWSEndpoint}

    ${requestEnd}=    Get Current Date

    ${requestTime}=    Subtract Date From Date    ${requestEnd}    ${requestStart}
    Log To Console    \nTime to execute request: ${requestTime}
    Should Be True    ${requestTime} < 5


    Should Be Equal As Integers    ${response.status_code}    200
    