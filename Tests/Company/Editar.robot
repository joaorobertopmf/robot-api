*** Settings ***
Documentation    Arquivo que comtém os testes de edição de uma empresa
Resource    ../../Resources/Company.resource
Resource    ../../Resources/Login.resource
Library     RequestsLibrary
Suite Setup    Logar como administrador

*** Test Cases ***
CT_CAT_P01 - Editar cadastro de empresa com sucesso
    [Tags]    funcional    CT_CAT_P01
    [Setup]    Cadastrar empresa
    Editar cadastro de empresa com sucesso    

CT_CAT_N01 - Editar cadastro de empresa com corporatename vazio
    [Tags]    nao-funcional    CT_CAT_N01    
    [Setup]    Cadastrar empresa
    Editar cadastro de empresa com corporatename vazio    