*** Settings ***
Library  RequestsLibrary
Library  String
Library    Collections

*** Keywords ***
Criar um usuário novo
    ${palavra_aleatoria}  Generate Random String  length=8  chars=[LETTERS]
    ${palavra_aleatoria}  Convert To Lower Case    ${palavra_aleatoria}
    Set Test Variable     ${EMAIL_TESTE}    ${palavra_aleatoria}@emailteste.com
    LOG  ${EMAIL_TESTE}

Cadastrar o usuário criado na ServerRest
    ${body}  Create Dictionary
    ...     nome=Fulano da Silva
    ...     email=${EMAIL_TESTE}
    ...     password=1234
    ...     administrador=true
    log     ${body}

    Criar sessão na ServerRest

    ${resposta}    POST On Session
    ...     alias=ServerRest
    ...     url=/usuarios
    ...     json=${body}
    log     ${resposta.json()}
    Set Test Variable    ${resposta}  ${resposta.json()}
    
Criar sessão na ServerRest
    ${headers}  Create Dictionary  accept=application/json    Content-Type=application/json
    Create Session    alias=ServerRest    url=https://serverest.dev  headers=${headers}

Conferir se o usuário foi cadastrado corretamente
    log     ${resposta}
    Dictionary Should Contain Item    ${resposta}    message    Cadastro realizado com sucesso
    Dictionary Should Contain Key     ${resposta}    _id