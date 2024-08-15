*** Settings ***
Resource              Common.resource
Resource              Utils.resource
Library               Collections

*** Keywords ***
Logar como administrador
    Realizar Login    mail=sysadmin@qacoders.com    password=1234@Test

Realizar Login    
    [Arguments]    ${mail}    ${password}    
    ${requestJson}    Create Dictionary    mail=${mail}    password=${password}   
    ${response}    POST    url=${BASE_URL}/api/login    json=${requestJson}    expected_status=200        
    Logar requisicoes    ${requestJson}    ${response.text}
    
    Status Should Be    200
    Should Be Equal As Strings    ${response.json()}[user][mail]    ${mail}
    Dictionary Should Contain Key    ${response.json()}    token
    
    Criar sessao    token=${response.json()}[token]