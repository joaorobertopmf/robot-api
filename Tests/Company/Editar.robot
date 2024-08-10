*** Settings ***
Documentation    Esse arquivo é ....
Resource    ../../Resources/Company.resource
Library     RequestsLibrary

*** Test Cases ***
CT_CAT_P01 - Editar cadastro de empresa com sucesso
    [Tags]    funcional    CT_CAT_P01    
    [Setup]    Criar massa de teste    
    Editar cadastro empresa com sucesso
    

#CT_CAT_N01 - Editar cadastro de empresa com CNPJ já existente
#    [Tags]    nao-funcional
#    [Setup]    Preparar para edicao   
    

CT_CAT_N01 - Editar cadastro de empresa com corporatename vazio
    [Tags]    nao-funcional    CT_CAT_N01    
    [Setup]    Criar massa de teste 
    Editar cadastro empresa com corporatename vazio    