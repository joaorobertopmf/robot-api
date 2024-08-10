*** Settings ***
Library               Collections
Library               DateTime
Resource              Common.resource
Resource              Login.resource
Resource              Utils.resource

*** Variables ***
${BASE_URL}    https://chips.qacoders-academy.com.br
${ENDPOINT}    /api/company/
${COMPANY_ID}


*** Keywords ***
Preparar para cadastro
    Realizar Login    mail=sysadmin@qacoders.com    password=1234@Test
    
Preparar para edicao
    Preparar para cadastro
    Cadastrar empresa

Gerar endereco empresa
    ${state}         FakerBR.State Abbr
    ${zipCode}       FakerBR.Random Number    digits=8    fix_len=${true}
    ${city}          FakerBR.City
    ${district}      FakerBR.Neighborhood
    ${street}        FakerBR.StreetName
    ${number}        FakerBR.Random Number    digits=3    fix_len=${true}      
    ${country}       FakerBR.Current Country

    &{endereco}=    Create Dictionary    
    ...    zipCode=${zipCode}    
    ...    city=${city}
    ...    state=${state}    
    ...    district=${district}
    ...    street=${street}
    ...    number=${number}
    ...    complement=Nenhum
    ...    country=${country} 
    
    RETURN    &{endereco}

Gerar dados empresa
    ${corporateName}            FakerBR.Company
    ${registerCompany}          FakerBR.Cnpj
    ${mail}                     FakerBR.Email
    ${cidade}                   FakerBR.City 
    ${matriz}                   Set Variable    ${corporateName} - Unidade ${cidade}
    ${responsibleContact}       FakerBR.Name
    ${telephone}                Gerar numero de telephone
    ${randomNumber}             FakerBR.Random Number    digits=5    fix_len=${true}
    ${serviceDescription}       Set Variable    Serviço de teste ${randomNumber}   

    &{dadosEmpresa}    Create Dictionary    
    ...    corporateName=${corporateName} 
    ...    registerCompany=${registerCompany}
    ...    mail=${mail}
    ...    matriz=${matriz}
    ...    responsibleContact=${responsibleContact}
    ...    telephone=${telephone}
    ...    serviceDescription=${serviceDescription}
    
    RETURN    &{dadosEmpresa}

Gerar empresa
    &{endereco}    Gerar endereco empresa
    @{listaDeEnderecos}    Create List    ${endereco}

    &{empresa}    Gerar dados empresa
    Set To Dictionary    ${empresa}    address=${listaDeEnderecos}        

    #Log To Console    ${empresa}
    RETURN    ${empresa}   
    

Cadastrar empresa
    ${requestJson}    Gerar empresa
    ${response}    POST On Session    alias=sessao    url=https://chips.qacoders-academy.com.br/api/company/    json=${requestJson}    expected_status=201
    Set Suite Variable    ${COMPANY_ID}    ${response.json()}[newCompany][_id]
    Logar requisicoes    CT_CCA_P01 - Cadastrar empresa com sucesso    ${requestJson}    ${response.text}
    
Editar cadastro empresa com sucesso
    ${requestJson}    Gerar dados empresa  
    ${response}       PUT On Session    alias=sessao    url=https://chips.qacoders-academy.com.br/api/company/${COMPANY_ID}    json=${requestJson}    expected_status=201
    Logar requisicoes    CT_CAT_P01 - Editar cadastro de empresa com sucesso    ${requestJson}    ${response.text}

    Should Be Equal As Strings    ${response.json()}[msg]                  Companhia atualizada com sucesso.
    Should Be Equal As Strings    ${COMPANY_ID}                            ${response.json()}[updatedCompany][_id]
    Should Be Equal As Strings    ${requestJson}[corporateName]            ${response.json()}[updatedCompany][corporateName]
    Should Be Equal As Strings    ${requestJson}[registerCompany]          ${response.json()}[updatedCompany][registerCompany]
    Should Be Equal As Strings    ${requestJson}[responsibleContact]       ${response.json()}[updatedCompany][responsibleContact]
    Should Be Equal As Strings    ${requestJson}[mail]                     ${response.json()}[updatedCompany][mail]
    Should Be Equal As Strings    ${requestJson}[telephone]                ${response.json()}[updatedCompany][telephone]
    Should Be Equal As Strings    ${requestJson}[serviceDescription]       ${response.json()}[updatedCompany][serviceDescription]
    Should Be Equal As Strings    ${requestJson}[matriz]                   ${response.json()}[updatedCompany][matriz]
    Should Be Equal As Strings    ${requestJson}[serviceDescription]       ${response.json()}[updatedCompany][serviceDescription]  
    
Editar cadastro empresa com corporatename vazio
    ${requestJson}    Gerar dados empresa     
    Set To Dictionary    ${requestJson}    corporateName=${EMPTY}

    ${response}       PUT On Session    alias=sessao    url=https://chips.qacoders-academy.com.br/api/company/${COMPANY_ID}    json=${requestJson}

    Log To Console    \n------------ EDIÇÃO ------------
    Log To Console    ${response.text}
    Log To Console    -------------------------------\n
    
    Should Be Equal As Strings    ${response.json()}[msg]                  Companhia atualizada com sucesso.
    Should Be Equal As Strings    ${COMPANY_ID}                            ${response.json()}[updatedCompany][_id]
    Should Be Equal As Strings    ${requestJson}[corporateName]            ${response.json()}[updatedCompany][corporateName]
    Should Be Equal As Strings    ${requestJson}[registerCompany]          ${response.json()}[updatedCompany][registerCompany]
    Should Be Equal As Strings    ${requestJson}[responsibleContact]       ${response.json()}[updatedCompany][responsibleContact]
    Should Be Equal As Strings    ${requestJson}[mail]                     ${response.json()}[updatedCompany][mail]
    Should Be Equal As Strings    ${requestJson}[telephone]                ${response.json()}[updatedCompany][telephone]
    Should Be Equal As Strings    ${requestJson}[serviceDescription]       ${response.json()}[updatedCompany][serviceDescription]
    Should Be Equal As Strings    ${requestJson}[matriz]                   ${response.json()}[updatedCompany][matriz]
    Should Be Equal As Strings    ${requestJson}[serviceDescription]       ${response.json()}[updatedCompany][serviceDescription]    