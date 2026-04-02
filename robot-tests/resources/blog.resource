*** Settings ***

Resource    ${CURDIR}/../common/main.robot

*** Variables ***

*** Variables ***
${URL}    https://blogdoagi.com.br/
${BROWSER}    chrome
${NO_RESULTS}    Lamentamos, mas nada foi encontrado para sua pesquisa, tente novamente com outras palavras.

*** Keywords ***
Abrir o navegador
    Open Browser    ${URL}    ${BROWSER}   
    Maximize Browser Window

Fechar o navegador
    Close Browser

Abrir busca
    Click Element    css:a[aria-label="Search button"]
    Sleep    3s
    Element Should Be Visible    //input[@id='search-field']

usuário clica na lupa de busca
    Wait Until Element Is Visible    //a[@aria-label='Search button']   timeout=20s
    Wait Until Keyword Succeeds    5x    5s
    ...    Abrir busca

digita termo de busca INSS
    Wait Until Element Is Visible    //input[@id='search-field']   timeout=10s
    Input Text    //input[@id='search-field']   INSS

digita termo de busca inválido
    Wait Until Element Is Visible    //input[@id='search-field']   timeout=10s
    Input Text    //input[@id='search-field']    asdasdasd123

pressionar Enter
    Press Keys    css:input[type="search"]    ENTER

o sistema exibe os resultados
    Wait Until Page Contains Element    css:article


o sistema exibe a mensagem padrão para resultados não encontrados
    Wait Until Page Contains    ${NO_RESULTS}   timeout=10s

deixa o campo de busca vazio
    Click Element    //input[@id='search-field']
    Clear Element Text    //input[@id='search-field']

o sistema exibe página de resultados vazia
     Wait Until Page Contains    Resultados encontrados para:

digita termo de busca com caracteres especiais
    Wait Until Element Is Visible    //input[@id='search-field']   timeout=10s
    Input Text    //input[@id='search-field']    @#$%^&*

digita termo de busca com espaço vazio
    Wait Until Element Is Visible    //input[@id='search-field']   timeout=10s
    Input Text    //input[@id='search-field']    "   "