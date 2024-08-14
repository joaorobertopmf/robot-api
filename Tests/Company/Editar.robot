*** Settings ***
Documentation    Arquivo que comtém os testes de edição de uma empresa
Resource    ../../Resources/Company.resource
Library     RequestsLibrary

*** Test Cases ***
CT_CAT_P01 - Editar cadastro de empresa com sucesso
    [Tags]    funcional    CT_CAT_P01
    [Setup]    Preparar para editar empresa
    Editar cadastro de empresa com sucesso    

CT_CAT_N01 - Editar cadastro de empresa com corporatename vazio
    [Tags]    nao-funcional    CT_CAT_N01    
    [Setup]    Preparar para editar empresa
    Editar cadastro de empresa com corporatename vazio    