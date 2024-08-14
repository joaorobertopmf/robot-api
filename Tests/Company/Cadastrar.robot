*** Settings ***
Documentation    Arquivo que comtém os testes de cadastro de uma empresa
Resource    ../../Resources/Company.resource
Library     RequestsLibrary

*** Test Cases ***
CT_CCA_P01 - Cadastrar empresa com sucesso   
    [Tags]    funcional    CT_CCA_P01
    [Setup]    Preparar para cadastrar empresa
    Logar como administrador
    Cadastrar empresa

CT_CCA_N01 - Cadastrar empresa com CNPJ existente
    [Tags]    nao-funcional    CT_CCA_N01
    [Setup]    Preparar para cadastrar empresa com CNPJ existente
    Cadastrar empresa com CNPJ existente