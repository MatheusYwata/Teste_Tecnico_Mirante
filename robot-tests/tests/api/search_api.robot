*** Settings ***
Library    RequestsLibrary
Library    Collections
Suite Setup    Criar Sessao

*** Variables ***
${BASE_URL}    https://blog.agibank.com.br

*** Keywords ***
Criar Sessao
    Create Session    blog    ${BASE_URL}

*** Test Cases ***
Buscar artigos com termo válido deve retornar resultados
    ${response}=    GET On Session    blog    /wp-json/wp/v2/posts    params=search=mercado

    Should Be Equal As Integers    ${response.status_code}    200
    Should Not Be Empty    ${response.json()}

Buscar com termo inexistente deve retornar vazio
    ${response}=    GET On Session    blog    /wp-json/wp/v2/posts    params=search=xxxxxx123456

    Should Be Equal As Integers    ${response.status_code}    200
    Should Be Empty    ${response.json()}

Resposta deve conter campos obrigatórios
    ${response}=    GET On Session    blog    /wp-json/wp/v2/posts    params=search=mercado
    ${body}=    Set Variable    ${response.json()}

    Should Not Be Empty    ${body}

    Dictionary Should Contain Key    ${body[0]}    id
    Dictionary Should Contain Key    ${body[0]}    date
    Dictionary Should Contain Key    ${body[0]}    title
    Dictionary Should Contain Key    ${body[0]}    link