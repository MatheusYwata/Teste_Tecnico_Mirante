*** Settings ***
Resource    ${CURDIR}/../resources/blog.resource
Resource    ${CURDIR}/../share/gherkin.resource
Resource    ${CURDIR}/../common/main.robot


Test Setup    Abrir o navegador
Test Teardown    Fechar o navegador

*** Test Cases ***

CT 01: Realizar busca de artigo com termo válido
    Dado que usuário clica na lupa de busca
    E digita termo de busca INSS
    Quando pressionar Enter
    Então o sistema exibe os resultados

CT 02: Realizar busca de artigo com termo inexistente
    Dado que usuário clica na lupa de busca
    E digita termo de busca inválido
    Quando pressionar Enter
    Então o sistema exibe a mensagem padrão para resultados não encontrados

CT 03: Realizar busca sem digitar nada
    Dado que usuário clica na lupa de busca
    E deixa o campo de busca vazio
    Quando pressionar Enter
    Então o sistema exibe página de resultados vazia

CT 04: Realizar busca com caracteres especiais
    Dado que usuário clica na lupa de busca
    E digita termo de busca com caracteres especiais
    Quando pressionar Enter
    Então o sistema exibe a mensagem padrão para resultados não encontrados

CT 05: Realizar busca digitando espaço vazio
    Dado que usuário clica na lupa de busca
    E digita termo de busca com espaço vazio
    Quando pressionar Enter
    Então o sistema exibe página de resultados vazia
    