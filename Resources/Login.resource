*** Settings ***
Resource              Common.resource
Resource              Utils.resource
Library               Collections

*** Keywords ***
Realizar Login    
    [Arguments]    ${mail}    ${password}    
    ${requestJson}    Create Dictionary    mail=${mail}    password=${password}
    
    ${response}    POST    url=${BASE_URL}/api/login    json=${requestJson}    expected_status=200        
    Set Suite Variable    ${TOKEN}    ${response.json()}[token] 
    Logar requisicoes    CT_ALA_P01 - Login admin com sucesso    ${requestJson}    ${response.text}
    
    Status Should Be    200
    Should Be Equal As Strings    ${response.json()}[user][mail]    ${mail}
    Dictionary Should Contain Key    ${response.json()}    token
    
    Criar sessao