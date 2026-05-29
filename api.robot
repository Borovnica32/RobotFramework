*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    DateTime
Resource   funkcije.robot

*** Variables ***
${dataFrom}    Samsonite
${AWSEndpoint}    https://37tc173it4.execute-api.eu-north-1.amazonaws.com/data?name=${dataFrom}
@{UCSByName}

*** Test Cases ***
Get sets
    ${requestStart}=    Get Current Date

    ${response}=    GET    ${AWSEndpoint}

    ${requestEnd}=    Get Current Date

    ${requestTime}=    Subtract Date From Date    ${requestEnd}    ${requestStart}
    
    ${body}=        Evaluate    $response.json()
    ${data}=    Set Variable    @{body["data"]}
    ${table}=    Set Variable   ${body["table"]}

    IF    $dataFrom == "Star Wars"
        List UCS Sets    ${body["data"]}    ${body}
    END

    ${countAll}=     Get Length    ${data}
    Log To Console    \nCounted ${countAll} elements

    Should Be True    ${requestTime} < 5
        Log To Console    \n[1] Time to execute request: ${requestTime}
    
    Should Be Equal As Strings    ${table}    ${dataFrom}
        Log To Console    \n[2] Table property is OK

    Should Be Equal As Integers    ${response.status_code}    200
        Log To Console    \n[3] Returned status code is: ${response.status_code}
