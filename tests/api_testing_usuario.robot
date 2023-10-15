*** Settings ***
Resource  ..//resources/api_testing_usuario.resource

*** Variables ***

*** Test Cases ***
Cenário 01: Cadastrar um novo usuário com sucesso na ServerRest
    Criar um usuário novo
    Cadastrar o usuário criado na ServerRest  email=${EMAIL_TESTE}  status-code-desejado=201
    Conferir se o usuário foi cadastrado corretamente

Cenário 02: Cadastrar um novo usuário já existente
    Criar um usuário novo
    Cadastrar o usuário criado na ServerRest  email=${EMAIL_TESTE}  status-code-desejado=201
    Vou repetir o cadastro
    Validar se o usuário foi cadastrado corretamente