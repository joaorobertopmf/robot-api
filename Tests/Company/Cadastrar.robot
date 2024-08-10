*** Settings ***
Documentation    Arquivo que comtém os testes de cadastro de uma empresa
Resource    ../../Resources/Company.resource
Library     RequestsLibrary

*** Test Cases ***
CT_CCA_P01 - Cadastrar empresa com sucesso   
    [Tags]    funcional    CT_CCA_P01
    [Setup]    Logar como administrador
    Cadastrar empresa com sucesso

CT_CCA_N01 - Cadastrar empresa com CNPJ existente
    [Tags]    nao-funcional    CT_CCA_N01
    [Setup]   Criar massa de teste
    Cadastrar empresa com CNPJ existente