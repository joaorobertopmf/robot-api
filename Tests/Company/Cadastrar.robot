*** Settings ***
Documentation    Arquivo que comtém os testes de cadastro de uma empresa
Resource    ../../Resources/Company.resource
Resource    ../../Resources/Login.resource
Library     RequestsLibrary
Suite Setup    Logar como administrador

*** Test Cases ***
CT_CCA_P01 - Cadastrar empresa com sucesso   
    [Tags]    funcional    CT_CCA_P01
    Cadastrar empresa

CT_CCA_N01 - Cadastrar empresa com CNPJ existente
    [Tags]    nao-funcional    CT_CCA_N01
    [Setup]    Cadastrar empresa
    Cadastrar empresa com CNPJ existente