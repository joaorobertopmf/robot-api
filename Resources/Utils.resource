*** Settings ***
Documentation    Arquivo keywords utilitárias

*** Keywords ***
Gerar numero de telephone
    ${codigoBrasil}    Set Variable    55
    @{ddds}    Create List    
    ...    11    12    13    14    15    16    17    18    19    21    22    24    27    28    31    32
    ...    33    34    35    37    38    41    42    43    44    45    46    47    48    49    51    53
    ...    54    55    61    62    63    64    65    66    67    68    69    71    73    74    75    77
    ...    79    81    82    83    84    85    86    87    88    89    91    92    93    94    95    96    
    ...    97    98    99
        
    ${tamanhoLista}    Get Length    ${ddds}
    ${numeroAleatorio}    Evaluate    random.randint(0, ${tamanhoLista} - 1)
    ${ddd_aleatorio}    Set Variable    ${ddds}[${numeroAleatorio}]

    #${noveDigitos}    FakerLibrary.Random Number    digits=9    fix_len=true   
    ${noveDigitos}    Set Variable    9
    FOR    ${counter}    IN RANGE    0    9
        ${numAleatorio}    Evaluate    random.randint(0, 9)
        ${noveDigitos}    Set Variable    ${noveDigitos}${numAleatorio}        
    END

    #Log To Console     *** ${codigoBrasil}${ddd_aleatorio}${noveDigitos} ***

    RETURN    ${codigoBrasil}${ddd_aleatorio}${noveDigitos}

Logar requisicoes    
    [Arguments]    ${nomeCasoTeste}    ${requestBody}    ${responseBody}
    Log To Console    \n------------ ${nomeCasoTeste} ------------
    Log To Console    => REQUEST BODY\n
    Log To Console    ${requestBody}\n\n
    Log To Console    => RESPONSE BODY\n
    Log To Console    ${responseBody}
    Log To Console    \n\n\n    