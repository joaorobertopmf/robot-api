*** Settings ***
Library               Collections
Library               DateTime
Resource              Common.resource
Resource              Utils.resource

*** Variables ***
${COMPANY_ID}
${CNPJ}


*** Keywords ***
Gerar endereco empresa
    ${state}         FakerBR.State Abbr
    ${zipCode}       FakerBR.Postcode    numbers_only=${True}
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
    &{endereco1}    Gerar endereco empresa
    &{endereco2}    Gerar endereco empresa
    &{endereco3}    Gerar endereco empresa
    @{listaDeEnderecos}    Create List    ${endereco1}    ${endereco2}    ${endereco3}

    &{empresa}    Gerar dados empresa
    Set To Dictionary    ${empresa}    address=${listaDeEnderecos}        

    RETURN    ${empresa}   

Cadastrar empresa
    ${requestJson}    Gerar empresa
    ${response}    POST On Session    alias=sessao    url=${BASE_URL}/api/company    json=${requestJson}    expected_status=201    
    Set Test Variable    ${COMPANY_ID}    ${response.json()}[newCompany][_id]
    Set Test Variable    ${CNPJ}    ${response.json()}[newCompany][registerCompany]

    Logar requisicoes    ${requestJson}    ${response.text}

    Should Be Equal As Strings        ${response.json()}[msg]                  Olá a companhia ${requestJson}[corporateName] foi cadastrada com sucesso.
    Should Be Equal As Strings        ${requestJson}[corporateName]            ${response.json()}[newCompany][corporateName]
    Should Be Equal As Strings        ${requestJson}[registerCompany]          ${response.json()}[newCompany][registerCompany]
    Should Be Equal As Strings        ${requestJson}[responsibleContact]       ${response.json()}[newCompany][responsibleContact]
    Should Be Equal As Strings        ${requestJson}[mail]                     ${response.json()}[newCompany][mail]
    Should Be Equal As Strings        ${requestJson}[telephone]                ${response.json()}[newCompany][telephone]
    Should Be Equal As Strings        ${requestJson}[serviceDescription]       ${response.json()}[newCompany][serviceDescription]
    Should Be Equal As Strings        ${requestJson}[matriz]                   ${response.json()}[newCompany][matriz]
    Dictionary Should Contain Key     dictionary=${response.json()}[newCompany]    key=_id
    
    FOR    ${index}    ${address}    IN ENUMERATE    ${requestJson}[address]        
        Should Be Equal As Strings    ${address}[${index}][zipCode]             ${response.json()}[newCompany][address][${index}][zipCode]
        Should Be Equal As Strings    ${address}[${index}][city]                ${response.json()}[newCompany][address][${index}][city]
        Should Be Equal As Strings    ${address}[${index}][state]               ${response.json()}[newCompany][address][${index}][state]
        Should Be Equal As Strings    ${address}[${index}][district]            ${response.json()}[newCompany][address][${index}][district]
        Should Be Equal As Strings    ${address}[${index}][street]              ${response.json()}[newCompany][address][${index}][street]
        Should Be Equal As Strings    ${address}[${index}][number]              ${response.json()}[newCompany][address][${index}][number]
        Should Be Equal As Strings    ${address}[${index}][complement]          ${response.json()}[newCompany][address][${index}][complement]
        Should Be Equal As Strings    ${address}[${index}][country]             ${response.json()}[newCompany][address][${index}][country]    
    END 

Cadastrar empresa com CNPJ existente
    ${requestJson}    Gerar empresa
    Set To Dictionary    ${requestJson}    registerCompany=${CNPJ} 
    ${response}    POST On Session    alias=sessao    url=${BASE_URL}/api/company    json=${requestJson}    expected_status=400    
    Logar requisicoes    ${requestJson}    ${response.text}

    Should Be Equal As Strings    ${response.json()}[alert][0]    Essa companhia já está cadastrada. Verifique o nome, CNPJ e a razão social da companhia.
    
Editar cadastro de empresa com sucesso
    ${requestJson}    Gerar dados empresa  
    ${response}       PUT On Session    alias=sessao    url=${BASE_URL}/api/company/${COMPANY_ID}    json=${requestJson}    expected_status=201
    Logar requisicoes    ${requestJson}    ${response.text}

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
    
Editar cadastro de empresa com corporatename vazio
    ${requestJson}    Gerar dados empresa     
    Set To Dictionary    ${requestJson}    corporateName=${EMPTY}

    ${response}       PUT On Session    alias=sessao    url=${BASE_URL}/api/company/${COMPANY_ID}    json=${requestJson}
    Logar requisicoes    ${requestJson}    ${response.text}

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