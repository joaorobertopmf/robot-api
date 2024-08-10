*** Settings ***
Documentation    Arquivo que comtém os testes de cadastro de uma empresa
Resource    ../../Resources/Company.resource
Library     RequestsLibrary


*** Variables ***
${ENDPOINT}    /api/login

*** Test Cases ***
CT_CCA_P01 - Cadastrar empresa com sucesso   
    [Tags]    funcional    CT_CCA_P01
    [Setup]    Preparar para cadastro
    
    Cadastrar empresa    
  
#CT_CAT_N01 - Editar cadastro de empresa com CNPJ já existente
#    [Tags]    nao-funcional
#    [Setup]    Preparar para edicao
#   
#    Editar cadastro empresa    registerCompany=${EMPTY}