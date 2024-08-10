*** Settings ***
Documentation    Esse arquivo é ....
Resource    ../../Resources/Company.resource
Library     RequestsLibrary


*** Variables ***
${BASE_URL}    https://chips.qacoders-academy.com.br
${ENDPOINT}    /api/login

*** Test Cases ***
CT_CAT_P01 - Editar cadastro de empresa com sucesso
    [Tags]    funcional    CT_CAT_P01    
    [Setup]    Preparar para edicao    
    
    Editar cadastro empresa com sucesso
    

#CT_CAT_N01 - Editar cadastro de empresa com CNPJ já existente
#    [Tags]    nao-funcional
#    [Setup]    Preparar para edicao
#   
#    Editar cadastro empresa    registerCompany=${EMPTY}

CT_CAT_N01 - Editar cadastro de empresa com corporatename vazio
    [Tags]    nao-funcional    CT_CAT_N01    
    [Setup]    Preparar para edicao 

    Editar cadastro empresa com corporatename vazio    