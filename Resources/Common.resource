*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    ../Libraries/FakerBR.py

*** Variables ***
#${TOKEN}
&{HEADERS}
${BASE_URL}    https://chips.qacoders-academy.com.br

*** Keywords ***
Criar sessao
    [Arguments]    ${token}
    Set To Dictionary    ${HEADERS}    Content-Type=application/json    Authorization=${token}
    Create Session    sessao    url=${BASE_URL}    headers=${HEADERS}    verify=${True}
