*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    DateTime

*** Variables ***
${dataFrom}    Star Wars
${AWSEndpoint}    https://37tc173it4.execute-api.eu-north-1.amazonaws.com/data?name=${dataFrom}
@{UCSByName}

*** Test Cases ***
Get sets
    ${requestStart}=    Get Current Date

    ${response}=    GET    ${AWSEndpoint}

    ${requestEnd}=    Get Current Date

    ${requestTime}=    Subtract Date From Date    ${requestEnd}    ${requestStart}
    
    ${body}=        Evaluate    $response.json()
    ${data}=    Set Variable    ${body["data"]}
    ${table}=    Set Variable   ${body["table"]}

    
    ${USCTheme}=    Create List

    FOR    ${item}    IN    @{body["data"]}
        IF    $item.get("subtheme") == "Ultimate Collector Series"
            Append To List    ${USCTheme}    ${item}
        END
    END


    ${count}=    Get Length    ${USCTheme}

    ${valentina}=    Evaluate    json.dumps($body, indent=4)    json

    Log To Console    \n${valentina}

    Should Be True    ${requestTime} < 5
        Log To Console    \n[1] Time to execute request: ${requestTime}

    Should Be True    ${count}>0
        Log To Console    \n[2] Objects in DATA field: ${count}
    
    Should Be Equal As Strings    ${table}    ${dataFrom}
        Log To Console    \n[3] Table property is OK

    Should Be Equal As Integers    ${response.status_code}    200
        Log To Console    \n[4] Returned status code is: ${response.status_code}
