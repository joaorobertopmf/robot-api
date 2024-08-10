*** Settings ***
Resource    ../../Resources/Login.resource

*** Test Cases ***
CT_ALA_P01 - Login admin com sucesso
    Realizar Login    mail=sysadmin@qacoders.com    password=1234@Test    